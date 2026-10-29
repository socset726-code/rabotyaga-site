import { randomBytes } from "crypto";
import { db } from "./db";
import { now } from "./keys";

export type Msg = { from: "user" | "admin"; text: string; at: number };
export type Ticket = {
  id: string;
  contact?: string;
  ref?: string; // номер заказа или ключ, если указан
  status: "open" | "answered" | "closed";
  createdAt: number;
  updatedAt: number;
  messages: Msg[];
};

export const MAX_TEXT = 2000;
const MAX_MESSAGES = 200;

const kTicket = (id: string) => `ticket:${id}`;

export function isTicketId(id: string): boolean {
  return /^[a-f0-9]{32}$/.test(id);
}

export async function getTicket(id: string): Promise<Ticket | null> {
  return db().get<Ticket>(kTicket(id));
}

async function saveTicket(t: Ticket): Promise<void> {
  await db().set(kTicket(t.id), t);
  await db().sadd("tickets", t.id);
}

export async function listTickets(): Promise<Ticket[]> {
  const ids = await db().smembers("tickets");
  const recs = await db().mget<Ticket>(ids.map(kTicket));
  return recs.filter((r): r is Ticket => !!r).sort((a, b) => b.updatedAt - a.updatedAt);
}

export function cleanText(s: unknown, max: number): string {
  return typeof s === "string" ? s.replace(/\r\n/g, "\n").trim().slice(0, max) : "";
}

export async function createTicket(message: string, contact: string, ref: string): Promise<Ticket> {
  const t: Ticket = {
    id: randomBytes(16).toString("hex"),
    contact: contact || undefined,
    ref: ref || undefined,
    status: "open",
    createdAt: now(),
    updatedAt: now(),
    messages: [{ from: "user", text: message, at: now() }],
  };
  await saveTicket(t);
  return t;
}

// Добавить сообщение. Блокировка защищает от одновременных записей в один тикет.
export async function addMessage(id: string, from: "user" | "admin", text: string): Promise<Ticket | "full" | null> {
  const lockKey = `lock:ticket:${id}`;
  let locked = false;
  for (let i = 0; i < 10; i++) {
    if (await db().setnx(lockKey, "1", 5)) {
      locked = true;
      break;
    }
    await new Promise((r) => setTimeout(r, 120));
  }
  try {
    const t = await getTicket(id);
    if (!t) return null;
    if (t.messages.length >= MAX_MESSAGES) return "full";
    t.messages.push({ from, text, at: now() });
    t.updatedAt = now();
    t.status = from === "admin" ? "answered" : "open";
    await saveTicket(t);
    return t;
  } finally {
    if (locked) await db().del(lockKey);
  }
}

export async function setStatus(id: string, status: Ticket["status"]): Promise<Ticket | null> {
  const t = await getTicket(id);
  if (!t) return null;
  t.status = status;
  t.updatedAt = now();
  await saveTicket(t);
  return t;
}

export async function deleteTicket(id: string): Promise<void> {
  await db().del(kTicket(id));
}

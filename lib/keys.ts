import { randomBytes } from "crypto";
import { db } from "./db";

export type KeyRecord = {
  key: string;
  days: number;
  createdAt: number; // unix, сек
  source: "order" | "admin";
  orderId?: string;
  note?: string;
  activatedAt?: number;
  expiresAt?: number;
  hwid?: string;
  banned?: boolean;
  lastCheckAt?: number;
};

export type OrderRecord = {
  id: string;
  planId: string;
  days: number;
  amount: string;
  currency: string;
  contact?: string;
  status: "pending" | "paid" | "failed";
  createdAt: number;
  paidAt?: number;
  key?: string;
  invoiceUuid?: string;
  payUrl?: string;
};

const ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";

export function now(): number {
  return Math.floor(Date.now() / 1000);
}

export function genKey(): string {
  const bytes = randomBytes(16);
  let s = "";
  for (let i = 0; i < 16; i++) s += ALPHABET[bytes[i] % ALPHABET.length];
  return `${s.slice(0, 4)}-${s.slice(4, 8)}-${s.slice(8, 12)}-${s.slice(12, 16)}`;
}

export function normalizeKey(raw: string): string {
  return raw.trim().toUpperCase();
}

export function isKeyFormat(k: string): boolean {
  return /^[A-Z0-9]{4}(-[A-Z0-9]{4}){3}$/.test(k);
}

export function genOrderId(): string {
  return randomBytes(16).toString("hex");
}

const kKey = (k: string) => `key:${k}`;
const kOrder = (id: string) => `order:${id}`;

export async function getKey(k: string): Promise<KeyRecord | null> {
  return db().get<KeyRecord>(kKey(k));
}

export async function saveKey(rec: KeyRecord): Promise<void> {
  await db().set(kKey(rec.key), rec);
  await db().sadd("keys", rec.key);
}

export async function createKey(days: number, source: "order" | "admin", extra: Partial<KeyRecord> = {}): Promise<KeyRecord> {
  for (let i = 0; i < 5; i++) {
    const key = genKey();
    if (await getKey(key)) continue;
    const rec: KeyRecord = { key, days, createdAt: now(), source, ...extra };
    await saveKey(rec);
    return rec;
  }
  throw new Error("Не удалось сгенерировать уникальный ключ");
}

export async function listKeys(): Promise<KeyRecord[]> {
  const ids = await db().smembers("keys");
  const recs = await db().mget<KeyRecord>(ids.map(kKey));
  return recs.filter((r): r is KeyRecord => !!r).sort((a, b) => b.createdAt - a.createdAt);
}

export async function getOrder(id: string): Promise<OrderRecord | null> {
  return db().get<OrderRecord>(kOrder(id));
}

export async function saveOrder(o: OrderRecord): Promise<void> {
  await db().set(kOrder(o.id), o);
  await db().sadd("orders", o.id);
}

export async function listOrders(): Promise<OrderRecord[]> {
  const ids = await db().smembers("orders");
  const recs = await db().mget<OrderRecord>(ids.map(kOrder));
  return recs.filter((r): r is OrderRecord => !!r).sort((a, b) => b.createdAt - a.createdAt);
}

// Выдать ключ за оплаченный заказ. Безопасно вызывать повторно (вебхук могут прислать несколько раз).
export async function fulfillOrder(orderId: string): Promise<OrderRecord | null> {
  const order = await getOrder(orderId);
  if (!order) return null;
  if (order.key) return order;
  const locked = await db().setnx(`lock:order:${orderId}`, "1", 30);
  if (!locked) {
    // другой запрос уже выдаёт ключ - подождём и перечитаем
    for (let i = 0; i < 10; i++) {
      await new Promise((r) => setTimeout(r, 300));
      const again = await getOrder(orderId);
      if (again?.key) return again;
    }
    return getOrder(orderId);
  }
  const fresh = await getOrder(orderId);
  if (fresh?.key) return fresh;
  const rec = await createKey(order.days, "order", { orderId, note: order.contact });
  const paid: OrderRecord = { ...order, status: "paid", paidAt: now(), key: rec.key };
  await saveOrder(paid);
  return paid;
}

export type CheckResult = { code: "OK"; expiresAt: number } | { code: "invalid" | "expired" | "hwid" | "banned" };

// Проверка ключа из скрипта. Первый запуск активирует ключ и привязывает его к компьютеру.
export async function checkKey(rawKey: string, hwid: string): Promise<CheckResult> {
  const key = normalizeKey(rawKey);
  if (!isKeyFormat(key)) return { code: "invalid" };
  const rec = await getKey(key);
  if (!rec) return { code: "invalid" };
  if (rec.banned) return { code: "banned" };
  const t = now();
  if (!rec.activatedAt || !rec.expiresAt) {
    rec.activatedAt = t;
    rec.expiresAt = t + rec.days * 86400;
    rec.hwid = hwid;
  }
  if (rec.hwid && rec.hwid !== hwid) return { code: "hwid" };
  rec.lastCheckAt = t;
  await saveKey(rec);
  if (rec.expiresAt <= t) return { code: "expired" };
  return { code: "OK", expiresAt: rec.expiresAt };
}

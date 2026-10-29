import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { clientIp } from "@/lib/auth";
import { addMessage, cleanText, getTicket, isTicketId, MAX_TEXT } from "@/lib/support";
import { notify } from "@/lib/notify";
import { siteUrl } from "@/lib/site";

export const dynamic = "force-dynamic";

export async function GET(_req: Request, { params }: { params: { id: string } }) {
  if (!isTicketId(params.id)) return NextResponse.json({ error: "not found" }, { status: 404 });
  const t = await getTicket(params.id);
  if (!t) return NextResponse.json({ error: "not found" }, { status: 404 });
  return NextResponse.json({ id: t.id, status: t.status, createdAt: t.createdAt, messages: t.messages });
}

export async function POST(req: Request, { params }: { params: { id: string } }) {
  if (!isTicketId(params.id)) return NextResponse.json({ error: "not found" }, { status: 404 });
  const n = await db().incr(`rl:ticketmsg:${clientIp(req)}`, 3600);
  if (n > 30) return NextResponse.json({ error: "Слишком много сообщений, попробуйте позже" }, { status: 429 });

  const body = (await req.json().catch(() => null)) as { message?: string } | null;
  const message = cleanText(body?.message, MAX_TEXT);
  if (!message) return NextResponse.json({ error: "Пустое сообщение" }, { status: 400 });

  const t = await addMessage(params.id, "user", message);
  if (!t) return NextResponse.json({ error: "not found" }, { status: 404 });
  if (t === "full") return NextResponse.json({ error: "В обращении слишком много сообщений, создайте новое" }, { status: 400 });
  await notify(`Ответ в обращении${t.contact ? ` от ${t.contact}` : ""}:\n${message.slice(0, 300)}\n\n${siteUrl(req)}/admin`);
  return NextResponse.json({ id: t.id, status: t.status, createdAt: t.createdAt, messages: t.messages });
}

import { NextResponse } from "next/server";
import { isAdmin } from "@/lib/auth";
import { addMessage, cleanText, deleteTicket, getTicket, isTicketId, MAX_TEXT, setStatus } from "@/lib/support";

export const dynamic = "force-dynamic";

export async function GET(req: Request, { params }: { params: { id: string } }) {
  if (!isAdmin(req)) return NextResponse.json({ error: "unauthorized" }, { status: 401 });
  if (!isTicketId(params.id)) return NextResponse.json({ error: "not found" }, { status: 404 });
  const t = await getTicket(params.id);
  if (!t) return NextResponse.json({ error: "not found" }, { status: 404 });
  return NextResponse.json({ ticket: t });
}

export async function POST(req: Request, { params }: { params: { id: string } }) {
  if (!isAdmin(req)) return NextResponse.json({ error: "unauthorized" }, { status: 401 });
  if (!isTicketId(params.id)) return NextResponse.json({ error: "not found" }, { status: 404 });
  const body = (await req.json().catch(() => null)) as { action?: string; text?: string } | null;
  if (!body?.action) return NextResponse.json({ error: "bad request" }, { status: 400 });

  if (body.action === "reply") {
    const text = cleanText(body.text, MAX_TEXT);
    if (!text) return NextResponse.json({ error: "Пустой ответ" }, { status: 400 });
    const t = await addMessage(params.id, "admin", text);
    if (!t) return NextResponse.json({ error: "not found" }, { status: 404 });
    if (t === "full") return NextResponse.json({ error: "Слишком много сообщений, закройте обращение" }, { status: 400 });
    return NextResponse.json({ ticket: t });
  }
  if (body.action === "close" || body.action === "reopen") {
    const t = await setStatus(params.id, body.action === "close" ? "closed" : "open");
    if (!t) return NextResponse.json({ error: "not found" }, { status: 404 });
    return NextResponse.json({ ticket: t });
  }
  if (body.action === "delete") {
    await deleteTicket(params.id);
    return NextResponse.json({ ok: true });
  }
  return NextResponse.json({ error: "unknown action" }, { status: 400 });
}

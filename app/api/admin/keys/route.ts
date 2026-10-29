import { NextResponse } from "next/server";
import { isAdmin } from "@/lib/auth";
import { createKey, getKey, listKeys, now, saveKey } from "@/lib/keys";
import { db } from "@/lib/db";

export const dynamic = "force-dynamic";

export async function GET(req: Request) {
  if (!isAdmin(req)) return NextResponse.json({ error: "unauthorized" }, { status: 401 });
  return NextResponse.json({ keys: await listKeys() });
}

type Action =
  | { action: "create"; days: number; note?: string }
  | { action: "ban" | "unban" | "resethwid" | "delete"; key: string }
  | { action: "extend"; key: string; days: number };

export async function POST(req: Request) {
  if (!isAdmin(req)) return NextResponse.json({ error: "unauthorized" }, { status: 401 });
  const body = (await req.json().catch(() => null)) as Action | null;
  if (!body) return NextResponse.json({ error: "bad request" }, { status: 400 });

  if (body.action === "create") {
    const days = Math.floor(Number(body.days));
    if (!(days >= 1 && days <= 36500)) return NextResponse.json({ error: "Срок от 1 до 36500 дней" }, { status: 400 });
    const rec = await createKey(days, "admin", { note: (body.note || "").slice(0, 100) || undefined });
    return NextResponse.json({ key: rec });
  }

  const rec = await getKey(body.key || "");
  if (!rec) return NextResponse.json({ error: "Ключ не найден" }, { status: 404 });

  if (body.action === "ban") rec.banned = true;
  else if (body.action === "unban") rec.banned = false;
  else if (body.action === "resethwid") rec.hwid = undefined;
  else if (body.action === "extend") {
    const days = Math.floor(Number(body.days));
    if (!(days >= 1 && days <= 36500)) return NextResponse.json({ error: "Срок от 1 до 36500 дней" }, { status: 400 });
    if (rec.expiresAt) rec.expiresAt = Math.max(rec.expiresAt, now()) + days * 86400;
    else rec.days += days;
  } else if (body.action === "delete") {
    await db().del(`key:${rec.key}`);
    // запись в списке keys останется, но listKeys отфильтрует пустые значения
    return NextResponse.json({ ok: true });
  } else {
    return NextResponse.json({ error: "unknown action" }, { status: 400 });
  }
  await saveKey(rec);
  return NextResponse.json({ key: rec });
}

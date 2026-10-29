import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { checkPassword, clientIp, COOKIE_NAME, makeToken } from "@/lib/auth";

export const dynamic = "force-dynamic";

export async function POST(req: Request) {
  const n = await db().incr(`rl:login:${clientIp(req)}`, 900);
  if (n > 8) return NextResponse.json({ error: "Слишком много попыток" }, { status: 429 });
  const body = (await req.json().catch(() => null)) as { password?: string } | null;
  if (!body?.password || !checkPassword(body.password)) {
    return NextResponse.json({ error: "Неверный пароль" }, { status: 401 });
  }
  const res = NextResponse.json({ ok: true });
  res.cookies.set(COOKIE_NAME, makeToken(), {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "strict",
    path: "/",
    maxAge: 7 * 24 * 3600,
  });
  return res;
}

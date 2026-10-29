import { db } from "@/lib/db";
import { clientIp } from "@/lib/auth";
import { checkKey } from "@/lib/keys";

export const dynamic = "force-dynamic";

function text(body: string, status = 200) {
  return new Response(body, { status, headers: { "Content-Type": "text/plain; charset=utf-8", "Cache-Control": "no-store" } });
}

// Эндпоинт для скрипта: GET /api/check?key=XXXX-XXXX-XXXX-XXXX&hwid=1A2B3C4D&v=1
// Ответ: "OK|<unix-время окончания>" или "ERR|invalid|expired|hwid|banned"
export async function GET(req: Request) {
  const ip = clientIp(req);
  const n = await db().incr(`rl:check:${ip}`, 60);
  if (n > 40) return text("ERR|rate", 429);

  const url = new URL(req.url);
  const key = url.searchParams.get("key") || "";
  const hwid = url.searchParams.get("hwid") || "";
  if (!key || key.length > 40) return text("ERR|invalid");
  if (!/^[A-Za-z0-9]{1,32}$/.test(hwid)) return text("ERR|invalid");

  try {
    const r = await checkKey(key, hwid.toUpperCase());
    return text(r.code === "OK" ? `OK|${r.expiresAt}` : `ERR|${r.code}`);
  } catch (e) {
    console.error("check error", e);
    return text("ERR|server", 500);
  }
}

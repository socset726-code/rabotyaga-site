import { crc32hex } from "@/lib/crc32";
import { siteUrl } from "@/lib/site";

export const dynamic = "force-dynamic";

// Контрольная сумма актуального скрипта (файл public/Rabotyagamain.lua).
// Скрипт сравнивает её со своей и при отличии сам обновляется.
let cache: { at: number; body: string } | null = null;

export async function GET(req: Request) {
  const headers = { "Content-Type": "text/plain; charset=utf-8", "Cache-Control": "no-store" };
  if (cache && Date.now() - cache.at < 60_000) return new Response(cache.body, { headers });
  try {
    const res = await fetch(`${siteUrl(req)}/Rabotyagamain.lua?t=${Date.now()}`, { cache: "no-store" });
    if (!res.ok) return new Response("ERR|nofile", { status: 404, headers });
    const buf = new Uint8Array(await res.arrayBuffer());
    const body = `OK|${crc32hex(buf)}|${buf.length}`;
    cache = { at: Date.now(), body };
    return new Response(body, { headers });
  } catch {
    return new Response("ERR|fetch", { status: 502, headers });
  }
}

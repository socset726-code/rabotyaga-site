import { NextResponse } from "next/server";
import { verifyWebhook, type Invoice } from "@/lib/cryptopay";
import { fulfillOrder, getOrder } from "@/lib/keys";

export const dynamic = "force-dynamic";

// Webhook Crypto Pay: включается в @CryptoBot -> Crypto Pay -> My Apps -> ваше приложение -> Webhooks
// URL: https://ВАШ-САЙТ/api/webhook/cryptopay
export async function POST(req: Request) {
  const raw = await req.text();
  let ok = false;
  try {
    ok = verifyWebhook(raw, req.headers.get("crypto-pay-api-signature"));
  } catch (e) {
    console.error("webhook config error", e);
    return NextResponse.json({ error: "config" }, { status: 500 });
  }
  if (!ok) return NextResponse.json({ error: "bad signature" }, { status: 401 });

  let data: { update_type?: string; payload?: Invoice };
  try {
    data = JSON.parse(raw);
  } catch {
    return NextResponse.json({ error: "bad json" }, { status: 400 });
  }
  if (data.update_type !== "invoice_paid" || !data.payload) return NextResponse.json({ ok: true });

  const inv = data.payload;
  const orderId = typeof inv.payload === "string" ? inv.payload : "";
  if (inv.status !== "paid" || !orderId) return NextResponse.json({ ok: true });

  const order = await getOrder(orderId);
  // счёт должен совпадать с тем, что мы создали для этого заказа
  if (!order || (order.invoiceUuid && order.invoiceUuid !== String(inv.invoice_id))) {
    return NextResponse.json({ ok: true });
  }
  await fulfillOrder(orderId);
  return NextResponse.json({ ok: true });
}

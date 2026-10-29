import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { createInvoice } from "@/lib/cryptopay";
import { CURRENCY, findPlan } from "@/lib/plans";
import { genOrderId, now, saveOrder, type OrderRecord } from "@/lib/keys";
import { clientIp } from "@/lib/auth";
import { siteUrl } from "@/lib/site";

export const dynamic = "force-dynamic";

export async function POST(req: Request) {
  const ip = clientIp(req);
  const n = await db().incr(`rl:checkout:${ip}`, 600);
  if (n > 10) return NextResponse.json({ error: "Слишком много попыток, подождите несколько минут" }, { status: 429 });

  const body = (await req.json().catch(() => null)) as { planId?: string; contact?: string } | null;
  const plan = body?.planId ? findPlan(body.planId) : undefined;
  if (!plan) return NextResponse.json({ error: "Неизвестный тариф" }, { status: 400 });
  const contact = (body?.contact || "").trim().slice(0, 64);

  const order: OrderRecord = {
    id: genOrderId(),
    planId: plan.id,
    days: plan.days,
    amount: plan.price,
    currency: CURRENCY,
    contact: contact || undefined,
    status: "pending",
    createdAt: now(),
  };
  await saveOrder(order);

  const base = siteUrl(req);
  try {
    const inv = await createInvoice({
      amount: plan.price,
      fiat: CURRENCY,
      orderId: order.id,
      description: `Rabotyaga Main: подписка Про, ${plan.days} дн.`,
      returnUrl: `${base}/order/${order.id}`,
    });
    await saveOrder({ ...order, invoiceUuid: inv.id, payUrl: inv.url });
    return NextResponse.json({ url: inv.url, orderUrl: `/order/${order.id}` });
  } catch (e) {
    console.error("checkout error", e);
    await saveOrder({ ...order, status: "failed" });
    return NextResponse.json({ error: "Не удалось создать счёт. Попробуйте позже или напишите в поддержку." }, { status: 502 });
  }
}

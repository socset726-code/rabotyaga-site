import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { getInvoice } from "@/lib/cryptopay";
import { fulfillOrder, getOrder, saveOrder } from "@/lib/keys";

export const dynamic = "force-dynamic";

export async function GET(_req: Request, { params }: { params: { id: string } }) {
  const id = params.id;
  if (!/^[a-f0-9]{32}$/.test(id)) return NextResponse.json({ error: "not found" }, { status: 404 });
  let o = await getOrder(id);
  if (!o) return NextResponse.json({ error: "not found" }, { status: 404 });

  // Запасной путь: если вебхук не настроен или не дошёл, сами спрашиваем статус счёта (не чаще раза в 4 секунды).
  if (o.status === "pending" && o.invoiceUuid) {
    const first = await db().setnx(`poll:order:${id}`, "1", 4);
    if (first) {
      try {
        const inv = await getInvoice(o.invoiceUuid);
        if (inv?.status === "paid") {
          o = (await fulfillOrder(id)) ?? o;
        } else if (inv?.status === "expired") {
          o = { ...o, status: "failed" };
          await saveOrder(o);
        }
      } catch (e) {
        console.error("poll invoice error", e);
      }
    }
  }

  return NextResponse.json({
    status: o.status,
    days: o.days,
    amount: o.amount,
    currency: o.currency,
    key: o.status === "paid" ? o.key : undefined,
    payUrl: o.status === "pending" ? o.payUrl : undefined,
  });
}

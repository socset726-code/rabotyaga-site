import { NextResponse } from "next/server";
import { isAdmin } from "@/lib/auth";
import { fulfillOrder, listOrders } from "@/lib/keys";

export const dynamic = "force-dynamic";

export async function GET(req: Request) {
  if (!isAdmin(req)) return NextResponse.json({ error: "unauthorized" }, { status: 401 });
  return NextResponse.json({ orders: await listOrders() });
}

// Ручная выдача ключа, если оплата пришла, а вебхук потерялся
export async function POST(req: Request) {
  if (!isAdmin(req)) return NextResponse.json({ error: "unauthorized" }, { status: 401 });
  const body = (await req.json().catch(() => null)) as { id?: string } | null;
  if (!body?.id) return NextResponse.json({ error: "bad request" }, { status: 400 });
  const o = await fulfillOrder(body.id);
  if (!o) return NextResponse.json({ error: "Заказ не найден" }, { status: 404 });
  return NextResponse.json({ order: o });
}

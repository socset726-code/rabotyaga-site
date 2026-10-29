import OrderView from "@/components/OrderView";

export const metadata = { title: "Заказ — Rabotyaga Main", robots: { index: false } };

export default function OrderPage({ params }: { params: { id: string } }) {
  return <OrderView id={params.id} support={process.env.NEXT_PUBLIC_SUPPORT_URL} />;
}

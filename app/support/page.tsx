import SupportForm from "@/components/SupportForm";

export const metadata = { title: "Поддержка — Rabotyaga Main" };

export default function SupportPage({ searchParams }: { searchParams: { order?: string } }) {
  const o = typeof searchParams.order === "string" ? searchParams.order.slice(0, 80) : "";
  return (
    <div className="order">
      <p className="note" style={{ marginBottom: 14 }}><a href="/">← На главную</a> · <a href="/#pricing">Тарифы</a></p>
      <SupportForm defaultRef={o} />
    </div>
  );
}

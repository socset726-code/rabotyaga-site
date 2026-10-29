import TicketView from "@/components/TicketView";

export const metadata = { title: "Обращение — Rabotyaga Main", robots: { index: false } };

export default function TicketPage({ params }: { params: { id: string } }) {
  return (
    <div className="order">
      <p className="note" style={{ marginBottom: 14 }}><a href="/">← На главную</a> · <a href="/support">Новое обращение</a></p>
      <TicketView id={params.id} />
    </div>
  );
}

"use client";

import { useState } from "react";

export type PlanView = { id: string; title: string; days: number; price: string; badge?: string; lifetime?: boolean };

export default function Pricing({ plans, currency }: { plans: PlanView[]; currency: string }) {
  const [contact, setContact] = useState("");
  const [busy, setBusy] = useState<string | null>(null);
  const [error, setError] = useState("");

  async function buy(planId: string) {
    setError("");
    setBusy(planId);
    try {
      const res = await fetch("/api/checkout", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ planId, contact }),
      });
      const data = (await res.json().catch(() => ({}))) as { url?: string; orderUrl?: string; error?: string };
      if (!res.ok || !data.url) {
        setError(data.error || "Не удалось создать счёт");
        setBusy(null);
        return;
      }
      try {
        // запоминаем заказ, чтобы можно было вернуться за ключом
        const list = JSON.parse(localStorage.getItem("orders") || "[]") as string[];
        if (data.orderUrl) localStorage.setItem("orders", JSON.stringify([data.orderUrl, ...list].slice(0, 10)));
      } catch {}
      window.location.href = data.url;
    } catch {
      setError("Нет связи с сервером");
      setBusy(null);
    }
  }

  return (
    <>
      <div className="contact">
        <label className="f" htmlFor="contact">Telegram или Discord для связи (необязательно)</label>
        <input id="contact" className="in" value={contact} maxLength={64} placeholder="@username" onChange={(e) => setContact(e.target.value)} />
      </div>
      <div className="plans">
        {plans.map((p) => (
          <div key={p.id} className={"plan" + (p.lifetime ? " best" : "")}>
            {p.badge && <span className="badge">{p.badge}</span>}
            <div className="p-title">{p.title}</div>
            <div className="price">
              {p.price}
              <small>{currency}</small>
            </div>
            <div className="per">
              {p.lifetime ? "Платите один раз, без продления" : `≈ ${(Number(p.price) / p.days).toFixed(1)} ${currency} в день`}
            </div>
            <button className={"btn" + (p.lifetime ? " primary" : "")} disabled={busy !== null} onClick={() => buy(p.id)}>
              {busy === p.id ? "Создаю счёт…" : "Оплатить криптовалютой"}
            </button>
          </div>
        ))}
      </div>
      {error && <div className="err">{error}</div>}
      <p className="note">Оплата криптовалютой через Crypto Bot в Telegram (USDT, TON, BTC и другие). После подтверждения платежа ключ появится на странице заказа.</p>
    </>
  );
}

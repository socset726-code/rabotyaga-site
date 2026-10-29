"use client";

import { useEffect, useState } from "react";

type Mine = { id: string; at: number; title: string };
const LS = "rm_tickets";

function readMine(): Mine[] {
  try {
    const v = JSON.parse(localStorage.getItem(LS) || "[]");
    return Array.isArray(v) ? v : [];
  } catch {
    return [];
  }
}

export default function SupportForm({ defaultRef }: { defaultRef?: string }) {
  const [message, setMessage] = useState("");
  const [contact, setContact] = useState("");
  const [ref, setRef] = useState(defaultRef || "");
  const [err, setErr] = useState("");
  const [busy, setBusy] = useState(false);
  const [mine, setMine] = useState<Mine[]>([]);

  useEffect(() => setMine(readMine()), []);

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    setErr("");
    setBusy(true);
    try {
      const res = await fetch("/api/support", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ message, contact, ref }),
      });
      const d = (await res.json().catch(() => ({}))) as { id?: string; error?: string };
      if (!res.ok || !d.id) {
        setErr(d.error || "Не удалось отправить");
        setBusy(false);
        return;
      }
      try {
        const list = [{ id: d.id, at: Date.now(), title: message.slice(0, 60) }, ...readMine()].slice(0, 20);
        localStorage.setItem(LS, JSON.stringify(list));
      } catch {}
      window.location.href = `/support/${d.id}`;
    } catch {
      setErr("Нет связи с сервером");
      setBusy(false);
    }
  }

  return (
    <>
      <form className="panel" onSubmit={submit}>
        <h2 style={{ fontSize: 24 }}>Поддержка</h2>
        <p className="note" style={{ marginTop: 8 }}>Опишите вопрос. Ответ появится на странице обращения, ссылку на неё мы покажем после отправки.</p>
        <div style={{ marginTop: 16 }}>
          <label className="f" htmlFor="m">Сообщение</label>
          <textarea id="m" className="in" rows={6} maxLength={2000} value={message} onChange={(e) => setMessage(e.target.value)} required />
        </div>
        <div style={{ marginTop: 12 }}>
          <label className="f" htmlFor="c">Как с вами связаться (необязательно)</label>
          <input id="c" className="in" maxLength={80} value={contact} onChange={(e) => setContact(e.target.value)} placeholder="Telegram, ник" />
        </div>
        <div style={{ marginTop: 12 }}>
          <label className="f" htmlFor="r">Номер заказа или ключ (необязательно)</label>
          <input id="r" className="in" maxLength={80} value={ref} onChange={(e) => setRef(e.target.value)} />
        </div>
        {err && <div className="err">{err}</div>}
        <p style={{ marginTop: 16 }}>
          <button className="btn primary" type="submit" disabled={busy}>{busy ? "Отправка…" : "Отправить"}</button>
        </p>
      </form>

      {mine.length > 0 && (
        <div className="panel" style={{ marginTop: 16 }}>
          <h3 style={{ fontSize: 17 }}>Мои обращения</h3>
          <ul className="steps">
            {mine.map((t) => (
              <li key={t.id}>
                <a href={`/support/${t.id}`}>{t.title || "Обращение"}</a>{" "}
                <span style={{ color: "var(--muted)" }}>({new Date(t.at).toLocaleDateString("ru-RU")})</span>
              </li>
            ))}
          </ul>
          <p className="note">Список хранится только в этом браузере.</p>
        </div>
      )}
    </>
  );
}

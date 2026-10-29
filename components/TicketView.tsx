"use client";

import { useCallback, useEffect, useRef, useState } from "react";

type Msg = { from: "user" | "admin"; text: string; at: number };
type T = { id: string; status: string; messages: Msg[] };

export default function TicketView({ id }: { id: string }) {
  const [t, setT] = useState<T | null>(null);
  const [missing, setMissing] = useState(false);
  const [text, setText] = useState("");
  const [err, setErr] = useState("");
  const [busy, setBusy] = useState(false);
  const bottom = useRef<HTMLDivElement>(null);
  const count = useRef(0);

  const load = useCallback(async () => {
    const res = await fetch(`/api/support/${id}`, { cache: "no-store" });
    if (res.status === 404) return setMissing(true);
    if (res.ok) setT((await res.json()) as T);
  }, [id]);

  useEffect(() => {
    load().catch(() => {});
    const iv = setInterval(() => {
      if (!document.hidden) load().catch(() => {});
    }, 8000);
    return () => clearInterval(iv);
  }, [load]);

  useEffect(() => {
    if (t && t.messages.length !== count.current) {
      count.current = t.messages.length;
      bottom.current?.scrollIntoView({ behavior: "smooth" });
    }
  }, [t]);

  async function send(e: React.FormEvent) {
    e.preventDefault();
    setErr("");
    setBusy(true);
    try {
      const res = await fetch(`/api/support/${id}`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ message: text }),
      });
      const d = (await res.json().catch(() => ({}))) as T & { error?: string };
      if (!res.ok) setErr(d.error || "Не удалось отправить");
      else {
        setT(d);
        setText("");
      }
    } catch {
      setErr("Нет связи с сервером");
    }
    setBusy(false);
  }

  if (missing) return <div className="panel">Обращение не найдено. <a href="/support">Создать новое</a></div>;
  if (!t) return <div className="panel"><p className="note">Загрузка…</p></div>;

  return (
    <div className="panel">
      <h2 style={{ fontSize: 22 }}>Обращение</h2>
      <p className="note">Сохраните эту ссылку, чтобы вернуться за ответом. Страница обновляется сама.</p>
      <div className="chat">
        {t.messages.map((m, i) => (
          <div key={i} className={"bubble " + m.from}>
            <div className="who">{m.from === "admin" ? "Поддержка" : "Вы"} · {new Date(m.at * 1000).toLocaleString("ru-RU")}</div>
            <div className="txt">{m.text}</div>
          </div>
        ))}
        <div ref={bottom} />
      </div>
      {t.status === "closed" ? (
        <p className="note">Обращение закрыто. Если вопрос остался, <a href="/support">создайте новое</a>.</p>
      ) : (
        <form onSubmit={send}>
          <textarea className="in" rows={3} maxLength={2000} value={text} onChange={(e) => setText(e.target.value)} placeholder="Ваше сообщение" required />
          {err && <div className="err">{err}</div>}
          <p style={{ marginTop: 10 }}>
            <button className="btn primary" type="submit" disabled={busy}>Отправить</button>
          </p>
        </form>
      )}
    </div>
  );
}

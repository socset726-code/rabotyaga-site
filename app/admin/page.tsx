"use client";

import { useCallback, useEffect, useState } from "react";

type Key = {
  key: string; days: number; createdAt: number; source: string; note?: string;
  activatedAt?: number; expiresAt?: number; hwid?: string; banned?: boolean; lastCheckAt?: number;
};
type Order = {
  id: string; planId: string; days: number; amount: string; currency: string; contact?: string;
  status: string; createdAt: number; paidAt?: number; key?: string;
};

type TRow = {
  id: string; contact?: string; ref?: string; status: string; createdAt: number; updatedAt: number;
  count: number; lastFrom?: string; lastText?: string; waiting: boolean;
};
type TFull = { id: string; contact?: string; ref?: string; status: string; messages: { from: string; text: string; at: number }[] };

const fmt = (t?: number) => (t ? new Date(t * 1000).toLocaleString("ru-RU") : "—");

export default function Admin() {
  const [authed, setAuthed] = useState<boolean | null>(null);
  const [password, setPassword] = useState("");
  const [loginErr, setLoginErr] = useState("");
  const [tab, setTab] = useState<"keys" | "orders" | "support">("keys");
  const [keys, setKeys] = useState<Key[]>([]);
  const [orders, setOrders] = useState<Order[]>([]);
  const [days, setDays] = useState("30");
  const [note, setNote] = useState("");
  const [msg, setMsg] = useState("");
  const [tickets, setTickets] = useState<TRow[]>([]);
  const [open, setOpen] = useState<TFull | null>(null);
  const [reply, setReply] = useState("");

  const load = useCallback(async () => {
    const [k, o, t] = await Promise.all([fetch("/api/admin/keys"), fetch("/api/admin/orders"), fetch("/api/admin/support")]);
    if (k.status === 401 || o.status === 401) {
      setAuthed(false);
      return;
    }
    setAuthed(true);
    setKeys(((await k.json()) as { keys: Key[] }).keys);
    setOrders(((await o.json()) as { orders: Order[] }).orders);
    if (t.ok) setTickets(((await t.json()) as { tickets: TRow[] }).tickets);
  }, []);

  useEffect(() => {
    load().catch(() => setAuthed(false));
  }, [load]);

  async function login(e: React.FormEvent) {
    e.preventDefault();
    setLoginErr("");
    const res = await fetch("/api/admin/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ password }),
    });
    if (res.ok) {
      setPassword("");
      await load();
    } else {
      const d = (await res.json().catch(() => ({}))) as { error?: string };
      setLoginErr(d.error || "Ошибка входа");
    }
  }

  async function logout() {
    await fetch("/api/admin/logout", { method: "POST" });
    setAuthed(false);
  }

  async function act(body: Record<string, unknown>) {
    setMsg("");
    const res = await fetch("/api/admin/keys", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    });
    const d = (await res.json().catch(() => ({}))) as { error?: string; key?: Key };
    if (!res.ok) setMsg(d.error || "Ошибка");
    else if (body.action === "create" && d.key) setMsg("Создан ключ: " + d.key.key);
    await load();
  }

  async function openTicket(id: string) {
    const res = await fetch(`/api/admin/support/${id}`);
    if (res.ok) setOpen(((await res.json()) as { ticket: TFull }).ticket);
  }

  async function tAct(id: string, body: Record<string, unknown>) {
    setMsg("");
    const res = await fetch(`/api/admin/support/${id}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    });
    const d = (await res.json().catch(() => ({}))) as { error?: string; ticket?: TFull };
    if (!res.ok) setMsg(d.error || "Ошибка");
    else if (body.action === "delete") setOpen(null);
    else if (d.ticket) setOpen(d.ticket);
    if (body.action === "reply" && res.ok) setReply("");
    await load();
  }

  async function fulfill(id: string) {
    setMsg("");
    const res = await fetch("/api/admin/orders", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ id }),
    });
    const d = (await res.json().catch(() => ({}))) as { error?: string; order?: Order };
    setMsg(res.ok && d.order?.key ? "Ключ выдан: " + d.order.key : d.error || "Ошибка");
    await load();
  }

  if (authed === null) return <div className="admin"><p className="note">Загрузка…</p></div>;

  if (!authed) {
    return (
      <div className="order">
        <form className="panel" onSubmit={login}>
          <h2 style={{ fontSize: 22 }}>Вход в админку</h2>
          <div style={{ marginTop: 16 }}>
            <label className="f" htmlFor="pw">Пароль</label>
            <input id="pw" className="in" type="password" value={password} onChange={(e) => setPassword(e.target.value)} autoFocus />
          </div>
          {loginErr && <div className="err">{loginErr}</div>}
          <p style={{ marginTop: 16 }}>
            <button className="btn primary" type="submit">Войти</button>
          </p>
        </form>
      </div>
    );
  }

  const status = (k: Key) => {
    if (k.banned) return "заблокирован";
    if (!k.activatedAt) return "не активирован";
    if (k.expiresAt && k.expiresAt * 1000 < Date.now()) return "истёк";
    return "активен";
  };

  return (
    <div className="admin">
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
        <h2 style={{ fontSize: 24 }}>Админка</h2>
        <button className="btn small" onClick={logout}>Выйти</button>
      </div>

      <div className="tabs">
        <button className={"tab" + (tab === "keys" ? " on" : "")} onClick={() => setTab("keys")}>Ключи ({keys.length})</button>
        <button className={"tab" + (tab === "orders" ? " on" : "")} onClick={() => setTab("orders")}>Заказы ({orders.length})</button>
        <button className={"tab" + (tab === "support" ? " on" : "")} onClick={() => setTab("support")}>
          Поддержка ({tickets.length}){tickets.some((t) => t.waiting) && <span className="badge-n">{tickets.filter((t) => t.waiting).length}</span>}
        </button>
      </div>

      {msg && <p className="note" style={{ color: "var(--text)" }}>{msg}</p>}

      {tab === "keys" && (
        <>
          <div className="toolbar">
            <div>
              <label className="f" htmlFor="d">Срок, дней</label>
              <input id="d" className="in" value={days} onChange={(e) => setDays(e.target.value)} />
            </div>
            <div>
              <label className="f" htmlFor="n">Заметка (кому)</label>
              <input id="n" className="in" value={note} onChange={(e) => setNote(e.target.value)} />
            </div>
            <button className="btn primary" onClick={() => act({ action: "create", days: Number(days), note })}>Создать ключ</button>
            <button className="btn" onClick={() => act({ action: "create", days: 36500, note })}>Ключ навсегда</button>
          </div>
          <div className="tablewrap">
            <table>
              <thead>
                <tr><th>Ключ</th><th>Статус</th><th>Срок</th><th>До</th><th>HWID</th><th>Заметка</th><th>Последняя проверка</th><th></th></tr>
              </thead>
              <tbody>
                {keys.map((k) => (
                  <tr key={k.key}>
                    <td className="mono">{k.key}</td>
                    <td>{status(k)}</td>
                    <td>{k.days >= 36500 ? "навсегда" : `${k.days} дн.`}</td>
                    <td>{fmt(k.expiresAt)}</td>
                    <td className="mono">{k.hwid || "—"}</td>
                    <td>{k.note || (k.source === "order" ? "заказ" : "")}</td>
                    <td>{fmt(k.lastCheckAt)}</td>
                    <td>
                      <div className="actions">
                        <button className="btn small" onClick={() => act({ action: "extend", key: k.key, days: 30 })}>+30 дн</button>
                        <button className="btn small" onClick={() => act({ action: "resethwid", key: k.key })}>Сброс HWID</button>
                        {k.banned ? (
                          <button className="btn small" onClick={() => act({ action: "unban", key: k.key })}>Разблок.</button>
                        ) : (
                          <button className="btn small danger" onClick={() => act({ action: "ban", key: k.key })}>Блок</button>
                        )}
                        <button className="btn small danger" onClick={() => confirm("Удалить ключ?") && act({ action: "delete", key: k.key })}>Удалить</button>
                      </div>
                    </td>
                  </tr>
                ))}
                {keys.length === 0 && <tr><td colSpan={8} style={{ color: "var(--muted)" }}>Ключей пока нет</td></tr>}
              </tbody>
            </table>
          </div>
        </>
      )}

      {tab === "orders" && (
        <div className="tablewrap" style={{ marginTop: 18 }}>
          <table>
            <thead>
              <tr><th>Создан</th><th>Статус</th><th>Тариф</th><th>Сумма</th><th>Контакт</th><th>Ключ</th><th>Заказ</th><th></th></tr>
            </thead>
            <tbody>
              {orders.map((o) => (
                <tr key={o.id}>
                  <td>{fmt(o.createdAt)}</td>
                  <td><span className={"status " + o.status}>{o.status}</span></td>
                  <td>{o.days >= 36500 ? "навсегда" : `${o.days} дн.`}</td>
                  <td>{o.amount} {o.currency}</td>
                  <td>{o.contact || "—"}</td>
                  <td className="mono">{o.key || "—"}</td>
                  <td><a href={`/order/${o.id}`} target="_blank" rel="noreferrer">открыть</a></td>
                  <td>{!o.key && <button className="btn small" onClick={() => fulfill(o.id)}>Выдать ключ</button>}</td>
                </tr>
              ))}
              {orders.length === 0 && <tr><td colSpan={8} style={{ color: "var(--muted)" }}>Заказов пока нет</td></tr>}
            </tbody>
          </table>
        </div>
      )}

      {tab === "support" && (
        <div style={{ marginTop: 18 }}>
          <div style={{ display: "flex", gap: 8, marginBottom: 10 }}>
            <button className="btn small" onClick={() => load()}>Обновить</button>
          </div>
          <div className="tablewrap">
            <table>
              <thead>
                <tr><th>Обновлено</th><th>Статус</th><th>Контакт</th><th>Заказ / ключ</th><th>Последнее сообщение</th><th></th></tr>
              </thead>
              <tbody>
                {tickets.map((t) => (
                  <tr key={t.id}>
                    <td>{fmt(t.updatedAt)}</td>
                    <td>{t.status === "closed" ? "закрыто" : t.waiting ? "ждёт ответа" : "отвечено"}</td>
                    <td>{t.contact || "—"}</td>
                    <td className="mono">{t.ref || "—"}</td>
                    <td style={{ maxWidth: 320, overflow: "hidden", textOverflow: "ellipsis" }}>{t.lastFrom === "admin" ? "Вы: " : ""}{t.lastText}</td>
                    <td><button className="btn small" onClick={() => openTicket(t.id)}>Открыть</button></td>
                  </tr>
                ))}
                {tickets.length === 0 && <tr><td colSpan={6} style={{ color: "var(--muted)" }}>Обращений пока нет</td></tr>}
              </tbody>
            </table>
          </div>

          {open && (
            <div className="panel admin-chat">
              <div style={{ display: "flex", justifyContent: "space-between", gap: 8, flexWrap: "wrap" }}>
                <div>
                  <b>{open.contact || "Без контакта"}</b>
                  {open.ref && <span className="mono" style={{ color: "var(--muted)" }}> · {open.ref}</span>}
                </div>
                <div className="actions">
                  {open.status === "closed" ? (
                    <button className="btn small" onClick={() => tAct(open.id, { action: "reopen" })}>Открыть снова</button>
                  ) : (
                    <button className="btn small" onClick={() => tAct(open.id, { action: "close" })}>Закрыть</button>
                  )}
                  <button className="btn small danger" onClick={() => confirm("Удалить обращение?") && tAct(open.id, { action: "delete" })}>Удалить</button>
                  <button className="btn small" onClick={() => setOpen(null)}>×</button>
                </div>
              </div>
              <div className="chat">
                {open.messages.map((m, i) => (
                  <div key={i} className={"bubble " + (m.from === "admin" ? "user" : "admin")}>
                    <div className="who">{m.from === "admin" ? "Вы" : "Клиент"} · {fmt(m.at)}</div>
                    <div className="txt">{m.text}</div>
                  </div>
                ))}
              </div>
              <textarea className="in" rows={3} maxLength={2000} value={reply} onChange={(e) => setReply(e.target.value)} placeholder="Ответ клиенту" />
              <p style={{ marginTop: 10 }}>
                <button className="btn primary" disabled={!reply.trim()} onClick={() => tAct(open.id, { action: "reply", text: reply })}>Ответить</button>
              </p>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

"use client";

import { useEffect, useState } from "react";

type Order = { status: "pending" | "paid" | "failed"; days: number; amount: string; currency: string; key?: string; payUrl?: string };

export default function OrderView({ id, support }: { id: string; support?: string }) {
  const [order, setOrder] = useState<Order | null>(null);
  const [missing, setMissing] = useState(false);
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    let stop = false;
    let timer: ReturnType<typeof setTimeout> | undefined;
    async function load() {
      try {
        const res = await fetch(`/api/order/${id}`, { cache: "no-store" });
        if (res.status === 404) {
          if (!stop) setMissing(true);
          return;
        }
        const data = (await res.json()) as Order;
        if (stop) return;
        setOrder(data);
        if (data.status === "pending") timer = setTimeout(load, 5000);
      } catch {
        if (!stop) timer = setTimeout(load, 8000);
      }
    }
    load();
    return () => {
      stop = true;
      if (timer) clearTimeout(timer);
    };
  }, [id]);

  async function copy() {
    if (!order?.key) return;
    try {
      await navigator.clipboard.writeText(order.key);
      setCopied(true);
      setTimeout(() => setCopied(false), 1500);
    } catch {}
  }

  return (
    <div className="order">
      <div className="panel">
        <h2 style={{ fontSize: 24 }}>Ваш заказ</h2>
        {missing && <p className="err">Заказ не найден. Проверьте ссылку.</p>}
        {!missing && !order && <p className="note">Загрузка…</p>}
        {order && (
          <>
            <p style={{ marginTop: 10 }}>
              Подписка Про {order.days >= 36500 ? "навсегда" : `на ${order.days} дн.`} · {order.amount} {order.currency === "RUB" ? "₽" : order.currency}{" "}
              <span className={"status " + order.status}>
                {order.status === "paid" ? "оплачено" : order.status === "pending" ? "ожидает оплаты" : "не оплачено"}
              </span>
            </p>

            {order.status === "pending" && (
              <>
                <p className="note">Страница обновляется сама. Когда платёж подтвердится, здесь появится ключ.</p>
                {order.payUrl && (
                  <p style={{ marginTop: 14 }}>
                    <a className="btn primary" href={order.payUrl}>Перейти к оплате</a>
                  </p>
                )}
              </>
            )}

            {order.status === "paid" && order.key && (
              <>
                <div className="keybox">{order.key}</div>
                <button className="btn" onClick={copy}>{copied ? "Скопировано" : "Скопировать ключ"}</button>
                <ol className="steps">
                  <li>Откройте игру и меню скрипта командой /amine.</li>
                  <li>Перейдите на вкладку «Подписка», вставьте ключ и нажмите «Активировать».</li>
                  <li>Сохраните ключ: он привязывается к компьютеру при первой активации, срок (если тариф не «навсегда») считается с этого момента.</li>
                </ol>
                <p className="note">Эта страница всегда покажет ваш ключ, сохраните ссылку на неё.</p>
              </>
            )}

            {order.status === "failed" && (
              <p className="note">
                Счёт отменён или истёк. Если вы уже оплатили, напишите в <a href={`/support?order=${id}`}>поддержку</a>{support ? <> или <a href={support}>{support}</a></> : ""}, номер заказа подставится сам.
              </p>
            )}
          </>
        )}
        <p style={{ marginTop: 22 }}>
          <a href="/">← На главную</a>
        </p>
      </div>
    </div>
  );
}

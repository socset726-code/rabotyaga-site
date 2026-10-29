import { createHmac, createHash, timingSafeEqual } from "crypto";

// Crypto Pay API (@CryptoBot). Документация: https://help.crypt.bot/crypto-pay-api
function apiBase(): string {
  return (process.env.CRYPTOPAY_API || "https://pay.crypt.bot/api").replace(/\/+$/, "");
}

function token(): string {
  const t = process.env.CRYPTOPAY_TOKEN;
  if (!t) throw new Error("Не задан CRYPTOPAY_TOKEN");
  return t;
}

type ApiResponse<T> = { ok: boolean; result?: T; error?: unknown };

export type Invoice = {
  invoice_id: number;
  status: "active" | "paid" | "expired";
  bot_invoice_url?: string;
  web_app_invoice_url?: string;
  mini_app_invoice_url?: string;
  payload?: string;
};

async function call<T>(method: string, params: Record<string, string | number>): Promise<T> {
  const res = await fetch(`${apiBase()}/${method}`, {
    method: "POST",
    headers: { "Crypto-Pay-API-Token": token(), "Content-Type": "application/json" },
    body: JSON.stringify(params),
    cache: "no-store",
  });
  const data = (await res.json().catch(() => null)) as ApiResponse<T> | null;
  if (!res.ok || !data || !data.ok || data.result === undefined) {
    throw new Error(`CryptoPay ${method}: ${res.status} ${JSON.stringify(data?.error ?? "ошибка")}`);
  }
  return data.result;
}

export async function createInvoice(p: {
  amount: string;
  fiat: string;
  orderId: string;
  description: string;
  returnUrl: string;
}): Promise<{ id: string; url: string }> {
  const inv = await call<Invoice>("createInvoice", {
    currency_type: "fiat",
    fiat: p.fiat,
    amount: p.amount,
    description: p.description.slice(0, 1000),
    payload: p.orderId,
    paid_btn_name: "viewItem",
    paid_btn_url: p.returnUrl,
    expires_in: 3600,
  });
  const url = inv.bot_invoice_url || inv.web_app_invoice_url;
  if (!url) throw new Error("CryptoPay: в ответе нет ссылки на оплату");
  return { id: String(inv.invoice_id), url };
}

export async function getInvoice(id: string): Promise<Invoice | null> {
  const list = await call<{ items?: Invoice[] } | Invoice[]>("getInvoices", { invoice_ids: id });
  const items = Array.isArray(list) ? list : list.items || [];
  return items.find((i) => String(i.invoice_id) === id) ?? null;
}

// Подпись вебхука: HMAC-SHA256 от сырого тела, ключ = SHA256(токен приложения).
export function verifyWebhook(raw: string, signature: string | null): boolean {
  if (!signature) return false;
  const secret = createHash("sha256").update(token()).digest();
  const expected = createHmac("sha256", secret).update(raw).digest("hex");
  const a = Buffer.from(signature.toLowerCase());
  const b = Buffer.from(expected);
  return a.length === b.length && timingSafeEqual(a, b);
}

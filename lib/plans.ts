// Тарифы. Меняйте цены и сроки здесь. Цены в рублях: счёт выставляется в RUB,
// покупатель платит любой криптой по текущему курсу.
export type Plan = {
  id: string;
  title: string;
  days: number;
  price: string; // строка, разделитель точка
  badge?: string;
  lifetime?: boolean;
};

export const CURRENCY = "RUB";

// Для «навсегда» используется срок в 100 лет
export const LIFETIME_DAYS = 36500;

export const PLANS: Plan[] = [
  { id: "m1", title: "30 дней", days: 30, price: "100" },
  { id: "m3", title: "90 дней", days: 90, price: "300" },
  { id: "life", title: "Навсегда", days: LIFETIME_DAYS, price: "500", badge: "Один раз", lifetime: true },
];

export function findPlan(id: string): Plan | undefined {
  return PLANS.find((p) => p.id === id);
}

export function currencySign(c: string): string {
  return c === "RUB" ? "₽" : c === "USD" ? "$" : c === "EUR" ? "€" : c;
}

export function daysLabel(days: number): string {
  return days >= LIFETIME_DAYS ? "навсегда" : `${days} дн.`;
}

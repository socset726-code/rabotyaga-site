// Необязательное уведомление владельцу в Telegram о новых обращениях и оплатах.
// Включается переменными NOTIFY_BOT_TOKEN (токен бота от @BotFather) и NOTIFY_CHAT_ID (ваш chat id).
export async function notify(text: string): Promise<void> {
  const token = process.env.NOTIFY_BOT_TOKEN;
  const chat = process.env.NOTIFY_CHAT_ID;
  if (!token || !chat) return;
  try {
    await fetch(`https://api.telegram.org/bot${token}/sendMessage`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ chat_id: chat, text: text.slice(0, 3500), disable_web_page_preview: true }),
      cache: "no-store",
      signal: AbortSignal.timeout(4000),
    });
  } catch (e) {
    console.error("notify failed", e);
  }
}

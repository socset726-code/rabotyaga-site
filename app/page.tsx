import Pricing from "@/components/Pricing";
import { CURRENCY, PLANS, currencySign } from "@/lib/plans";

const FEATURES: { name: string; hint?: string; pro: boolean }[] = [
  { name: "Маршруты и авто-добыча руды", hint: "ходит по кругу, находит и копает руду рядом с путём", pro: false },
  { name: "Запись и выбор своих маршрутов", pro: false },
  { name: "Приоритет руд", pro: false },
  { name: "Конфиги и цветовые темы", pro: false },
  { name: "ИИ пути", hint: "сам прыгает и обходит препятствия, если застрял", pro: true },
  { name: "Респавн руды: таймеры и ожидание у места", hint: "бот знает, когда руда вырастет, и не бегает впустую", pro: true },
  { name: "Карта покрытия маршрута", pro: true },
  { name: "Telegram: уведомления и управление", hint: "администратор в игре, застрял, телепорт, /stop и /run с телефона", pro: true },
  { name: "Авто-пиво", pro: true },
  { name: "Оптимизация маршрутов и авто-маршрут", hint: "убирает лишние точки, строит путь по найденным рудам", pro: true },
  { name: "Отключение коллизии", pro: true },
];

const FAQ: { q: string; a: string }[] = [
  {
    q: "Как получить ключ?",
    a: "Выберите тариф, оплатите счёт через Crypto Bot в Telegram. Когда платёж подтвердится (обычно несколько минут), на странице заказа появится ключ. Сохраните его.",
  },
  {
    q: "Как установить?",
    a: "Положите файл скрипта в папку moonloader, запустите игру и откройте меню командой /amine. На вкладке «Подписка» вставьте ключ и нажмите «Активировать».",
  },
  {
    q: "К чему привязывается ключ?",
    a: "Ключ привязывается к одному компьютеру при первой активации. Срок подписки начинается с этого момента. Если сменили компьютер — напишите в поддержку, ключ сбросят.",
  },
  {
    q: "Что будет, когда подписка закончится?",
    a: "Бесплатные функции (маршруты, авто-добыча, приоритет руд, конфиги, цвета) продолжат работать. Платные отключатся, пока вы не продлите подписку новым ключом.",
  },
  {
    q: "Безопасно ли это для аккаунта?",
    a: "Скрипт автоматизирует игровой процесс, а правила многих серверов такое запрещают. Администрация может ограничить аккаунт. Вы используете скрипт на свой риск, возврат за санкции сервера не предусмотрен.",
  },
];

export default function Home() {
  const support = process.env.NEXT_PUBLIC_SUPPORT_URL;
  const download = process.env.NEXT_PUBLIC_DOWNLOAD_URL;
  return (
    <>
      <div className="wrap">
        <nav className="nav">
          <a className="logo" href="/">RABOTYAGA MAIN</a>
          <div className="nav-links">
            <a href="/">Главная</a>
            <a href="#features">Возможности</a>
            <a href="#pricing">Тарифы</a>
            <a href="#faq">Вопросы</a>
            <a href="/support">Поддержка</a>
          </div>
        </nav>

        <header className="hero">
          <div className="kicker">Скрипт для MoonLoader · Arizona RP</div>
          <h1>Шахта работает сама, пока вы занимаетесь другим</h1>
          <p className="lead">
            Бот ходит по маршруту, добывает руду, сам обходит препятствия и пишет вам в Telegram, если что-то пошло не так.
          </p>
          <div className="cta">
            <a className="btn primary" href="#pricing">Купить подписку Про</a>
            {download && <a className="btn" href={download} download="Rabotyagamain.lua">Скачать бесплатную версию</a>}
          </div>
        </header>

        <section id="features">
          <h2 className="sec-title">Бесплатно и в подписке</h2>
          <p className="sec-sub">Бесплатно бот ходит по маршруту и добывает руду. Про добавляет то, что избавляет от присмотра за ним.</p>
          <div className="compare">
            <div className="row">
              <span>Функция</span>
              <span className="c">Бесплатно</span>
              <span className="c pro-head">Про</span>
            </div>
            {FEATURES.map((f) => (
              <div className="row" key={f.name}>
                <span className="name">
                  {f.name}
                  {f.hint && <small>{f.hint}</small>}
                </span>
                <span className={"c " + (f.pro ? "no" : "yes")}>{f.pro ? "—" : "✓"}</span>
                <span className="c pro">✓</span>
              </div>
            ))}
          </div>
        </section>

        <section id="pricing">
          <h2 className="sec-title">Тарифы</h2>
          <p className="sec-sub">Один ключ — один компьютер. Все платные функции открыты на любом тарифе. Цены в рублях, оплата любой криптовалютой по текущему курсу.</p>
          <Pricing plans={PLANS} currency={currencySign(CURRENCY)} />
        </section>

        <section id="faq">
          <h2 className="sec-title">Вопросы</h2>
          <div className="faq">
            {FAQ.map((f) => (
              <details key={f.q}>
                <summary>{f.q}</summary>
                <p>{f.a}</p>
              </details>
            ))}
          </div>
        </section>

        <footer>
          <div>© Rabotyaga Main. Проект не связан с Arizona RP и не является их продуктом.</div>
          <div style={{ marginTop: 6 }}>
            <a href="/support">Написать в поддержку</a>
            {support && <> · <a href={support}>{support}</a></>}
          </div>
        </footer>
      </div>
    </>
  );
}

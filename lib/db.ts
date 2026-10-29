import { Redis } from "@upstash/redis";

// Тонкая обёртка над хранилищем. В продакшене нужен Upstash Redis.
// Без него (только локально, в dev) данные живут в памяти процесса.

type Store = {
  get<T>(key: string): Promise<T | null>;
  set(key: string, value: unknown): Promise<void>;
  setnx(key: string, value: string, ttlSec: number): Promise<boolean>;
  sadd(key: string, member: string): Promise<void>;
  smembers(key: string): Promise<string[]>;
  mget<T>(keys: string[]): Promise<(T | null)[]>;
  del(key: string): Promise<void>;
  incr(key: string, ttlSec: number): Promise<number>;
};

function makeRedis(): Store {
  const url = process.env.UPSTASH_REDIS_REST_URL || process.env.KV_REST_API_URL;
  const token = process.env.UPSTASH_REDIS_REST_TOKEN || process.env.KV_REST_API_TOKEN;
  const r = new Redis({ url: url as string, token: token as string });
  return {
    async get<T>(key: string) {
      return (await r.get<T>(key)) ?? null;
    },
    async set(key, value) {
      await r.set(key, value as never);
    },
    async setnx(key, value, ttlSec) {
      const res = await r.set(key, value, { nx: true, ex: ttlSec });
      return res === "OK";
    },
    async sadd(key, member) {
      await r.sadd(key, member);
    },
    async smembers(key) {
      return (await r.smembers(key)) as string[];
    },
    async mget<T>(keys: string[]) {
      if (keys.length === 0) return [];
      const res = await r.mget<(T | null)[]>(...keys);
      return res.map((x) => x ?? null);
    },
    async del(key) {
      await r.del(key);
    },
    async incr(key, ttlSec) {
      const n = await r.incr(key);
      if (n === 1) await r.expire(key, ttlSec);
      return n;
    },
  };
}

type MemState = { kv: Map<string, unknown>; sets: Map<string, Set<string>>; exp: Map<string, number> };

function makeMemory(): Store {
  const g = globalThis as unknown as { __mem?: MemState };
  if (!g.__mem) g.__mem = { kv: new Map(), sets: new Map(), exp: new Map() };
  const m = g.__mem;
  const alive = (key: string) => {
    const e = m.exp.get(key);
    if (e && e < Date.now()) {
      m.kv.delete(key);
      m.exp.delete(key);
    }
  };
  return {
    async get<T>(key: string) {
      alive(key);
      return (m.kv.has(key) ? (JSON.parse(JSON.stringify(m.kv.get(key))) as T) : null);
    },
    async set(key, value) {
      m.kv.set(key, JSON.parse(JSON.stringify(value)));
    },
    async setnx(key, value, ttlSec) {
      alive(key);
      if (m.kv.has(key)) return false;
      m.kv.set(key, value);
      m.exp.set(key, Date.now() + ttlSec * 1000);
      return true;
    },
    async sadd(key, member) {
      if (!m.sets.has(key)) m.sets.set(key, new Set());
      m.sets.get(key)!.add(member);
    },
    async smembers(key) {
      return Array.from(m.sets.get(key) ?? []);
    },
    async mget<T>(keys: string[]) {
      return keys.map((k) => {
        alive(k);
        return m.kv.has(k) ? (JSON.parse(JSON.stringify(m.kv.get(k))) as T) : null;
      });
    },
    async del(key) {
      m.kv.delete(key);
    },
    async incr(key, ttlSec) {
      alive(key);
      const n = ((m.kv.get(key) as number) || 0) + 1;
      m.kv.set(key, n);
      if (n === 1) m.exp.set(key, Date.now() + ttlSec * 1000);
      return n;
    },
  };
}

let cached: Store | null = null;

export function db(): Store {
  if (cached) return cached;
  const hasRedis = !!(
    (process.env.UPSTASH_REDIS_REST_URL && process.env.UPSTASH_REDIS_REST_TOKEN) ||
    (process.env.KV_REST_API_URL && process.env.KV_REST_API_TOKEN)
  );
  if (hasRedis) {
    cached = makeRedis();
  } else if (process.env.NODE_ENV !== "production") {
    cached = makeMemory();
  } else {
    throw new Error("Не подключена база: задайте UPSTASH_REDIS_REST_URL и UPSTASH_REDIS_REST_TOKEN");
  }
  return cached;
}

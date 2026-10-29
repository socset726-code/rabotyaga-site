export function siteUrl(req?: Request): string {
  const fixed = process.env.SITE_URL;
  if (fixed) return fixed.replace(/\/+$/, "");
  if (process.env.VERCEL_PROJECT_PRODUCTION_URL) return `https://${process.env.VERCEL_PROJECT_PRODUCTION_URL}`;
  if (process.env.VERCEL_URL) return `https://${process.env.VERCEL_URL}`;
  if (req) return new URL(req.url).origin;
  return "http://localhost:3000";
}

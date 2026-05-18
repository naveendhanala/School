# Performance & Redundancy Cleanup — Design Spec

**Date:** 2026-05-18  
**Status:** Approved

---

## Goal

Improve perceived and actual loading speed across all dashboard pages, and eliminate duplicated code that creates maintenance risk.

No behaviour changes. No new features. All changes are mechanical.

---

## Scope

### 1. Shared Constants — `lib/constants/labels.ts`

Extract label mapping objects that are currently copy-pasted across 4+ files:

- `HEAD_LABELS: Record<FeeHead, string>` — fee head display names
- `MODE_LABELS: Record<PaymentMode, string>` — payment mode display names

**Consumers to update:**
- `app/(dashboard)/dashboard-client.tsx`
- `app/(dashboard)/reports/reports-client.tsx`
- `app/(dashboard)/collect-fee/payment-form.tsx`
- `app/(dashboard)/collect-fee/payment-history.tsx`

---

### 2. Shared Fee Utilities — `lib/utils/fee-utils.ts`

Extract duplicated data-transformation logic:

- `buildClassFeeMap(feeStructure)` — builds `Map<classId, {tuition, book}>` from raw fee_structure rows. Currently duplicated in Dashboard, Pending Fees, and Reports pages.
- `buildFeeStats(enrollments, payments, classFeeMap)` — builds `classStatsMap` and `routeStatsMap` aggregations. Currently duplicated in Dashboard and Reports pages (~50 lines each).

**Consumers to update:**
- `app/(dashboard)/page.tsx`
- `app/(dashboard)/pending-fees/page.tsx`
- `app/(dashboard)/reports/page.tsx`

---

### 3. Shared UI Component — `components/no-active-year.tsx`

Extract the "no active academic year" message block, currently copy-pasted across 6 pages with only the page title differing.

```tsx
// Accepts: title prop
<NoActiveYear title="Dashboard" />
```

**Consumers to update:**
- `app/(dashboard)/page.tsx`
- `app/(dashboard)/students/page.tsx`
- `app/(dashboard)/pending-fees/page.tsx`
- `app/(dashboard)/reports/page.tsx`
- `app/(dashboard)/bank-deposits/page.tsx`
- `app/(dashboard)/bridge-course/page.tsx`

---

### 4. Loading Skeletons

Add `loading.tsx` files using animated skeleton placeholders (Tailwind `animate-pulse`). Next.js App Router automatically shows these while the page's server component is fetching data.

**Files to create:**
- `app/(dashboard)/loading.tsx` — shared skeleton for the dashboard shell (sidebar + content area)
- `app/(dashboard)/students/loading.tsx`
- `app/(dashboard)/collect-fee/loading.tsx`
- `app/(dashboard)/pending-fees/loading.tsx`
- `app/(dashboard)/reports/loading.tsx`
- `app/(dashboard)/fee-setup/loading.tsx`
- `app/(dashboard)/bank-deposits/loading.tsx`
- `app/(dashboard)/bridge-course/loading.tsx`

Each skeleton mirrors the rough shape of its page (table rows for list pages, stat cards for the dashboard).

---

### 5. Lazy-load Recharts

`recharts` (~50KB) is currently imported eagerly in two client components. Wrap with `next/dynamic` so it only loads after the page shell has rendered.

**Files to update:**
- `app/(dashboard)/dashboard-client.tsx`
- `app/(dashboard)/bridge-course/bridge-course-client.tsx`

Pattern:
```tsx
const BarChart = dynamic(() => import('recharts').then(m => ({ default: m.BarChart })), { ssr: false })
// repeat for each recharts export used
```

---

### 6. Next.js Config — `next.config.ts`

Add:
```ts
images: { formats: ['image/avif', 'image/webp'] }
compress: true
```

`swcMinify` and `optimizeCss` are not needed — Next.js 16 enables SWC minification by default and `optimizeCss` requires an extra package.

---

### 7. Remove Unused Dependencies

`react-hook-form` and `@hookform/resolvers` are installed but never imported anywhere in the project. Remove both.

```
npm uninstall react-hook-form @hookform/resolvers
```

---

## What Is NOT Changing

- No changes to Supabase query logic or data fetching strategy
- No changes to routing structure
- No changes to UI design or component behaviour
- No changes to auth flow

---

## File Change Summary

| File | Action |
|------|--------|
| `lib/constants/labels.ts` | Create |
| `lib/utils/fee-utils.ts` | Create |
| `components/no-active-year.tsx` | Create |
| `app/(dashboard)/loading.tsx` | Create |
| `app/(dashboard)/*/loading.tsx` (7 files) | Create |
| `app/(dashboard)/page.tsx` | Update imports |
| `app/(dashboard)/students/page.tsx` | Update imports |
| `app/(dashboard)/pending-fees/page.tsx` | Update imports |
| `app/(dashboard)/reports/page.tsx` | Update imports |
| `app/(dashboard)/bank-deposits/page.tsx` | Update imports |
| `app/(dashboard)/bridge-course/page.tsx` | Update imports |
| `app/(dashboard)/dashboard-client.tsx` | Lazy recharts + update imports |
| `app/(dashboard)/reports/reports-client.tsx` | Update imports |
| `app/(dashboard)/collect-fee/payment-form.tsx` | Update imports |
| `app/(dashboard)/collect-fee/payment-history.tsx` | Update imports |
| `app/(dashboard)/bridge-course/bridge-course-client.tsx` | Lazy recharts |
| `next.config.ts` | Add image + compress config |
| `package.json` | Remove 2 unused packages |

**Total: ~20 files touched, 8 new files created.**

# Performance & Redundancy Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Improve perceived and actual loading speed across all dashboard pages, and eliminate copy-pasted code that creates maintenance risk.

**Architecture:** Extract duplicated constants and utilities into shared modules; replace inline copy-paste with imports. Add Next.js App Router `loading.tsx` files for every dashboard route so users see animated skeletons instead of blank screens while Supabase data loads. Lazy-load `recharts` (50 KB) by extracting chart sections into dedicated files loaded with `next/dynamic`.

**Tech Stack:** Next.js 16 App Router, React 19, TypeScript, Tailwind CSS, Vitest, Supabase

---

## File Map

| Path | Action | Purpose |
|------|--------|---------|
| `lib/constants/labels.ts` | Create | Shared `HEAD_LABELS` and `MODE_LABELS` lookup maps |
| `lib/utils/fee-utils.ts` | Create | `buildClassFeeMap()` pure utility |
| `tests/lib/utils/fee-utils.test.ts` | Create | Unit tests for `buildClassFeeMap` |
| `components/no-active-year.tsx` | Create | Shared "no active year" message component |
| `app/(dashboard)/dashboard-charts.tsx` | Create | Recharts chart section extracted from dashboard-client |
| `app/(dashboard)/bridge-course/bridge-charts.tsx` | Create | Recharts chart section extracted from bridge-course-client |
| `app/(dashboard)/loading.tsx` | Create | Dashboard home skeleton |
| `app/(dashboard)/students/loading.tsx` | Create | Students page skeleton |
| `app/(dashboard)/collect-fee/loading.tsx` | Create | Collect Fee page skeleton |
| `app/(dashboard)/pending-fees/loading.tsx` | Create | Pending Fees page skeleton |
| `app/(dashboard)/reports/loading.tsx` | Create | Reports page skeleton |
| `app/(dashboard)/fee-setup/loading.tsx` | Create | Fee Setup page skeleton |
| `app/(dashboard)/bank-deposits/loading.tsx` | Create | Bank Deposits page skeleton |
| `app/(dashboard)/bridge-course/loading.tsx` | Create | Bridge Course page skeleton |
| `app/(dashboard)/dashboard-client.tsx` | Modify | Remove local labels; lazy-load DashboardCharts |
| `app/(dashboard)/reports/reports-client.tsx` | Modify | Remove local labels |
| `app/(dashboard)/collect-fee/payment-history.tsx` | Modify | Remove local labels |
| `app/(dashboard)/page.tsx` | Modify | Use `buildClassFeeMap`; use `NoActiveYear` |
| `app/(dashboard)/pending-fees/page.tsx` | Modify | Use `buildClassFeeMap`; use `NoActiveYear` |
| `app/(dashboard)/reports/page.tsx` | Modify | Use `buildClassFeeMap`; use `NoActiveYear` |
| `app/(dashboard)/students/page.tsx` | Modify | Use `NoActiveYear` |
| `app/(dashboard)/bank-deposits/page.tsx` | Modify | Use `NoActiveYear` |
| `app/(dashboard)/bridge-course/page.tsx` | Modify | Use `NoActiveYear` |
| `app/(dashboard)/bridge-course/bridge-course-client.tsx` | Modify | Lazy-load BridgeCharts; remove recharts import |
| `next.config.ts` | Modify | Add image formats and compress |
| `package.json` | Modify | Remove unused `react-hook-form` and `@hookform/resolvers` |

---

## Task 1: Create `lib/constants/labels.ts`

**Files:**
- Create: `lib/constants/labels.ts`

- [ ] **Step 1: Create the file**

```typescript
// lib/constants/labels.ts
export const HEAD_LABELS: Record<string, string> = {
  tuition: 'Tuition',
  book: 'Book',
  transport: 'Transport',
  hostel: 'Hostel',
  admission: 'Admission',
  uniform: 'Uniform',
  exam: 'Exam',
  other: 'Other',
}

export const MODE_LABELS: Record<string, string> = {
  cash: 'Cash',
  upi: 'UPI',
  cheque: 'Cheque',
  neft_rtgs: 'NEFT/RTGS',
  demand_draft: 'DD',
}
```

- [ ] **Step 2: Verify TypeScript compiles**

Run: `npx tsc --noEmit`
Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add lib/constants/labels.ts
git commit -m "feat: extract HEAD_LABELS and MODE_LABELS to shared constants"
```

---

## Task 2: Update consumers of labels constants

**Files:**
- Modify: `app/(dashboard)/dashboard-client.tsx`
- Modify: `app/(dashboard)/reports/reports-client.tsx`
- Modify: `app/(dashboard)/collect-fee/payment-history.tsx`

- [ ] **Step 1: Update `dashboard-client.tsx`**

Replace the local constant block (lines 21–29):
```typescript
const HEAD_LABELS: Record<string, string> = {
  tuition: 'Tuition', book: 'Book', transport: 'Transport',
  hostel: 'Hostel', admission: 'Admission', uniform: 'Uniform',
  exam: 'Exam', other: 'Other',
}
const MODE_LABELS: Record<string, string> = {
  cash: 'Cash', upi: 'UPI', cheque: 'Cheque',
  neft_rtgs: 'NEFT/RTGS', demand_draft: 'DD',
}
```

With an import at the top of the file (after the existing imports):
```typescript
import { HEAD_LABELS, MODE_LABELS } from '@/lib/constants/labels'
```

- [ ] **Step 2: Update `reports-client.tsx`**

Remove the local constant block (lines 23–31):
```typescript
const HEAD_LABELS: Record<string, string> = {
  tuition: 'Tuition', book: 'Book', transport: 'Transport',
  hostel: 'Hostel', admission: 'Admission', uniform: 'Uniform',
  exam: 'Exam', other: 'Other',
}
const MODE_LABELS: Record<string, string> = {
  cash: 'Cash', upi: 'UPI', cheque: 'Cheque',
  neft_rtgs: 'NEFT/RTGS', demand_draft: 'DD',
}
```

Add to the existing imports:
```typescript
import { HEAD_LABELS, MODE_LABELS } from '@/lib/constants/labels'
```

- [ ] **Step 3: Update `payment-history.tsx`**

Remove the local constant block (lines 12–29):
```typescript
const MODE_LABELS: Record<string, string> = {
  cash: 'Cash',
  upi: 'UPI',
  cheque: 'Cheque',
  neft_rtgs: 'NEFT/RTGS',
  demand_draft: 'DD',
}

const HEAD_LABELS: Record<string, string> = {
  tuition: 'Tuition',
  book: 'Book',
  transport: 'Transport',
  hostel: 'Hostel',
  admission: 'Admission',
  uniform: 'Uniform',
  exam: 'Exam',
  other: 'Other',
}
```

Add to the existing imports:
```typescript
import { HEAD_LABELS, MODE_LABELS } from '@/lib/constants/labels'
```

- [ ] **Step 4: Verify TypeScript compiles**

Run: `npx tsc --noEmit`
Expected: No errors.

- [ ] **Step 5: Commit**

```bash
git add app/(dashboard)/dashboard-client.tsx \
        app/(dashboard)/reports/reports-client.tsx \
        app/(dashboard)/collect-fee/payment-history.tsx
git commit -m "refactor: replace local label maps with shared constants"
```

---

## Task 3: Create `lib/utils/fee-utils.ts` with tests

**Files:**
- Create: `lib/utils/fee-utils.ts`
- Create: `tests/lib/utils/fee-utils.test.ts`

- [ ] **Step 1: Write the failing test**

Create `tests/lib/utils/fee-utils.test.ts`:

```typescript
import { describe, test, expect } from 'vitest'
import { buildClassFeeMap } from '@/lib/utils/fee-utils'

describe('buildClassFeeMap', () => {
  test('maps tuition and book amounts by class_id', () => {
    const rows = [
      { class_id: 'c1', fee_head: 'tuition', amount: '5000' },
      { class_id: 'c1', fee_head: 'book', amount: '500' },
      { class_id: 'c2', fee_head: 'tuition', amount: '4000' },
    ]
    const map = buildClassFeeMap(rows)
    expect(map.get('c1')).toEqual({ tuition: 5000, book: 500 })
    expect(map.get('c2')).toEqual({ tuition: 4000, book: 0 })
  })

  test('defaults missing fee_heads to 0', () => {
    const rows = [{ class_id: 'c1', fee_head: 'book', amount: 300 }]
    const map = buildClassFeeMap(rows)
    expect(map.get('c1')).toEqual({ tuition: 0, book: 300 })
  })

  test('returns empty map for empty input', () => {
    expect(buildClassFeeMap([]).size).toBe(0)
  })

  test('converts string amounts to numbers', () => {
    const rows = [{ class_id: 'c1', fee_head: 'tuition', amount: '1500.50' }]
    const map = buildClassFeeMap(rows)
    expect(map.get('c1')!.tuition).toBe(1500.5)
  })
})
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `npx vitest run tests/lib/utils/fee-utils.test.ts`
Expected: FAIL — "Cannot find module '@/lib/utils/fee-utils'"

- [ ] **Step 3: Implement `fee-utils.ts`**

Create `lib/utils/fee-utils.ts`:

```typescript
import type { ClassFeeHead } from '@/lib/types'

export function buildClassFeeMap(
  rows: { class_id: string; fee_head: string; amount: number | string }[]
): Map<string, Record<ClassFeeHead, number>> {
  const map = new Map<string, Record<ClassFeeHead, number>>()
  for (const fs of rows) {
    const entry = map.get(fs.class_id) ?? { tuition: 0, book: 0 }
    ;(entry as Record<string, number>)[fs.fee_head] = Number(fs.amount)
    map.set(fs.class_id, entry)
  }
  return map
}
```

- [ ] **Step 4: Run tests to verify they pass**

Run: `npx vitest run tests/lib/utils/fee-utils.test.ts`
Expected: PASS — 4 tests passing.

- [ ] **Step 5: Commit**

```bash
git add lib/utils/fee-utils.ts tests/lib/utils/fee-utils.test.ts
git commit -m "feat: extract buildClassFeeMap utility with tests"
```

---

## Task 4: Update pages to use `buildClassFeeMap`

**Files:**
- Modify: `app/(dashboard)/page.tsx` (dashboard)
- Modify: `app/(dashboard)/pending-fees/page.tsx`
- Modify: `app/(dashboard)/reports/page.tsx`

- [ ] **Step 1: Update `app/(dashboard)/page.tsx`**

Add import at the top (after existing imports):
```typescript
import { buildClassFeeMap } from '@/lib/utils/fee-utils'
```

Replace the inline classFeeMap block (lines 99–104):
```typescript
// class_id → { tuition: number, book: number }
const classFeeMap = new Map<string, Record<ClassFeeHead, number>>()
for (const fs of feeStructure ?? []) {
  const entry = classFeeMap.get(fs.class_id) ?? { tuition: 0, book: 0 }
  ;(entry as Record<string, number>)[fs.fee_head] = Number(fs.amount)
  classFeeMap.set(fs.class_id, entry)
}
```

With:
```typescript
const classFeeMap = buildClassFeeMap(feeStructure ?? [])
```

Also remove the `ClassFeeHead` type import from `@/lib/types` if it's no longer used directly in this file (check if it's used elsewhere in the file first).

- [ ] **Step 2: Update `app/(dashboard)/pending-fees/page.tsx`**

Add import:
```typescript
import { buildClassFeeMap } from '@/lib/utils/fee-utils'
```

Replace the inline classFeeMap block (lines 65–70):
```typescript
// class_id → { tuition: number, book: number }
const classFeeMap = new Map<string, Record<ClassFeeHead, number>>()
for (const fs of feeStructure ?? []) {
  const entry = classFeeMap.get(fs.class_id) ?? { tuition: 0, book: 0 }
  ;(entry as Record<string, number>)[fs.fee_head] = Number(fs.amount)
  classFeeMap.set(fs.class_id, entry)
}
```

With:
```typescript
const classFeeMap = buildClassFeeMap(feeStructure ?? [])
```

Remove `ClassFeeHead` from the `@/lib/types` import line if it's no longer used directly.

- [ ] **Step 3: Update `app/(dashboard)/reports/page.tsx`**

Add import:
```typescript
import { buildClassFeeMap } from '@/lib/utils/fee-utils'
```

Replace the inline classFeeMap block (lines 197–202):
```typescript
const classFeeMap = new Map<string, Record<ClassFeeHead, number>>()
for (const fs of feeStructure ?? []) {
  const entry = classFeeMap.get(fs.class_id) ?? { tuition: 0, book: 0 }
  ;(entry as Record<string, number>)[fs.fee_head] = Number(fs.amount)
  classFeeMap.set(fs.class_id, entry)
}
```

With:
```typescript
const classFeeMap = buildClassFeeMap(feeStructure ?? [])
```

Remove `ClassFeeHead` from the `@/lib/types` import line if it's no longer used directly.

- [ ] **Step 4: Verify TypeScript compiles**

Run: `npx tsc --noEmit`
Expected: No errors.

- [ ] **Step 5: Commit**

```bash
git add "app/(dashboard)/page.tsx" \
        "app/(dashboard)/pending-fees/page.tsx" \
        "app/(dashboard)/reports/page.tsx"
git commit -m "refactor: replace inline classFeeMap loops with buildClassFeeMap()"
```

---

## Task 5: Create `components/no-active-year.tsx`

**Files:**
- Create: `components/no-active-year.tsx`

- [ ] **Step 1: Create the component**

```typescript
// components/no-active-year.tsx
interface NoActiveYearProps {
  title: string
}

export function NoActiveYear({ title }: NoActiveYearProps) {
  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold text-gray-900">{title}</h1>
      <p className="mt-2 text-gray-500">No active academic year. Set one up in Fee Setup.</p>
    </div>
  )
}
```

- [ ] **Step 2: Verify TypeScript compiles**

Run: `npx tsc --noEmit`
Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add components/no-active-year.tsx
git commit -m "feat: add NoActiveYear shared component"
```

---

## Task 6: Update all 6 pages to use `NoActiveYear`

**Files:**
- Modify: `app/(dashboard)/page.tsx`
- Modify: `app/(dashboard)/students/page.tsx`
- Modify: `app/(dashboard)/pending-fees/page.tsx`
- Modify: `app/(dashboard)/reports/page.tsx`
- Modify: `app/(dashboard)/bank-deposits/page.tsx`
- Modify: `app/(dashboard)/bridge-course/page.tsx`

In each file, add the import and replace the inline block. The pattern is identical in every file — only the `title` prop changes.

Add import to each file:
```typescript
import { NoActiveYear } from '@/components/no-active-year'
```

Replace the inline `if (!activeYear) { return ( <div>...</div> ) }` block with:

**Dashboard (`page.tsx`):**
```typescript
if (!activeYear) return <NoActiveYear title="Dashboard" />
```

**Students (`students/page.tsx`):**
```typescript
if (!activeYear) return <NoActiveYear title="Students" />
```

**Pending Fees (`pending-fees/page.tsx`):**
```typescript
if (!activeYear) return <NoActiveYear title="Pending Fees" />
```

**Reports (`reports/page.tsx`):**
```typescript
if (!activeYear) return <NoActiveYear title="Reports" />
```

**Bank Deposits (`bank-deposits/page.tsx`):**
```typescript
if (!activeYear) return <NoActiveYear title="Bank Deposits" />
```

**Bridge Course (`bridge-course/page.tsx`):**
```typescript
if (!activeYear) return <NoActiveYear title="Bridge Course" />
```

- [ ] **Step 1: Apply changes to all 6 files** (as described above)

- [ ] **Step 2: Verify TypeScript compiles**

Run: `npx tsc --noEmit`
Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add "app/(dashboard)/page.tsx" \
        "app/(dashboard)/students/page.tsx" \
        "app/(dashboard)/pending-fees/page.tsx" \
        "app/(dashboard)/reports/page.tsx" \
        "app/(dashboard)/bank-deposits/page.tsx" \
        "app/(dashboard)/bridge-course/page.tsx"
git commit -m "refactor: replace inline no-active-year blocks with NoActiveYear component"
```

---

## Task 7: Lazy-load recharts in Dashboard

**Files:**
- Create: `app/(dashboard)/dashboard-charts.tsx`
- Modify: `app/(dashboard)/dashboard-client.tsx`

The goal: move all recharts imports into a dedicated file, then load that file lazily so recharts (~50 KB) is excluded from the initial JS bundle.

- [ ] **Step 1: Create `dashboard-charts.tsx`**

This file receives the computed data as props and owns all recharts imports.

```typescript
// app/(dashboard)/dashboard-charts.tsx
'use client'

import {
  BarChart, Bar, XAxis, YAxis, Tooltip, CartesianGrid, Legend,
  PieChart, Pie, Cell, ResponsiveContainer,
} from 'recharts'
import { formatCurrency } from '@/lib/utils/currency'
import type { ClassStat, RouteStat } from './page'

const PIE_COLORS = [
  '#4f46e5', '#16a34a', '#dc2626', '#d97706',
  '#0891b2', '#7c3aed', '#db2777', '#65a30d',
]

interface DashboardChartsProps {
  classStats: ClassStat[]
  routeStats: RouteStat[]
}

export function DashboardCharts({ classStats, routeStats }: DashboardChartsProps) {
  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <div className="rounded-lg border bg-white p-4">
        <h2 className="mb-4 font-semibold text-gray-900">Class-wise Collection</h2>
        {classStats.length === 0 ? (
          <p className="text-sm text-gray-400">No data yet.</p>
        ) : (
          <ResponsiveContainer width="100%" height={280}>
            <BarChart
              data={classStats}
              margin={{ top: 5, right: 20, left: 10, bottom: 5 }}
            >
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="name" tick={{ fontSize: 11 }} />
              <YAxis
                tick={{ fontSize: 11 }}
                tickFormatter={(v: number) =>
                  v >= 1000 ? `₹${(v / 1000).toFixed(0)}k` : `₹${v}`
                }
              />
              <Tooltip
                formatter={(value: unknown) => [formatCurrency(Number(value)), undefined]}
              />
              <Legend />
              <Bar dataKey="totalFee" name="Total Fee" fill="#93c5fd" radius={[4, 4, 0, 0]} />
              <Bar dataKey="collected" name="Collected" fill="#4ade80" radius={[4, 4, 0, 0]} />
            </BarChart>
          </ResponsiveContainer>
        )}
      </div>

      <div className="rounded-lg border bg-white p-4">
        <h2 className="mb-4 font-semibold text-gray-900">Transport Distribution</h2>
        {routeStats.length === 0 ? (
          <p className="text-sm text-gray-400">No data yet.</p>
        ) : (
          <ResponsiveContainer width="100%" height={280}>
            <PieChart>
              <Pie
                data={routeStats}
                dataKey="studentCount"
                nameKey="name"
                cx="50%"
                cy="50%"
                outerRadius={100}
                label={({ name, percent }: { name?: string; percent?: number }) =>
                  `${name ?? ''} ${((percent ?? 0) * 100).toFixed(0)}%`
                }
                labelLine={false}
              >
                {routeStats.map((_, i) => (
                  <Cell key={i} fill={PIE_COLORS[i % PIE_COLORS.length]} />
                ))}
              </Pie>
              <Tooltip formatter={(value: unknown) => [`${value} students`, undefined]} />
            </PieChart>
          </ResponsiveContainer>
        )}
      </div>
    </div>
  )
}
```

- [ ] **Step 2: Update `dashboard-client.tsx`**

Remove the recharts import block (lines 4–7):
```typescript
import {
  BarChart, Bar, XAxis, YAxis, Tooltip, CartesianGrid, Legend,
  PieChart, Pie, Cell, ResponsiveContainer,
} from 'recharts'
```

Also remove the `PIE_COLORS` constant (lines 16–19):
```typescript
const PIE_COLORS = [
  '#4f46e5', '#16a34a', '#dc2626', '#d97706',
  '#0891b2', '#7c3aed', '#db2777', '#65a30d',
]
```

Add at the top of the file (with the other imports):
```typescript
import dynamic from 'next/dynamic'
const DashboardCharts = dynamic(
  () => import('./dashboard-charts').then(m => ({ default: m.DashboardCharts })),
  { ssr: false, loading: () => <div className="h-72 animate-pulse rounded-lg bg-gray-100" /> }
)
```

In the JSX, replace the "Charts row" section — the entire `{/* Charts row */}` div (lines 104–165):
```tsx
{/* Charts row */}
<DashboardCharts classStats={data.classStats} routeStats={data.routeStats} />
```

- [ ] **Step 3: Verify TypeScript compiles**

Run: `npx tsc --noEmit`
Expected: No errors.

- [ ] **Step 4: Commit**

```bash
git add "app/(dashboard)/dashboard-charts.tsx" "app/(dashboard)/dashboard-client.tsx"
git commit -m "perf: lazy-load recharts in dashboard via DashboardCharts"
```

---

## Task 8: Lazy-load recharts in Bridge Course

**Files:**
- Create: `app/(dashboard)/bridge-course/bridge-charts.tsx`
- Modify: `app/(dashboard)/bridge-course/bridge-course-client.tsx`

- [ ] **Step 1: Create `bridge-charts.tsx`**

The bridge-course-client already computes `barData` and `pieData` from `students`. Pass those as props to keep the extraction minimal.

```typescript
// app/(dashboard)/bridge-course/bridge-charts.tsx
'use client'

import {
  BarChart, Bar, XAxis, YAxis, Tooltip, CartesianGrid, Legend,
  PieChart, Pie, Cell, ResponsiveContainer,
} from 'recharts'

interface BarEntry {
  name: string
  Collected: number
  Balance: number
}

interface PieEntry {
  name: string
  value: number
}

interface BridgeChartsProps {
  barData: BarEntry[]
  pieData: PieEntry[]
}

const PIE_COLORS = ['#4ade80', '#60a5fa', '#f97316']

export function BridgeCharts({ barData, pieData }: BridgeChartsProps) {
  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <div className="rounded-lg border bg-white p-4">
        <h2 className="mb-4 font-semibold text-gray-900">Course-wise Collection</h2>
        <ResponsiveContainer width="100%" height={240}>
          <BarChart data={barData} margin={{ top: 5, right: 20, left: 10, bottom: 5 }}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="name" tick={{ fontSize: 12 }} />
            <YAxis
              tick={{ fontSize: 11 }}
              tickFormatter={(v: number) => v >= 1000 ? `₹${(v / 1000).toFixed(0)}k` : `₹${v}`}
            />
            <Tooltip formatter={(value: unknown) => [`₹${Number(value).toLocaleString('en-IN')}`, undefined]} />
            <Legend />
            <Bar dataKey="Collected" fill="#4ade80" radius={[4, 4, 0, 0]} />
            <Bar dataKey="Balance" fill="#f87171" radius={[4, 4, 0, 0]} />
          </BarChart>
        </ResponsiveContainer>
      </div>

      <div className="rounded-lg border bg-white p-4">
        <h2 className="mb-4 font-semibold text-gray-900">Payment Mode Split</h2>
        {pieData.length === 0 ? (
          <p className="text-sm text-gray-400">No payments yet.</p>
        ) : (
          <ResponsiveContainer width="100%" height={240}>
            <PieChart>
              <Pie
                data={pieData}
                dataKey="value"
                nameKey="name"
                cx="50%"
                cy="50%"
                outerRadius={90}
                label={({ name, percent }: { name?: string; percent?: number }) =>
                  `${name ?? ''} ${((percent ?? 0) * 100).toFixed(0)}%`
                }
                labelLine={false}
              >
                {pieData.map((_, i) => (
                  <Cell key={i} fill={PIE_COLORS[i % PIE_COLORS.length]} />
                ))}
              </Pie>
              <Tooltip formatter={(value: unknown) => [`₹${Number(value).toLocaleString('en-IN')}`, undefined]} />
            </PieChart>
          </ResponsiveContainer>
        )}
      </div>
    </div>
  )
}
```

- [ ] **Step 2: Update `bridge-course-client.tsx`**

Remove the recharts import block (lines 14–16):
```typescript
import {
  BarChart, Bar, XAxis, YAxis, Tooltip, CartesianGrid, Legend,
  PieChart, Pie, Cell, ResponsiveContainer,
} from 'recharts'
```

Add after the other imports:
```typescript
import dynamic from 'next/dynamic'
const BridgeCharts = dynamic(
  () => import('./bridge-charts').then(m => ({ default: m.BridgeCharts })),
  { ssr: false, loading: () => <div className="h-64 animate-pulse rounded-lg bg-gray-100" /> }
)
```

Also remove the local `PIE_COLORS` constant that's inside the component:
```typescript
const PIE_COLORS = ['#4ade80', '#60a5fa', '#f97316']
```

In the JSX, replace the entire `{/* Charts */}` section (around line 358 onwards — the `{students.length > 0 && (<div>...charts...</div>)}` block) with:

```tsx
{students.length > 0 && (
  <BridgeCharts barData={barData} pieData={pieData} />
)}
```

- [ ] **Step 3: Verify TypeScript compiles**

Run: `npx tsc --noEmit`
Expected: No errors.

- [ ] **Step 4: Commit**

```bash
git add "app/(dashboard)/bridge-course/bridge-charts.tsx" \
        "app/(dashboard)/bridge-course/bridge-course-client.tsx"
git commit -m "perf: lazy-load recharts in bridge course via BridgeCharts"
```

---

## Task 9: Add loading skeletons for all dashboard routes

**Files:**
- Create: `app/(dashboard)/loading.tsx`
- Create: `app/(dashboard)/students/loading.tsx`
- Create: `app/(dashboard)/collect-fee/loading.tsx`
- Create: `app/(dashboard)/pending-fees/loading.tsx`
- Create: `app/(dashboard)/reports/loading.tsx`
- Create: `app/(dashboard)/fee-setup/loading.tsx`
- Create: `app/(dashboard)/bank-deposits/loading.tsx`
- Create: `app/(dashboard)/bridge-course/loading.tsx`

Next.js App Router automatically renders `loading.tsx` while the page's server component is executing. No wiring needed.

- [ ] **Step 1: Create `app/(dashboard)/loading.tsx` (Dashboard home)**

```typescript
// app/(dashboard)/loading.tsx
export default function DashboardLoading() {
  return (
    <div className="space-y-6 p-6 animate-pulse">
      <div className="h-8 w-40 rounded bg-gray-200" />
      <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
        {Array.from({ length: 4 }).map((_, i) => (
          <div key={i} className="rounded-lg border bg-white p-4">
            <div className="h-4 w-24 rounded bg-gray-200" />
            <div className="mt-2 h-8 w-32 rounded bg-gray-200" />
          </div>
        ))}
      </div>
      <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
        <div className="h-72 rounded-lg border bg-white" />
        <div className="h-72 rounded-lg border bg-white" />
      </div>
      <div className="rounded-lg border bg-white">
        <div className="border-b px-4 py-3">
          <div className="h-5 w-36 rounded bg-gray-200" />
        </div>
        <div className="divide-y">
          {Array.from({ length: 5 }).map((_, i) => (
            <div key={i} className="flex items-center gap-4 px-4 py-3">
              <div className="h-4 w-20 rounded bg-gray-200" />
              <div className="h-4 w-32 rounded bg-gray-200" />
              <div className="ml-auto h-4 w-16 rounded bg-gray-200" />
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
```

- [ ] **Step 2: Create `app/(dashboard)/students/loading.tsx`**

```typescript
// app/(dashboard)/students/loading.tsx
export default function StudentsLoading() {
  return (
    <div className="space-y-4 p-6 animate-pulse">
      <div className="flex items-center justify-between">
        <div className="h-8 w-28 rounded bg-gray-200" />
        <div className="h-9 w-32 rounded bg-gray-200" />
      </div>
      <div className="flex gap-3">
        {Array.from({ length: 4 }).map((_, i) => (
          <div key={i} className="h-9 w-32 rounded bg-gray-200" />
        ))}
      </div>
      <div className="rounded-lg border bg-white">
        <div className="divide-y">
          {Array.from({ length: 8 }).map((_, i) => (
            <div key={i} className="flex items-center gap-4 px-4 py-3">
              <div className="h-4 w-16 rounded bg-gray-200" />
              <div className="h-4 w-40 rounded bg-gray-200" />
              <div className="h-4 w-20 rounded bg-gray-200" />
              <div className="ml-auto h-4 w-24 rounded bg-gray-200" />
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
```

- [ ] **Step 3: Create `app/(dashboard)/collect-fee/loading.tsx`**

```typescript
// app/(dashboard)/collect-fee/loading.tsx
export default function CollectFeeLoading() {
  return (
    <div className="space-y-4 p-6 animate-pulse">
      <div className="h-8 w-32 rounded bg-gray-200" />
      <div className="h-10 w-full max-w-md rounded bg-gray-200" />
      <div className="h-64 rounded-lg border bg-white" />
    </div>
  )
}
```

- [ ] **Step 4: Create `app/(dashboard)/pending-fees/loading.tsx`**

```typescript
// app/(dashboard)/pending-fees/loading.tsx
export default function PendingFeesLoading() {
  return (
    <div className="space-y-4 p-6 animate-pulse">
      <div className="h-8 w-36 rounded bg-gray-200" />
      <div className="flex gap-3">
        {Array.from({ length: 3 }).map((_, i) => (
          <div key={i} className="h-9 w-32 rounded bg-gray-200" />
        ))}
      </div>
      <div className="rounded-lg border bg-white">
        <div className="divide-y">
          {Array.from({ length: 8 }).map((_, i) => (
            <div key={i} className="flex items-center gap-4 px-4 py-3">
              <div className="h-4 w-16 rounded bg-gray-200" />
              <div className="h-4 w-40 rounded bg-gray-200" />
              <div className="h-4 w-20 rounded bg-gray-200" />
              <div className="ml-auto h-4 w-20 rounded bg-gray-200" />
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
```

- [ ] **Step 5: Create `app/(dashboard)/reports/loading.tsx`**

```typescript
// app/(dashboard)/reports/loading.tsx
export default function ReportsLoading() {
  return (
    <div className="space-y-4 p-6 animate-pulse">
      <div className="h-8 w-24 rounded bg-gray-200" />
      <div className="flex gap-2">
        {Array.from({ length: 5 }).map((_, i) => (
          <div key={i} className="h-9 w-28 rounded bg-gray-200" />
        ))}
      </div>
      <div className="rounded-lg border bg-white">
        <div className="divide-y">
          {Array.from({ length: 10 }).map((_, i) => (
            <div key={i} className="flex items-center gap-4 px-4 py-3">
              <div className="h-4 w-20 rounded bg-gray-200" />
              <div className="h-4 w-36 rounded bg-gray-200" />
              <div className="ml-auto h-4 w-20 rounded bg-gray-200" />
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
```

- [ ] **Step 6: Create `app/(dashboard)/fee-setup/loading.tsx`**

```typescript
// app/(dashboard)/fee-setup/loading.tsx
export default function FeeSetupLoading() {
  return (
    <div className="space-y-6 p-6 animate-pulse">
      <div className="h-8 w-28 rounded bg-gray-200" />
      <div className="grid gap-4">
        {Array.from({ length: 4 }).map((_, i) => (
          <div key={i} className="rounded-lg border bg-white p-4">
            <div className="h-5 w-32 rounded bg-gray-200" />
            <div className="mt-3 h-4 w-full rounded bg-gray-100" />
          </div>
        ))}
      </div>
    </div>
  )
}
```

- [ ] **Step 7: Create `app/(dashboard)/bank-deposits/loading.tsx`**

```typescript
// app/(dashboard)/bank-deposits/loading.tsx
export default function BankDepositsLoading() {
  return (
    <div className="space-y-4 p-6 animate-pulse">
      <div className="flex items-center justify-between">
        <div className="h-8 w-36 rounded bg-gray-200" />
        <div className="h-9 w-32 rounded bg-gray-200" />
      </div>
      <div className="grid grid-cols-2 gap-4 lg:grid-cols-3">
        {Array.from({ length: 3 }).map((_, i) => (
          <div key={i} className="rounded-lg border bg-white p-4">
            <div className="h-4 w-24 rounded bg-gray-200" />
            <div className="mt-2 h-8 w-32 rounded bg-gray-200" />
          </div>
        ))}
      </div>
      <div className="rounded-lg border bg-white">
        <div className="divide-y">
          {Array.from({ length: 6 }).map((_, i) => (
            <div key={i} className="flex items-center gap-4 px-4 py-3">
              <div className="h-4 w-20 rounded bg-gray-200" />
              <div className="h-4 w-32 rounded bg-gray-200" />
              <div className="ml-auto h-4 w-24 rounded bg-gray-200" />
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
```

- [ ] **Step 8: Create `app/(dashboard)/bridge-course/loading.tsx`**

```typescript
// app/(dashboard)/bridge-course/loading.tsx
export default function BridgeCourseLoading() {
  return (
    <div className="space-y-4 p-6 animate-pulse">
      <div className="flex items-center justify-between">
        <div className="h-8 w-36 rounded bg-gray-200" />
        <div className="h-9 w-28 rounded bg-gray-200" />
      </div>
      <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
        {Array.from({ length: 4 }).map((_, i) => (
          <div key={i} className="rounded-lg border bg-white p-4">
            <div className="h-4 w-20 rounded bg-gray-200" />
            <div className="mt-2 h-8 w-24 rounded bg-gray-200" />
          </div>
        ))}
      </div>
      <div className="rounded-lg border bg-white">
        <div className="divide-y">
          {Array.from({ length: 8 }).map((_, i) => (
            <div key={i} className="flex items-center gap-4 px-4 py-3">
              <div className="h-4 w-16 rounded bg-gray-200" />
              <div className="h-4 w-36 rounded bg-gray-200" />
              <div className="ml-auto h-4 w-20 rounded bg-gray-200" />
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
```

- [ ] **Step 9: Verify TypeScript compiles**

Run: `npx tsc --noEmit`
Expected: No errors.

- [ ] **Step 10: Commit**

```bash
git add "app/(dashboard)/loading.tsx" \
        "app/(dashboard)/students/loading.tsx" \
        "app/(dashboard)/collect-fee/loading.tsx" \
        "app/(dashboard)/pending-fees/loading.tsx" \
        "app/(dashboard)/reports/loading.tsx" \
        "app/(dashboard)/fee-setup/loading.tsx" \
        "app/(dashboard)/bank-deposits/loading.tsx" \
        "app/(dashboard)/bridge-course/loading.tsx"
git commit -m "perf: add loading skeletons for all dashboard routes"
```

---

## Task 10: Update `next.config.ts`

**Files:**
- Modify: `next.config.ts`

- [ ] **Step 1: Update the config**

Replace the entire file content:

```typescript
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    formats: ['image/avif', 'image/webp'],
  },
  compress: true,
};

export default nextConfig;
```

- [ ] **Step 2: Verify TypeScript compiles**

Run: `npx tsc --noEmit`
Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add next.config.ts
git commit -m "perf: enable image format optimization and compression in next.config"
```

---

## Task 11: Remove unused dependencies

**Files:**
- Modify: `package.json` (via npm)

`react-hook-form` and `@hookform/resolvers` are installed but have zero imports anywhere in the project.

- [ ] **Step 1: Verify they are truly unused before uninstalling**

Run: `npx grep -r "react-hook-form\|hookform" app/ lib/ components/ --include="*.ts" --include="*.tsx"`
Expected: No output (zero matches).

- [ ] **Step 2: Uninstall both packages**

Run: `npm uninstall react-hook-form @hookform/resolvers`
Expected: Both removed from `package.json` and `package-lock.json`.

- [ ] **Step 3: Verify the build still compiles**

Run: `npx tsc --noEmit`
Expected: No errors.

- [ ] **Step 4: Commit**

```bash
git add package.json package-lock.json
git commit -m "chore: remove unused react-hook-form and @hookform/resolvers"
```

---

## Self-Review Checklist

**Spec coverage:**
- [x] `lib/constants/labels.ts` — Task 1 + Task 2
- [x] `lib/utils/fee-utils.ts` — Task 3 + Task 4
- [x] `components/no-active-year.tsx` — Task 5 + Task 6
- [x] Loading skeletons for all 8 routes — Task 9
- [x] Lazy-load recharts (dashboard) — Task 7
- [x] Lazy-load recharts (bridge course) — Task 8
- [x] `next.config.ts` update — Task 10
- [x] Remove unused packages — Task 11

**Placeholder scan:** No TBDs, no "handle edge cases", no forward references to undefined symbols.

**Type consistency:**
- `buildClassFeeMap` return type is `Map<string, Record<ClassFeeHead, number>>` — consistent with how it's consumed in Tasks 4 (same type was used locally before).
- `DashboardCharts` props use `ClassStat[]` and `RouteStat[]` from `./page` — same types used in `DashboardData`.
- `BridgeCharts` props use inline `BarEntry[]` and `PieEntry[]` — consistent with how `barData` and `pieData` are computed in `bridge-course-client.tsx`.

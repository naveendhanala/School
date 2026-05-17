# UX Gaps — Design Spec

**Date:** 2026-05-17
**Scope:** Group E of missing HTML v2 features — toast notifications, pending fees enhancements, dashboard undeposited warning

---

## Background

The HTML reference version has three UX capabilities that the web app lacks:

1. A `toast()` function for non-blocking success/error feedback — the web app currently uses `alert()` in two places and is silent after most successful actions.
2. Text search + mobile/village columns + print button on the Pending Fees page.
3. A reconciliation banner on the Dashboard showing how much collected cash hasn't been deposited to the bank yet.

---

## Section 1 — Toast Notifications

### Library

Install `sonner`. It's the standard toast library for shadcn/ui projects and has no peer conflicts with the current stack.

### Root integration

Add `<Toaster position="top-right" richColors />` to `app/layout.tsx` (the root layout, not the dashboard layout, so it's available on the receipt page too).

### Where toasts are added

Every client component that calls a server action should call `toast.success()` on success and `toast.error()` on failure. Replace all `alert()` calls; add success feedback where currently silent:

| File | Action | Toast |
|---|---|---|
| `bridge-course-client.tsx` | Delete student fails | `toast.error("Delete failed: …")` |
| `bridge-course-client.tsx` | Delete student succeeds | `toast.success("Student deleted")` |
| `bridge-course-client.tsx` | Delete deposit fails | `toast.error("Delete failed: …")` |
| `bridge-course-client.tsx` | Delete deposit succeeds | `toast.success("Deposit deleted")` |
| `bank-deposits-client.tsx` | Delete deposit fails | `toast.error("Delete failed: …")` |
| `bank-deposits-client.tsx` | Delete deposit succeeds | `toast.success("Deposit deleted")` |
| `app/(dashboard)/collect-fee/payment-form.tsx` | Payment recorded | `toast.success("Payment recorded — Receipt {receiptNo}")` |
| `app/(dashboard)/bridge-course/add-student-dialog.tsx` | Student added | `toast.success("Student added")` |
| `app/(dashboard)/bridge-course/bridge-deposit-dialog.tsx` | Deposit recorded | `toast.success("Deposit recorded")` |
| `app/(dashboard)/bridge-course/payment-dialog.tsx` | Payment recorded | `toast.success("Payment recorded")` |
| `app/(dashboard)/bank-deposits/deposit-dialog.tsx` | Deposit saved | `toast.success("Deposit saved")` |
| `components/payments/edit-payment-dialog.tsx` | Payment saved | `toast.success("Payment updated")` |
| `components/payments/edit-payment-dialog.tsx` | Payment deleted | `toast.success("Payment deleted")` |
| `app/(dashboard)/fee-setup/reset-payments-button.tsx` | Reset succeeded | `toast.success("All payment data reset for {yearLabel}")` |
| `app/(dashboard)/students/student-dialog.tsx` | Student added | `toast.success("Student added")` |
| `app/(dashboard)/students/students-client.tsx` | Student deactivated | `toast.success("Student deactivated")` |

### Pattern

Client components already use `useTransition` + `router.refresh()`. The toast call goes immediately after the success/error branch, before `router.refresh()`:

```ts
const result = await someAction(...)
if (result.error) { toast.error(result.error); return }
toast.success("Action completed")
router.refresh()
```

The `toast()` import comes from `'sonner'`.

---

## Section 2 — Pending Fees Enhancements

### Text search

Add a text input to `pending-fees-client.tsx` above the existing filter dropdowns. Client-side filter: match `row.name` or `row.admNo` against the search string (case-insensitive, trimmed). No DB changes needed.

### Mobile + Village columns

`PendingRow` in `pending-fees/page.tsx` gains two new fields:

```ts
export type PendingRow = {
  // ... existing fields ...
  mobile: string | null
  village: string | null
}
```

The server page already queries `students!inner ( id, adm_no, name, ... )` — extend it to also select `mobile` and `village`. Map them into `PendingRow`.

Two new columns added to the table: **Mobile** and **Village** (show `—` when null). They go between the existing Route and Total Fee columns.

The CSV export gains two new columns accordingly: Mobile and Village.

### Print button

Add a "Print" button (outline, with Printer icon from lucide-react) next to the existing "Export CSV" button. Clicking it calls `window.print()`.

Add print styles to the page — either via a `<style>` tag or Tailwind's `print:` variants — so that the filter bar, buttons, and stat cards are hidden when printing:

```css
@media print {
  .no-print { display: none !important; }
}
```

Apply `no-print` class to the filter row and action buttons. The table prints as-is.

---

## Section 3 — Dashboard Undeposited Warning

### Computation

In `app/(dashboard)/page.tsx`, add a parallel query for bank deposits:

```ts
supabase
  .from('bank_deposits')
  .select('amount')
  .eq('academic_year_id', activeYear.id)
```

Compute:
```ts
const totalDeposited = (bankDeposits ?? []).reduce((s, d) => s + Number(d.amount), 0)
const undepositedAmount = totalCollected - totalDeposited
```

Add `undepositedAmount: number` to `DashboardData`.

### Banner in dashboard-client.tsx

Render the banner below the stat cards, above the charts:

- **`undepositedAmount > 0`** → amber banner: "₹{amount} collected but not yet deposited to bank" with a "Record →" link pointing to `/bank-deposits`
- **`undepositedAmount === 0` and `totalCollected > 0`** → green banner: "All collections deposited. Accounts balanced."
- **`totalCollected === 0`** → no banner rendered

---

## Files Changed

| File | Change type |
|---|---|
| `package.json` | Add `sonner` dependency |
| `app/layout.tsx` | Add `<Toaster />` |
| `app/(dashboard)/collect-fee/payment-form.tsx` | Add success toast |
| `app/(dashboard)/bridge-course/bridge-course-client.tsx` | Replace alert() with toast; add success toasts |
| `app/(dashboard)/bridge-course/add-student-dialog.tsx` | Add success toast |
| `app/(dashboard)/bridge-course/bridge-deposit-dialog.tsx` | Add success toast |
| `app/(dashboard)/bridge-course/payment-dialog.tsx` | Add success toast |
| `app/(dashboard)/bank-deposits/bank-deposits-client.tsx` | Replace alert() with toast; add success toast |
| `components/payments/edit-payment-dialog.tsx` | Add success toasts |
| `app/(dashboard)/fee-setup/reset-payments-button.tsx` | Add success toast |
| `app/(dashboard)/students/students-client.tsx` | Add success/error toasts |
| `app/(dashboard)/students/student-dialog.tsx` | Add success toast |
| `app/(dashboard)/pending-fees/page.tsx` | Add mobile/village to PendingRow + query |
| `app/(dashboard)/pending-fees/pending-fees-client.tsx` | Add search input, mobile/village columns, print button |
| `app/(dashboard)/page.tsx` | Add bank_deposits query + undepositedAmount to DashboardData |
| `app/(dashboard)/dashboard-client.tsx` | Add undeposited warning banner |

---

## What Does NOT Change

- No changes to the database or server actions for this group
- Receipt page already auto-prints and has a Print button — no change needed
- SMS/WhatsApp features are Group D, not in scope here

# Payment Admin — Design Spec

**Date:** 2026-05-17
**Scope:** Group C of missing HTML v2 features — edit/delete payment records with audit trail, and reset all payments for active year

---

## Background

The `payments` table already has RLS policies allowing admin UPDATE and DELETE. What's missing is:
- A `payment_edits` audit table to record what changed, why, and by whom
- UI to edit/delete payments (admin only), accessible from Dashboard recent payments and Collect Fee payment history
- A Reset Payments action in Fee Setup that wipes all payment and deposit data for the active year

---

## Database Migration — `supabase/migrations/002_payment_edits.sql`

### `payment_edits` table

Immutable audit log — one row per edit. Never updated or deleted (except cascade when the payment itself is deleted).

```sql
CREATE TABLE payment_edits (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  payment_id      UUID NOT NULL REFERENCES payments(id) ON DELETE CASCADE,
  edited_by       UUID NOT NULL REFERENCES auth.users(id),
  edited_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  reason          TEXT NOT NULL,
  old_amount      NUMERIC(10,2),
  new_amount      NUMERIC(10,2),
  old_mode        TEXT,
  new_mode        TEXT,
  old_payment_date DATE,
  new_payment_date DATE,
  old_fee_head    TEXT,
  new_fee_head    TEXT,
  old_reference   TEXT,
  new_reference   TEXT,
  old_remarks     TEXT,
  new_remarks     TEXT
);

ALTER TABLE payment_edits ENABLE ROW LEVEL SECURITY;
-- Admin can read the audit log
CREATE POLICY "admin_read_payment_edits" ON payment_edits
  FOR SELECT TO authenticated USING (get_user_role() = 'admin');
-- Admin can insert (edits are written server-side)
CREATE POLICY "admin_insert_payment_edits" ON payment_edits
  FOR INSERT TO authenticated WITH CHECK (get_user_role() = 'admin');
```

### `reset_active_year_payments` SQL function

Deletes all payment and deposit data for a given academic year in a single transaction. Student and enrollment records are untouched.

Deletion order (respects FK constraints — `bridge_payments` has no CASCADE on its FK, so must be deleted before `bridge_students`):
1. `payments` where enrollment is in the year
2. `bank_deposits` for the year
3. `bridge_payments` where bridge_student is in the year (explicit delete, no cascade)
4. `bridge_students` for the year
5. `bridge_deposits` for the year

The function uses `SECURITY DEFINER` (to run as owner), so it includes an internal role check to prevent non-admin callers from bypassing RLS.

```sql
CREATE OR REPLACE FUNCTION reset_active_year_payments(year_id UUID)
RETURNS void AS $$
BEGIN
  IF get_user_role() != 'admin' THEN
    RAISE EXCEPTION 'Only admins can reset payments';
  END IF;

  DELETE FROM payments
  WHERE enrollment_id IN (
    SELECT id FROM enrollments WHERE academic_year_id = year_id
  );
  DELETE FROM bank_deposits WHERE academic_year_id = year_id;
  DELETE FROM bridge_payments
  WHERE bridge_student_id IN (
    SELECT id FROM bridge_students WHERE academic_year_id = year_id
  );
  DELETE FROM bridge_students WHERE academic_year_id = year_id;
  DELETE FROM bridge_deposits WHERE academic_year_id = year_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public;

GRANT EXECUTE ON FUNCTION reset_active_year_payments TO authenticated;
```

---

## Server Actions

### `app/(dashboard)/collect-fee/actions.ts` — two new exports

**`editPayment(paymentId, updates, reason)`**

```ts
updates: {
  amount?: number
  mode?: PaymentMode
  payment_date?: string
  fee_head?: FeeHead
  reference?: string | null
  remarks?: string | null
}
```

Steps:
1. Fetch current payment row (to record old values)
2. Update `payments` row with new values
3. Insert into `payment_edits` with old/new values, reason, `auth.uid()`
4. `revalidatePath` for `/`, `/collect-fee`, `/reports`

**`deletePayment(paymentId)`**

Steps:
1. Delete from `payments` (cascade deletes `payment_edits` rows)
2. `revalidatePath` for `/`, `/collect-fee`, `/reports`

### `app/(dashboard)/fee-setup/actions.ts` — one new export

**`resetActiveYearPayments(yearId)`**

Steps:
1. Call `reset_active_year_payments(yearId)` via `supabase.rpc()`
2. `revalidatePath` for all dashboard paths

---

## UI Components

### New: `components/payments/edit-payment-dialog.tsx`

Props:
```ts
{
  payment: {
    id: string
    receiptNo: string
    studentName: string
    amount: number
    mode: PaymentMode
    paymentDate: string
    feeHead: FeeHead
    reference: string | null
    remarks: string | null
  }
  open: boolean
  onOpenChange: (open: boolean) => void
}
```

Fields:
- **Read-only:** Student Name, Receipt No
- **Editable:** Amount (number input), Mode (select), Date (date input), Fee Head (select), Reference (text), Remarks (text)
- **Required:** Edit Reason (textarea, min 1 char)
- **Buttons:** Save Changes (primary), Delete (destructive, triggers `confirm()` before calling `deletePayment`), Cancel

On save: calls `editPayment()`, closes dialog on success, shows inline error on failure.
On delete: `confirm("Delete receipt {receiptNo}? This cannot be undone.")` → calls `deletePayment()` → closes dialog.

### Modified: `app/(dashboard)/collect-fee/payment-history.tsx`

When `role === 'admin'` (via `useUser()`), add a pencil icon button at the end of each payment row. Clicking opens `EditPaymentDialog` pre-filled with that payment's data. The `studentName` is passed in from the parent (already available in the collect-fee flow).

### Modified: `app/(dashboard)/dashboard-client.tsx`

When `role === 'admin'`, add a pencil icon button to the end of each row in the Recent Payments table. The `studentName` is already in the recent payments query result.

### Modified: `app/(dashboard)/fee-setup/academic-year-tab.tsx`

Add a "Danger Zone" section below the academic years list (visible only when `role === 'admin'`). Shows:
- Heading: "Reset Active Year Data"
- Description: "Permanently deletes all payments, deposits, and bridge course records for the active year. Student and enrollment records are preserved."
- Button: "Reset All Payments" (destructive styling)

Clicking opens a confirmation dialog (`@radix-ui/react-dialog`) that:
- Shows the active year label
- Has a text input requiring the user to type the exact year label to confirm
- Has a "Confirm Reset" button (disabled until typed label matches)
- Calls `resetActiveYearPayments(activeYearId)` on confirm

---

## Types — additions to `lib/types.ts`

```ts
export type PaymentEdit = {
  id: string
  payment_id: string
  edited_by: string
  edited_at: string
  reason: string
  old_amount: number | null
  new_amount: number | null
  old_mode: string | null
  new_mode: string | null
  old_payment_date: string | null
  new_payment_date: string | null
  old_fee_head: string | null
  new_fee_head: string | null
  old_reference: string | null
  new_reference: string | null
  old_remarks: string | null
  new_remarks: string | null
}
```

And add to `Database` type:
```ts
payment_edits: {
  Row: PaymentEdit
  Insert: Omit<PaymentEdit, 'id' | 'edited_at'>
  Update: never
  Relationships: []
}
```

---

## Files Changed

| File | Change type |
|---|---|
| `supabase/migrations/002_payment_edits.sql` | New |
| `lib/types.ts` | Add PaymentEdit type + Database entry |
| `app/(dashboard)/collect-fee/actions.ts` | Add editPayment, deletePayment |
| `app/(dashboard)/fee-setup/actions.ts` | Add resetActiveYearPayments |
| `components/payments/edit-payment-dialog.tsx` | New |
| `app/(dashboard)/collect-fee/payment-history.tsx` | Add edit button (admin only) |
| `app/(dashboard)/dashboard-client.tsx` | Add edit button (admin only) |
| `app/(dashboard)/fee-setup/academic-year-tab.tsx` | Add Danger Zone + reset dialog |

---

## What Does NOT Change

- No changes to RLS policies for `payments` — admin UPDATE/DELETE already exists
- No changes to receipt generation or receipt_sequences
- `payment_edits` audit rows are cascade-deleted when the payment is deleted — no orphan cleanup needed
- Bridge students deleted by reset also cascade-delete their bridge_payments via FK

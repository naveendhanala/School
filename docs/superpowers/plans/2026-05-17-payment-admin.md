# Payment Admin Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Let admins edit and delete payment records (with a full audit trail) and reset all payment/deposit data for the active academic year.

**Architecture:** A new `payment_edits` DB table captures immutable audit rows whenever a payment is changed. A shared `EditPaymentDialog` component is used in both the Collect Fee payment-history panel and the Dashboard recent-payments table. A `ResetPaymentsButton` client component in Fee Setup calls a SQL function that clears all financial data for the active year in one transaction.

**Tech Stack:** Next.js 16 server actions, Supabase (PostgreSQL + RLS), React 19, Radix UI Dialog, Lucide icons, TypeScript, Vitest.

---

## File Map

| File | Action | Responsibility |
|---|---|---|
| `supabase/migrations/002_payment_edits.sql` | **Create** | payment_edits table, RLS, reset SQL function |
| `lib/types.ts` | **Modify** | Add PaymentEdit type + Database entries |
| `app/(dashboard)/page.tsx` | **Modify** | Add reference/remarks to RecentPayment type + query |
| `app/(dashboard)/collect-fee/actions.ts` | **Modify** | Add editPayment, deletePayment server actions |
| `app/(dashboard)/fee-setup/actions.ts` | **Modify** | Add resetActiveYearPayments server action |
| `components/payments/edit-payment-dialog.tsx` | **Create** | Shared edit/delete modal for admin |
| `app/(dashboard)/collect-fee/payment-history.tsx` | **Modify** | Add edit button (admin only), accept studentName prop |
| `app/(dashboard)/collect-fee/collect-fee-client.tsx` | **Modify** | Pass studentName to PaymentHistory |
| `app/(dashboard)/dashboard-client.tsx` | **Modify** | Add edit button to recent payments (admin only) |
| `app/(dashboard)/fee-setup/reset-payments-button.tsx` | **Create** | Client component: confirmation dialog + reset action |
| `app/(dashboard)/fee-setup/academic-year-tab.tsx` | **Modify** | Add Danger Zone section with ResetPaymentsButton |

---

## Task 1: DB migration — payment_edits table and reset function

**Files:**
- Create: `supabase/migrations/002_payment_edits.sql`

- [ ] **Step 1: Create the migration file**

```sql
-- supabase/migrations/002_payment_edits.sql

-- Immutable audit log: one row per payment edit
CREATE TABLE payment_edits (
  id               UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  payment_id       UUID NOT NULL REFERENCES payments(id) ON DELETE CASCADE,
  edited_by        UUID NOT NULL REFERENCES auth.users(id),
  edited_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  reason           TEXT NOT NULL,
  old_amount       NUMERIC(10,2),
  new_amount       NUMERIC(10,2),
  old_mode         TEXT,
  new_mode         TEXT,
  old_payment_date DATE,
  new_payment_date DATE,
  old_fee_head     TEXT,
  new_fee_head     TEXT,
  old_reference    TEXT,
  new_reference    TEXT,
  old_remarks      TEXT,
  new_remarks      TEXT
);

ALTER TABLE payment_edits ENABLE ROW LEVEL SECURITY;

CREATE POLICY "admin_read_payment_edits" ON payment_edits
  FOR SELECT TO authenticated USING (get_user_role() = 'admin');

CREATE POLICY "admin_insert_payment_edits" ON payment_edits
  FOR INSERT TO authenticated WITH CHECK (get_user_role() = 'admin');

-- Reset function: wipes all payment/deposit data for a year in one transaction.
-- Uses SECURITY DEFINER so it can delete across tables, but includes an internal
-- role guard so only admins can invoke it.
CREATE OR REPLACE FUNCTION reset_active_year_payments(year_id UUID)
RETURNS void AS $$
BEGIN
  IF get_user_role() != 'admin' THEN
    RAISE EXCEPTION 'Only admins can reset payments';
  END IF;

  -- Main school payments
  DELETE FROM payments
  WHERE enrollment_id IN (
    SELECT id FROM enrollments WHERE academic_year_id = year_id
  );

  -- Main bank deposits
  DELETE FROM bank_deposits WHERE academic_year_id = year_id;

  -- Bridge payments (no CASCADE on bridge_student_id FK — must delete explicitly)
  DELETE FROM bridge_payments
  WHERE bridge_student_id IN (
    SELECT id FROM bridge_students WHERE academic_year_id = year_id
  );

  -- Bridge students
  DELETE FROM bridge_students WHERE academic_year_id = year_id;

  -- Bridge deposits
  DELETE FROM bridge_deposits WHERE academic_year_id = year_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public;

GRANT EXECUTE ON FUNCTION reset_active_year_payments TO authenticated;
```

- [ ] **Step 2: Apply the migration to your local Supabase**

```
npx supabase db push
```

Or if using the Supabase dashboard: paste the SQL into the SQL editor and run it.

Expected: No errors. `payment_edits` table appears in the database.

- [ ] **Step 3: Commit**

```
git add supabase/migrations/002_payment_edits.sql
git commit -m "feat: add payment_edits audit table and reset_active_year_payments function"
```

---

## Task 2: Update types

**Files:**
- Modify: `lib/types.ts`

- [ ] **Step 1: Add PaymentEdit type after the existing Payment type**

Find the line `export type Payment = {` and add after the closing `}`:

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

- [ ] **Step 2: Add payment_edits to the Database type**

In the `Tables` section of the `Database` type, add after the `payments` entry:

```ts
payment_edits: {
  Row: PaymentEdit
  Insert: Omit<PaymentEdit, 'id' | 'edited_at'>
  Update: never
  Relationships: []
}
```

- [ ] **Step 3: Add reset_active_year_payments to Functions**

In the `Functions` section, add after `get_user_role`:

```ts
reset_active_year_payments: {
  Args: { year_id: string }
  Returns: void
}
```

- [ ] **Step 4: Verify TypeScript compiles**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 5: Commit**

```
git add lib/types.ts
git commit -m "feat: add PaymentEdit type and payment_edits database type"
```

---

## Task 3: Add editPayment and deletePayment server actions

**Files:**
- Modify: `app/(dashboard)/collect-fee/actions.ts`

- [ ] **Step 1: Add the two new exports at the end of the file**

```ts
export async function editPayment(
  paymentId: string,
  updates: {
    amount?: number
    mode?: PaymentMode
    payment_date?: string
    fee_head?: FeeHead
    reference?: string | null
    remarks?: string | null
  },
  reason: string
): Promise<{ error?: string }> {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return { error: 'Not authenticated' }

  const { data: current, error: fetchErr } = await supabase
    .from('payments')
    .select('amount, mode, payment_date, fee_head, reference, remarks')
    .eq('id', paymentId)
    .single()

  if (fetchErr || !current) return { error: fetchErr?.message ?? 'Payment not found' }

  const { error: updateErr } = await supabase
    .from('payments')
    .update(updates)
    .eq('id', paymentId)

  if (updateErr) return { error: updateErr.message }

  const { error: auditErr } = await supabase.from('payment_edits').insert({
    payment_id: paymentId,
    edited_by: user.id,
    reason,
    old_amount: current.amount,
    new_amount: updates.amount ?? current.amount,
    old_mode: current.mode,
    new_mode: updates.mode ?? current.mode,
    old_payment_date: current.payment_date,
    new_payment_date: updates.payment_date ?? current.payment_date,
    old_fee_head: current.fee_head,
    new_fee_head: updates.fee_head ?? current.fee_head,
    old_reference: current.reference,
    new_reference: 'reference' in updates ? updates.reference ?? null : current.reference,
    old_remarks: current.remarks,
    new_remarks: 'remarks' in updates ? updates.remarks ?? null : current.remarks,
  })

  if (auditErr) return { error: auditErr.message }

  revalidatePath('/')
  revalidatePath('/collect-fee')
  revalidatePath('/reports')
  return {}
}

export async function deletePayment(paymentId: string): Promise<{ error?: string }> {
  const supabase = await createClient()
  const { error } = await supabase.from('payments').delete().eq('id', paymentId)
  if (error) return { error: error.message }
  revalidatePath('/')
  revalidatePath('/collect-fee')
  revalidatePath('/reports')
  return {}
}
```

- [ ] **Step 2: Verify TypeScript compiles**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 3: Commit**

```
git add "app/(dashboard)/collect-fee/actions.ts"
git commit -m "feat: add editPayment and deletePayment server actions"
```

---

## Task 4: Add resetActiveYearPayments server action

**Files:**
- Modify: `app/(dashboard)/fee-setup/actions.ts`

- [ ] **Step 1: Add the new export at the end of the file**

```ts
export async function resetActiveYearPayments(yearId: string): Promise<{ error?: string }> {
  const supabase = await createClient()
  const { error } = await supabase.rpc('reset_active_year_payments', { year_id: yearId })
  if (error) return { error: error.message }
  revalidatePath('/')
  revalidatePath('/collect-fee')
  revalidatePath('/students')
  revalidatePath('/pending-fees')
  revalidatePath('/reports')
  revalidatePath('/bank-deposits')
  revalidatePath('/bridge-course')
  revalidatePath('/fee-setup')
  return {}
}
```

- [ ] **Step 2: Verify TypeScript compiles**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 3: Commit**

```
git add "app/(dashboard)/fee-setup/actions.ts"
git commit -m "feat: add resetActiveYearPayments server action"
```

---

## Task 5: Create EditPaymentDialog component

**Files:**
- Create: `components/payments/edit-payment-dialog.tsx`

- [ ] **Step 1: Create the directory and file**

```
mkdir -p components/payments
```

- [ ] **Step 2: Write the component**

```tsx
'use client'

import { useState, useTransition } from 'react'
import { useRouter } from 'next/navigation'
import {
  Dialog, DialogContent, DialogHeader, DialogTitle,
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import {
  Select, SelectContent, SelectItem, SelectTrigger, SelectValue,
} from '@/components/ui/select'
import { editPayment, deletePayment } from '@/app/(dashboard)/collect-fee/actions'
import type { FeeHead, PaymentMode } from '@/lib/types'

const FEE_HEADS: { value: FeeHead; label: string }[] = [
  { value: 'tuition',     label: 'Tuition Fee' },
  { value: 'book',        label: 'Book Fee' },
  { value: 'transport',   label: 'Transport Fee' },
  { value: 'hostel',      label: 'Hostel Fee' },
  { value: 'admission',   label: 'Admission Fee' },
  { value: 'uniform',     label: 'Uniform Fee' },
  { value: 'exam',        label: 'Exam Fee' },
  { value: 'other',       label: 'Other' },
]

const MODES: { value: PaymentMode; label: string }[] = [
  { value: 'cash',         label: 'Cash' },
  { value: 'upi',          label: 'UPI' },
  { value: 'cheque',       label: 'Cheque' },
  { value: 'neft_rtgs',    label: 'NEFT/RTGS' },
  { value: 'demand_draft', label: 'Demand Draft' },
]

export type EditablePayment = {
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

interface EditPaymentDialogProps {
  payment: EditablePayment | null
  open: boolean
  onOpenChange: (open: boolean) => void
}

export function EditPaymentDialog({ payment, open, onOpenChange }: EditPaymentDialogProps) {
  const router = useRouter()
  const [isPending, startTransition] = useTransition()
  const [amount, setAmount] = useState('')
  const [mode, setMode] = useState<PaymentMode>('cash')
  const [paymentDate, setPaymentDate] = useState('')
  const [feeHead, setFeeHead] = useState<FeeHead>('tuition')
  const [reference, setReference] = useState('')
  const [remarks, setRemarks] = useState('')
  const [reason, setReason] = useState('')
  const [error, setError] = useState<string | null>(null)

  // Sync form fields when payment prop changes
  const [prevPayment, setPrevPayment] = useState<EditablePayment | null>(null)
  if (payment !== prevPayment) {
    setPrevPayment(payment)
    if (payment) {
      setAmount(String(payment.amount))
      setMode(payment.mode)
      setPaymentDate(payment.paymentDate)
      setFeeHead(payment.feeHead)
      setReference(payment.reference ?? '')
      setRemarks(payment.remarks ?? '')
      setReason('')
      setError(null)
    }
  }

  function handleSave() {
    if (!payment) return
    if (!reason.trim()) { setError('Edit reason is required.'); return }
    const parsedAmount = parseFloat(amount)
    if (!Number.isFinite(parsedAmount) || parsedAmount <= 0) {
      setError('Amount must be greater than 0.')
      return
    }
    setError(null)
    startTransition(async () => {
      const result = await editPayment(
        payment.id,
        {
          amount: parsedAmount,
          mode,
          payment_date: paymentDate,
          fee_head: feeHead,
          reference: reference.trim() || null,
          remarks: remarks.trim() || null,
        },
        reason.trim()
      )
      if (result.error) { setError(result.error); return }
      onOpenChange(false)
      router.refresh()
    })
  }

  function handleDelete() {
    if (!payment) return
    if (!window.confirm(`Delete receipt ${payment.receiptNo}? This cannot be undone.`)) return
    startTransition(async () => {
      const result = await deletePayment(payment.id)
      if (result.error) { setError(result.error); return }
      onOpenChange(false)
      router.refresh()
    })
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>Edit Payment</DialogTitle>
        </DialogHeader>
        {payment && (
          <div className="space-y-4 pt-2">
            <div className="rounded-md bg-gray-50 px-3 py-2 text-sm">
              <p className="font-medium">{payment.studentName}</p>
              <p className="text-xs text-gray-500">Receipt: {payment.receiptNo}</p>
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div>
                <Label className="text-sm">Amount (₹) *</Label>
                <Input
                  type="number"
                  value={amount}
                  onChange={e => setAmount(e.target.value)}
                  min={1}
                />
              </div>
              <div>
                <Label className="text-sm">Date *</Label>
                <Input
                  type="date"
                  value={paymentDate}
                  onChange={e => setPaymentDate(e.target.value)}
                />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div>
                <Label className="text-sm">Fee Head *</Label>
                <Select value={feeHead} onValueChange={v => setFeeHead(v as FeeHead)}>
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent>
                    {FEE_HEADS.map(h => (
                      <SelectItem key={h.value} value={h.value}>{h.label}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div>
                <Label className="text-sm">Mode *</Label>
                <Select value={mode} onValueChange={v => setMode(v as PaymentMode)}>
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent>
                    {MODES.map(m => (
                      <SelectItem key={m.value} value={m.value}>{m.label}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div>
              <Label className="text-sm">Reference / UTR</Label>
              <Input
                value={reference}
                onChange={e => setReference(e.target.value)}
                placeholder="Optional"
              />
            </div>

            <div>
              <Label className="text-sm">Remarks</Label>
              <Input
                value={remarks}
                onChange={e => setRemarks(e.target.value)}
                placeholder="Optional"
              />
            </div>

            <div>
              <Label className="text-sm">Edit Reason *</Label>
              <Input
                value={reason}
                onChange={e => setReason(e.target.value)}
                placeholder="Why is this payment being edited?"
              />
            </div>

            {error && <p className="text-sm text-red-600">{error}</p>}

            <div className="flex items-center justify-between pt-2">
              <Button
                variant="destructive"
                size="sm"
                onClick={handleDelete}
                disabled={isPending}
              >
                Delete
              </Button>
              <div className="flex gap-2">
                <Button variant="outline" onClick={() => onOpenChange(false)} disabled={isPending}>
                  Cancel
                </Button>
                <Button onClick={handleSave} disabled={isPending}>
                  {isPending ? 'Saving…' : 'Save Changes'}
                </Button>
              </div>
            </div>
          </div>
        )}
      </DialogContent>
    </Dialog>
  )
}
```

- [ ] **Step 3: Verify TypeScript compiles**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 4: Commit**

```
git add components/payments/edit-payment-dialog.tsx
git commit -m "feat: add EditPaymentDialog component"
```

---

## Task 6: Add edit button to Collect Fee payment history

**Files:**
- Modify: `app/(dashboard)/collect-fee/payment-history.tsx`
- Modify: `app/(dashboard)/collect-fee/collect-fee-client.tsx`

- [ ] **Step 1: Rewrite `payment-history.tsx` to add edit button for admins**

```tsx
'use client'

import { useState } from 'react'
import { Pencil } from 'lucide-react'
import { formatCurrency } from '@/lib/utils/currency'
import { useUser } from '@/lib/user-context'
import { EditPaymentDialog } from '@/components/payments/edit-payment-dialog'
import type { EditablePayment } from '@/components/payments/edit-payment-dialog'
import type { PaymentRecord } from './page'
import type { FeeHead, PaymentMode } from '@/lib/types'

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

interface PaymentHistoryProps {
  payments: PaymentRecord[]
  studentName: string
}

export function PaymentHistory({ payments, studentName }: PaymentHistoryProps) {
  const { role } = useUser()
  const isAdmin = role === 'admin'
  const [editTarget, setEditTarget] = useState<EditablePayment | null>(null)

  if (payments.length === 0) {
    return <p className="text-sm text-gray-400">No payments recorded yet.</p>
  }

  return (
    <>
      <div className="space-y-3">
        {payments.map(p => (
          <div key={p.id} className="border-b pb-3 last:border-0 last:pb-0">
            <div className="flex items-start justify-between">
              <div>
                <p className="text-sm font-medium">{HEAD_LABELS[p.feeHead] ?? p.feeHead}</p>
                <p className="text-xs text-gray-500">
                  {p.paymentDate} · {MODE_LABELS[p.mode] ?? p.mode}
                  {p.reference ? ` · ${p.reference}` : ''}
                </p>
                <p className="text-xs text-gray-400">{p.receiptNo}</p>
                {p.remarks && (
                  <p className="text-xs italic text-gray-400">{p.remarks}</p>
                )}
              </div>
              <div className="flex items-center gap-2">
                <span className="text-sm font-semibold text-green-600">
                  {formatCurrency(p.amount)}
                </span>
                {isAdmin && (
                  <button
                    onClick={() => setEditTarget({
                      id: p.id,
                      receiptNo: p.receiptNo,
                      studentName,
                      amount: p.amount,
                      mode: p.mode as PaymentMode,
                      paymentDate: p.paymentDate,
                      feeHead: p.feeHead as FeeHead,
                      reference: p.reference,
                      remarks: p.remarks,
                    })}
                    className="rounded p-1 text-gray-400 hover:bg-gray-100 hover:text-gray-600"
                    aria-label="Edit payment"
                  >
                    <Pencil className="h-3.5 w-3.5" />
                  </button>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>

      <EditPaymentDialog
        payment={editTarget}
        open={editTarget !== null}
        onOpenChange={open => { if (!open) setEditTarget(null) }}
      />
    </>
  )
}
```

- [ ] **Step 2: Update `collect-fee-client.tsx` to pass studentName**

Find the `<PaymentHistory payments={selected.payments} />` line and change it to:

```tsx
<PaymentHistory payments={selected.payments} studentName={selected.name} />
```

- [ ] **Step 3: Verify TypeScript compiles**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 4: Commit**

```
git add "app/(dashboard)/collect-fee/payment-history.tsx" "app/(dashboard)/collect-fee/collect-fee-client.tsx"
git commit -m "feat: add edit payment button to collect fee payment history"
```

---

## Task 7: Add edit button to Dashboard recent payments

**Files:**
- Modify: `app/(dashboard)/page.tsx`
- Modify: `app/(dashboard)/dashboard-client.tsx`

- [ ] **Step 1: Add reference and remarks to RecentPayment type in `page.tsx`**

Find the `RecentPayment` type definition and replace it:

```ts
export type RecentPayment = {
  id: string
  receiptNo: string
  studentName: string
  admNo: string
  feeHead: string
  amount: number
  mode: string
  paymentDate: string
  reference: string | null
  remarks: string | null
}
```

- [ ] **Step 2: Update the recent payments query in `page.tsx` to select the new fields**

Find the query at approximately line 96 that selects recent payments and change the select string from:

```ts
.select(`
  id, receipt_no, fee_head, amount, mode, payment_date,
  enrollments!inner ( students!inner ( adm_no, name ) )
`)
```

to:

```ts
.select(`
  id, receipt_no, fee_head, amount, mode, payment_date, reference, remarks,
  enrollments!inner ( students!inner ( adm_no, name ) )
`)
```

Also update the inline type annotation for the empty fallback array (around line 107) to include the new fields:

```ts
data: [] as {
  id: string; receipt_no: string; fee_head: string; amount: number
  mode: string; payment_date: string; reference: string | null; remarks: string | null
  enrollments: { students: { adm_no: string; name: string } }
}[],
```

Finally, update the `recentPayments` mapping (around line 195) to include the new fields:

```ts
const recentPayments: RecentPayment[] = (recentRaw ?? []).map(p => {
  const enrollment = p.enrollments as unknown as {
    students: { adm_no: string; name: string }
  }
  return {
    id: p.id,
    receiptNo: p.receipt_no,
    studentName: enrollment.students.name,
    admNo: enrollment.students.adm_no,
    feeHead: p.fee_head,
    amount: Number(p.amount),
    mode: p.mode,
    paymentDate: p.payment_date,
    reference: p.reference ?? null,
    remarks: p.remarks ?? null,
  }
})

- [ ] **Step 3: Update `dashboard-client.tsx` to add edit button for admins**

Add imports at the top:

```tsx
import { useState } from 'react'
import { Pencil } from 'lucide-react'
import { useUser } from '@/lib/user-context'
import { EditPaymentDialog } from '@/components/payments/edit-payment-dialog'
import type { EditablePayment } from '@/components/payments/edit-payment-dialog'
import type { FeeHead, PaymentMode } from '@/lib/types'
```

Inside `DashboardClient`, add state and role check at the top of the function body:

```tsx
const { role } = useUser()
const isAdmin = role === 'admin'
const [editTarget, setEditTarget] = useState<EditablePayment | null>(null)
```

Add a column header for the edit button (admin only) in the `<thead>`:

```tsx
<thead className="bg-gray-50 text-gray-600">
  <tr>
    <th scope="col" className="px-4 py-3 text-left font-medium">Receipt No</th>
    <th scope="col" className="px-4 py-3 text-left font-medium">Student</th>
    <th scope="col" className="px-4 py-3 text-left font-medium">Fee Head</th>
    <th scope="col" className="px-4 py-3 text-left font-medium">Mode</th>
    <th scope="col" className="px-4 py-3 text-left font-medium">Date</th>
    <th scope="col" className="px-4 py-3 text-right font-medium">Amount</th>
    {isAdmin && <th scope="col" className="px-4 py-3" />}
  </tr>
</thead>
```

In each `<tr>` in `<tbody>`, add the edit button cell after the Amount cell:

```tsx
{isAdmin && (
  <td className="px-4 py-3 text-right">
    <button
      onClick={() => setEditTarget({
        id: p.id,
        receiptNo: p.receiptNo,
        studentName: p.studentName,
        amount: p.amount,
        mode: p.mode as PaymentMode,
        paymentDate: p.paymentDate,
        feeHead: p.feeHead as FeeHead,
        reference: p.reference,
        remarks: p.remarks,
      })}
      className="rounded p-1 text-gray-400 hover:bg-gray-100 hover:text-gray-600"
      aria-label="Edit payment"
    >
      <Pencil className="h-3.5 w-3.5" />
    </button>
  </td>
)}
```

Add the dialog at the bottom of the returned JSX, just before the closing `</div>`:

```tsx
<EditPaymentDialog
  payment={editTarget}
  open={editTarget !== null}
  onOpenChange={open => { if (!open) setEditTarget(null) }}
/>
```

- [ ] **Step 4: Verify TypeScript compiles**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 5: Commit**

```
git add "app/(dashboard)/page.tsx" "app/(dashboard)/dashboard-client.tsx"
git commit -m "feat: add edit payment button to dashboard recent payments"
```

---

## Task 8: Add Danger Zone to Fee Setup

**Files:**
- Create: `app/(dashboard)/fee-setup/reset-payments-button.tsx`
- Modify: `app/(dashboard)/fee-setup/academic-year-tab.tsx`

- [ ] **Step 1: Create `reset-payments-button.tsx`**

```tsx
'use client'

import { useState, useTransition } from 'react'
import { useRouter } from 'next/navigation'
import {
  Dialog, DialogContent, DialogHeader, DialogTitle,
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { resetActiveYearPayments } from './actions'

interface ResetPaymentsButtonProps {
  activeYearId: string
  activeYearLabel: string
}

export function ResetPaymentsButton({ activeYearId, activeYearLabel }: ResetPaymentsButtonProps) {
  const router = useRouter()
  const [open, setOpen] = useState(false)
  const [confirmText, setConfirmText] = useState('')
  const [error, setError] = useState<string | null>(null)
  const [isPending, startTransition] = useTransition()

  const canConfirm = confirmText === activeYearLabel

  function handleReset() {
    if (!canConfirm) return
    setError(null)
    startTransition(async () => {
      const result = await resetActiveYearPayments(activeYearId)
      if (result.error) { setError(result.error); return }
      setOpen(false)
      setConfirmText('')
      router.refresh()
    })
  }

  return (
    <>
      <Button
        variant="destructive"
        size="sm"
        onClick={() => { setConfirmText(''); setError(null); setOpen(true) }}
      >
        Reset All Payments
      </Button>

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>Reset Active Year Data</DialogTitle>
          </DialogHeader>
          <div className="space-y-4 pt-2">
            <p className="text-sm text-gray-600">
              This will permanently delete all payments, bank deposits, bridge course payments,
              bridge students, and bridge deposits for <strong>{activeYearLabel}</strong>.
              Student enrollment records are preserved.
            </p>
            <p className="text-sm text-gray-600">
              Type <strong>{activeYearLabel}</strong> to confirm:
            </p>
            <div>
              <Label className="text-sm">Academic year label</Label>
              <Input
                value={confirmText}
                onChange={e => setConfirmText(e.target.value)}
                placeholder={activeYearLabel}
              />
            </div>
            {error && <p className="text-sm text-red-600">{error}</p>}
            <div className="flex justify-end gap-2 pt-2">
              <Button variant="outline" onClick={() => setOpen(false)} disabled={isPending}>
                Cancel
              </Button>
              <Button
                variant="destructive"
                onClick={handleReset}
                disabled={!canConfirm || isPending}
              >
                {isPending ? 'Resetting…' : 'Confirm Reset'}
              </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </>
  )
}
```

- [ ] **Step 2: Update `academic-year-tab.tsx` to add Danger Zone**

Find the active year from the fetched years list and pass it to `ResetPaymentsButton`. Replace the full file content:

```tsx
import { createClient } from '@/lib/supabase/server'
import { AcademicYearRow } from './academic-year-row'
import { CreateYearForm } from './create-year-form'
import { ResetPaymentsButton } from './reset-payments-button'

export async function AcademicYearTab() {
  const supabase = await createClient()
  const { data: years } = await supabase
    .from('academic_years')
    .select('id, label, is_active')
    .order('created_at', { ascending: false })

  const activeYear = (years ?? []).find(y => y.is_active)

  return (
    <div className="mt-4 space-y-6">
      <div>
        <h3 className="mb-3 font-medium">Create New Year</h3>
        <CreateYearForm />
      </div>
      <div>
        <h3 className="mb-3 font-medium">Academic Years</h3>
        {(years ?? []).length === 0 ? (
          <p className="text-sm text-gray-500">No academic years yet.</p>
        ) : (
          <div className="space-y-2">
            {(years ?? []).map(y => (
              <AcademicYearRow key={y.id} id={y.id} label={y.label} isActive={y.is_active} />
            ))}
          </div>
        )}
      </div>

      {activeYear && (
        <div className="rounded-lg border border-red-200 bg-red-50 p-4">
          <h3 className="mb-1 font-medium text-red-800">Danger Zone</h3>
          <p className="mb-3 text-sm text-red-700">
            Reset all payment and deposit data for the active year ({activeYear.label}).
            Student and enrollment records are preserved.
          </p>
          <ResetPaymentsButton
            activeYearId={activeYear.id}
            activeYearLabel={activeYear.label}
          />
        </div>
      )}
    </div>
  )
}
```

- [ ] **Step 3: Verify TypeScript compiles**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 4: Commit**

```
git add "app/(dashboard)/fee-setup/reset-payments-button.tsx" "app/(dashboard)/fee-setup/academic-year-tab.tsx"
git commit -m "feat: add Danger Zone with reset payments to fee setup"
```

---

## Task 9: Final verification

- [ ] **Step 1: Run all tests**

```
npm test
```

Expected: All 35+ tests pass.

- [ ] **Step 2: Final TypeScript check**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 3: Verify in browser (admin account)**

**Edit flow (Collect Fee):**
1. Go to /collect-fee, select a student with payments
2. In the Payment History panel, each payment row should have a pencil icon
3. Click the pencil → Edit Payment dialog opens with fields pre-filled
4. Change the amount, enter a reason, click Save Changes
5. Dialog closes, payment amount updates in the panel
6. Open the receipt — it should reflect the old amount (receipt is a snapshot)

**Edit flow (Dashboard):**
1. Go to / (Dashboard)
2. Recent Payments table should have a pencil icon column for admin
3. Click pencil on a payment → same dialog, same flow

**Delete flow:**
1. Open Edit Payment dialog for a payment
2. Click Delete → confirm dialog appears with receipt number
3. Click OK → payment is removed from the list

**Reset flow (Fee Setup):**
1. Go to /fee-setup → Academic Year tab
2. Danger Zone section appears at the bottom with active year label
3. Click "Reset All Payments" → confirmation dialog opens
4. Type the wrong year label → "Confirm Reset" stays disabled
5. Type the exact year label → "Confirm Reset" becomes enabled
6. Click Confirm Reset → all payments/deposits cleared, page refreshes

**Cashier account:**
1. Log in as cashier
2. Go to /collect-fee → no pencil icons in Payment History
3. Go to / → no pencil icons in Recent Payments table
4. /fee-setup is not in the sidebar (tab hidden)

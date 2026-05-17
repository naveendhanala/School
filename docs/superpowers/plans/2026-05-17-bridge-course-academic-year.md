# Bridge Course + Academic Year Management Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the Bridge Course module (students, payments by mode, bank deposits) and fill the Academic Year management tab in Fee Setup (list years, create, set active).

**Architecture:** Bridge Course follows the same RSC-first pattern as other modules — server page fetches and aggregates data, single `BridgeCourseClient` handles all interactivity. Academic Year tab uses the existing async-server-component-with-client-islands pattern from Fee Setup (ClassFeesTab / TransportTab).

**Tech Stack:** Next.js 15 App Router, Supabase server client, server actions, `useTransition`, `formatCurrency`, `toCsv`.

---

### Task 1: Bridge Course server actions

**Files:**
- Create: `app/(dashboard)/bridge-course/actions.ts`

- [ ] **Step 1: Create actions.ts**

```typescript
'use server'

import { revalidatePath } from 'next/cache'
import { createClient } from '@/lib/supabase/server'
import type { Course, Gender, BridgePaymentMode } from '@/lib/types'

export async function addBridgeStudent(input: {
  voucherNo: string
  name: string
  course: Course
  gender: Gender
  phone: string | null
  totalFee: number
}): Promise<{ error?: string }> {
  const supabase = await createClient()

  if (!input.voucherNo.trim()) return { error: 'Voucher number is required' }
  if (!input.name.trim()) return { error: 'Name is required' }
  if (!Number.isFinite(input.totalFee) || input.totalFee <= 0) {
    return { error: 'Total fee must be greater than 0' }
  }

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) return { error: 'No active academic year' }

  const { error } = await supabase.from('bridge_students').insert({
    academic_year_id: activeYear.id,
    voucher_no: input.voucherNo.trim(),
    name: input.name.trim(),
    course: input.course,
    gender: input.gender,
    phone: input.phone?.trim() || null,
    total_fee: input.totalFee,
  })

  if (error) return { error: error.message }

  revalidatePath('/bridge-course')
  return {}
}

export async function recordBridgePayment(input: {
  studentId: string
  mode: BridgePaymentMode
  amount: number
}): Promise<{ error?: string }> {
  const supabase = await createClient()

  if (!Number.isFinite(input.amount) || input.amount <= 0) {
    return { error: 'Amount must be greater than 0' }
  }

  const { error } = await supabase.from('bridge_payments').insert({
    bridge_student_id: input.studentId,
    mode: input.mode,
    amount: input.amount,
  })

  if (error) return { error: error.message }

  revalidatePath('/bridge-course')
  return {}
}

export async function deleteBridgeStudent(id: string): Promise<{ error?: string }> {
  const supabase = await createClient()
  const { error } = await supabase.from('bridge_students').delete().eq('id', id)
  if (error) return { error: error.message }
  revalidatePath('/bridge-course')
  return {}
}

export async function addBridgeDeposit(input: {
  bankName: string
  amount: number
  depositDate: string
  reference: string | null
}): Promise<{ error?: string }> {
  const supabase = await createClient()

  if (!input.bankName.trim()) return { error: 'Bank name is required' }
  if (!Number.isFinite(input.amount) || input.amount <= 0) {
    return { error: 'Amount must be greater than 0' }
  }

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) return { error: 'No active academic year' }

  const { error } = await supabase.from('bridge_deposits').insert({
    academic_year_id: activeYear.id,
    bank_name: input.bankName.trim(),
    amount: input.amount,
    deposit_date: input.depositDate,
    reference: input.reference?.trim() || null,
  })

  if (error) return { error: error.message }

  revalidatePath('/bridge-course')
  return {}
}

export async function deleteBridgeDeposit(id: string): Promise<{ error?: string }> {
  const supabase = await createClient()
  const { error } = await supabase.from('bridge_deposits').delete().eq('id', id)
  if (error) return { error: error.message }
  revalidatePath('/bridge-course')
  return {}
}
```

- [ ] **Step 2: Commit**

```bash
git add app/(dashboard)/bridge-course/actions.ts
git commit -m "feat: bridge course server actions (add/delete student, payment, deposit)"
```

---

### Task 2: Bridge Course server page

**Files:**
- Modify: `app/(dashboard)/bridge-course/page.tsx` (replace stub)

- [ ] **Step 1: Replace page.tsx**

```typescript
import { createClient } from '@/lib/supabase/server'
import type { Course, Gender } from '@/lib/types'
import { BridgeCourseClient } from './bridge-course-client'

export type BridgeStudentRow = {
  id: string
  voucherNo: string
  name: string
  course: Course
  gender: Gender
  phone: string | null
  totalFee: number
  cash: number
  phonepe: number
  hdfc: number
  totalPaid: number
  balance: number
  status: 'paid' | 'partial' | 'unpaid'
}

export type BridgeDepositRow = {
  id: string
  bankName: string
  amount: number
  depositDate: string
  reference: string | null
  createdAt: string
}

export default async function BridgeCoursePage() {
  const supabase = await createClient()

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id, label')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) {
    return (
      <div className="p-6">
        <h1 className="text-2xl font-bold text-gray-900">Bridge Course</h1>
        <p className="mt-2 text-gray-500">No active academic year. Set one up in Fee Setup.</p>
      </div>
    )
  }

  const { data: studentsRaw } = await supabase
    .from('bridge_students')
    .select('id, voucher_no, name, course, gender, phone, total_fee')
    .eq('academic_year_id', activeYear.id)
    .order('voucher_no')

  const students = studentsRaw ?? []
  const studentIds = students.map(s => s.id)

  const [{ data: paymentsRaw }, { data: depositsRaw }] = await Promise.all([
    studentIds.length > 0
      ? supabase
          .from('bridge_payments')
          .select('bridge_student_id, mode, amount')
          .in('bridge_student_id', studentIds)
      : { data: [] as { bridge_student_id: string; mode: string; amount: number }[] },
    supabase
      .from('bridge_deposits')
      .select('id, bank_name, amount, deposit_date, reference, created_at')
      .eq('academic_year_id', activeYear.id)
      .order('deposit_date', { ascending: false })
      .order('created_at', { ascending: false }),
  ])

  const paymentMap = new Map<string, { cash: number; phonepe: number; hdfc: number }>()
  for (const p of paymentsRaw ?? []) {
    const entry = paymentMap.get(p.bridge_student_id) ?? { cash: 0, phonepe: 0, hdfc: 0 }
    if (p.mode === 'cash') entry.cash += Number(p.amount)
    else if (p.mode === 'phonepe') entry.phonepe += Number(p.amount)
    else if (p.mode === 'hdfc') entry.hdfc += Number(p.amount)
    paymentMap.set(p.bridge_student_id, entry)
  }

  const bridgeStudents: BridgeStudentRow[] = students.map(s => {
    const modes = paymentMap.get(s.id) ?? { cash: 0, phonepe: 0, hdfc: 0 }
    const totalPaid = modes.cash + modes.phonepe + modes.hdfc
    const balance = Number(s.total_fee) - totalPaid
    const status: BridgeStudentRow['status'] =
      balance <= 0 ? 'paid' : totalPaid > 0 ? 'partial' : 'unpaid'
    return {
      id: s.id,
      voucherNo: s.voucher_no,
      name: s.name,
      course: s.course as Course,
      gender: s.gender as Gender,
      phone: s.phone,
      totalFee: Number(s.total_fee),
      cash: modes.cash,
      phonepe: modes.phonepe,
      hdfc: modes.hdfc,
      totalPaid,
      balance: Math.max(0, balance),
      status,
    }
  })

  const deposits: BridgeDepositRow[] = (depositsRaw ?? []).map(d => ({
    id: d.id,
    bankName: d.bank_name,
    amount: Number(d.amount),
    depositDate: d.deposit_date,
    reference: d.reference,
    createdAt: d.created_at,
  }))

  return (
    <BridgeCourseClient
      students={bridgeStudents}
      deposits={deposits}
      activeYearLabel={activeYear.label}
    />
  )
}
```

- [ ] **Step 2: TypeScript check**

Run: `npx tsc --noEmit`
Expected: error only for missing `BridgeCourseClient` module

- [ ] **Step 3: Commit**

```bash
git add app/(dashboard)/bridge-course/page.tsx
git commit -m "feat: bridge course server page with student and deposit data aggregation"
```

---

### Task 3: Bridge Course dialogs

**Files:**
- Create: `app/(dashboard)/bridge-course/add-student-dialog.tsx`
- Create: `app/(dashboard)/bridge-course/payment-dialog.tsx`
- Create: `app/(dashboard)/bridge-course/bridge-deposit-dialog.tsx`

- [ ] **Step 1: Create add-student-dialog.tsx**

```typescript
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
import { addBridgeStudent } from './actions'

interface AddStudentDialogProps {
  open: boolean
  onOpenChange: (open: boolean) => void
}

const EMPTY_FORM = {
  voucherNo: '', name: '', course: 'IIT' as 'IIT' | 'NON-IIT',
  gender: 'male' as 'male' | 'female', phone: '', totalFee: '',
}

export function AddStudentDialog({ open, onOpenChange }: AddStudentDialogProps) {
  const router = useRouter()
  const [isPending, startTransition] = useTransition()
  const [error, setError] = useState<string | null>(null)
  const [form, setForm] = useState(EMPTY_FORM)

  function reset() { setForm(EMPTY_FORM); setError(null) }
  function handleClose() { onOpenChange(false); reset() }

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    const parsedFee = parseFloat(form.totalFee)
    if (!Number.isFinite(parsedFee) || parsedFee <= 0) {
      setError('Total fee must be greater than 0')
      return
    }
    setError(null)
    startTransition(async () => {
      const result = await addBridgeStudent({
        voucherNo: form.voucherNo.trim(),
        name: form.name.trim(),
        course: form.course,
        gender: form.gender,
        phone: form.phone.trim() || null,
        totalFee: parsedFee,
      })
      if (result.error) { setError(result.error); return }
      reset()
      onOpenChange(false)
      router.refresh()
    })
  }

  return (
    <Dialog open={open} onOpenChange={o => { if (!o) handleClose(); else onOpenChange(true) }}>
      <DialogContent className="max-w-md">
        <DialogHeader><DialogTitle>Add Bridge Student</DialogTitle></DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1">
              <Label htmlFor="voucher-no">Voucher No</Label>
              <Input
                id="voucher-no"
                value={form.voucherNo}
                onChange={e => setForm(f => ({ ...f, voucherNo: e.target.value }))}
                placeholder="e.g. BC001"
                required
              />
            </div>
            <div className="space-y-1">
              <Label htmlFor="total-fee">Total Fee (₹)</Label>
              <Input
                id="total-fee"
                type="number"
                min="0.01"
                step="0.01"
                value={form.totalFee}
                onChange={e => setForm(f => ({ ...f, totalFee: e.target.value }))}
                placeholder="0.00"
                required
              />
            </div>
          </div>

          <div className="space-y-1">
            <Label htmlFor="student-name">Name</Label>
            <Input
              id="student-name"
              value={form.name}
              onChange={e => setForm(f => ({ ...f, name: e.target.value }))}
              placeholder="Student name"
              required
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1">
              <Label>Course</Label>
              <Select
                value={form.course}
                onValueChange={v => setForm(f => ({ ...f, course: v as 'IIT' | 'NON-IIT' }))}
              >
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>
                  <SelectItem value="IIT">IIT</SelectItem>
                  <SelectItem value="NON-IIT">NON-IIT</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-1">
              <Label>Gender</Label>
              <Select
                value={form.gender}
                onValueChange={v => setForm(f => ({ ...f, gender: v as 'male' | 'female' }))}
              >
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>
                  <SelectItem value="male">Male</SelectItem>
                  <SelectItem value="female">Female</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>

          <div className="space-y-1">
            <Label htmlFor="phone">
              Phone <span className="font-normal text-gray-400">(optional)</span>
            </Label>
            <Input
              id="phone"
              value={form.phone}
              onChange={e => setForm(f => ({ ...f, phone: e.target.value }))}
              placeholder="Mobile number"
            />
          </div>

          {error && <p className="text-sm text-red-500">{error}</p>}

          <div className="flex gap-3 pt-2">
            <Button type="submit" disabled={isPending} className="flex-1">
              {isPending ? 'Adding…' : 'Add Student'}
            </Button>
            <Button type="button" variant="outline" onClick={handleClose} disabled={isPending}>
              Cancel
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}
```

- [ ] **Step 2: Create payment-dialog.tsx**

```typescript
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
import { recordBridgePayment } from './actions'
import type { BridgePaymentMode } from '@/lib/types'

interface PaymentDialogProps {
  open: boolean
  onOpenChange: (open: boolean) => void
  studentId: string
  studentName: string
}

export function PaymentDialog({ open, onOpenChange, studentId, studentName }: PaymentDialogProps) {
  const router = useRouter()
  const [isPending, startTransition] = useTransition()
  const [error, setError] = useState<string | null>(null)
  const [mode, setMode] = useState<BridgePaymentMode>('cash')
  const [amount, setAmount] = useState('')

  function reset() { setMode('cash'); setAmount(''); setError(null) }
  function handleClose() { onOpenChange(false); reset() }

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    const parsedAmount = parseFloat(amount)
    if (!Number.isFinite(parsedAmount) || parsedAmount <= 0) {
      setError('Amount must be greater than 0')
      return
    }
    setError(null)
    startTransition(async () => {
      const result = await recordBridgePayment({ studentId, mode, amount: parsedAmount })
      if (result.error) { setError(result.error); return }
      reset()
      onOpenChange(false)
      router.refresh()
    })
  }

  return (
    <Dialog open={open} onOpenChange={o => { if (!o) handleClose(); else onOpenChange(true) }}>
      <DialogContent className="max-w-sm">
        <DialogHeader>
          <DialogTitle>Record Payment</DialogTitle>
          <p className="text-sm text-gray-500">{studentName}</p>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-1">
            <Label>Mode</Label>
            <Select value={mode} onValueChange={v => setMode(v as BridgePaymentMode)}>
              <SelectTrigger><SelectValue /></SelectTrigger>
              <SelectContent>
                <SelectItem value="cash">Cash</SelectItem>
                <SelectItem value="phonepe">PhonePe</SelectItem>
                <SelectItem value="hdfc">HDFC Bank</SelectItem>
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-1">
            <Label htmlFor="pay-amount">Amount (₹)</Label>
            <Input
              id="pay-amount"
              type="number"
              min="0.01"
              step="0.01"
              value={amount}
              onChange={e => setAmount(e.target.value)}
              placeholder="0.00"
              required
            />
          </div>

          {error && <p className="text-sm text-red-500">{error}</p>}

          <div className="flex gap-3 pt-2">
            <Button type="submit" disabled={isPending} className="flex-1">
              {isPending ? 'Saving…' : 'Record Payment'}
            </Button>
            <Button type="button" variant="outline" onClick={handleClose} disabled={isPending}>
              Cancel
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}
```

- [ ] **Step 3: Create bridge-deposit-dialog.tsx**

```typescript
'use client'

import { useState, useTransition } from 'react'
import { useRouter } from 'next/navigation'
import {
  Dialog, DialogContent, DialogHeader, DialogTitle,
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { addBridgeDeposit } from './actions'

interface BridgeDepositDialogProps {
  open: boolean
  onOpenChange: (open: boolean) => void
}

function todayIso() { return new Date().toISOString().slice(0, 10) }

const EMPTY = { bankName: '', amount: '', depositDate: todayIso(), reference: '' }

export function BridgeDepositDialog({ open, onOpenChange }: BridgeDepositDialogProps) {
  const router = useRouter()
  const [isPending, startTransition] = useTransition()
  const [error, setError] = useState<string | null>(null)
  const [form, setForm] = useState(EMPTY)

  function reset() { setForm({ ...EMPTY, depositDate: todayIso() }); setError(null) }
  function handleClose() { onOpenChange(false); reset() }

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    const parsedAmount = parseFloat(form.amount)
    if (!Number.isFinite(parsedAmount) || parsedAmount <= 0) {
      setError('Amount must be greater than 0')
      return
    }
    setError(null)
    startTransition(async () => {
      const result = await addBridgeDeposit({
        bankName: form.bankName.trim(),
        amount: parsedAmount,
        depositDate: form.depositDate,
        reference: form.reference.trim() || null,
      })
      if (result.error) { setError(result.error); return }
      reset()
      onOpenChange(false)
      router.refresh()
    })
  }

  return (
    <Dialog open={open} onOpenChange={o => { if (!o) handleClose(); else onOpenChange(true) }}>
      <DialogContent className="max-w-sm">
        <DialogHeader><DialogTitle>Add Bridge Deposit</DialogTitle></DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-1">
            <Label htmlFor="bd-bank">Bank Name</Label>
            <Input
              id="bd-bank"
              value={form.bankName}
              onChange={e => setForm(f => ({ ...f, bankName: e.target.value }))}
              placeholder="e.g. SBI, HDFC"
              required
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1">
              <Label htmlFor="bd-amount">Amount (₹)</Label>
              <Input
                id="bd-amount"
                type="number"
                min="0.01"
                step="0.01"
                value={form.amount}
                onChange={e => setForm(f => ({ ...f, amount: e.target.value }))}
                placeholder="0.00"
                required
              />
            </div>
            <div className="space-y-1">
              <Label htmlFor="bd-date">Date</Label>
              <Input
                id="bd-date"
                type="date"
                value={form.depositDate}
                onChange={e => setForm(f => ({ ...f, depositDate: e.target.value }))}
                required
              />
            </div>
          </div>

          <div className="space-y-1">
            <Label htmlFor="bd-ref">
              Reference <span className="font-normal text-gray-400">(optional)</span>
            </Label>
            <Input
              id="bd-ref"
              value={form.reference}
              onChange={e => setForm(f => ({ ...f, reference: e.target.value }))}
              placeholder="Challan no., UTR, etc."
            />
          </div>

          {error && <p className="text-sm text-red-500">{error}</p>}

          <div className="flex gap-3 pt-2">
            <Button type="submit" disabled={isPending} className="flex-1">
              {isPending ? 'Saving…' : 'Add Deposit'}
            </Button>
            <Button type="button" variant="outline" onClick={handleClose} disabled={isPending}>
              Cancel
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}
```

- [ ] **Step 4: Commit**

```bash
git add app/(dashboard)/bridge-course/add-student-dialog.tsx app/(dashboard)/bridge-course/payment-dialog.tsx app/(dashboard)/bridge-course/bridge-deposit-dialog.tsx
git commit -m "feat: bridge course dialogs (add student, record payment, add deposit)"
```

---

### Task 4: Bridge Course client

**Files:**
- Create: `app/(dashboard)/bridge-course/bridge-course-client.tsx`

- [ ] **Step 1: Create bridge-course-client.tsx**

```typescript
'use client'

import { useMemo, useState, useTransition } from 'react'
import { useRouter } from 'next/navigation'
import { toCsv } from '@/lib/utils/csv'
import { formatCurrency } from '@/lib/utils/currency'
import { Button } from '@/components/ui/button'
import {
  Select, SelectContent, SelectItem, SelectTrigger, SelectValue,
} from '@/components/ui/select'
import { Download, Plus, Trash2 } from 'lucide-react'
import { deleteBridgeStudent, deleteBridgeDeposit } from './actions'
import { AddStudentDialog } from './add-student-dialog'
import { PaymentDialog } from './payment-dialog'
import { BridgeDepositDialog } from './bridge-deposit-dialog'
import type { BridgeStudentRow, BridgeDepositRow } from './page'

interface BridgeCourseClientProps {
  students: BridgeStudentRow[]
  deposits: BridgeDepositRow[]
  activeYearLabel: string
}

const STATUS_BADGE: Record<string, string> = {
  paid: 'bg-green-100 text-green-700',
  partial: 'bg-amber-100 text-amber-700',
  unpaid: 'bg-red-100 text-red-700',
}

const STATUS_LABEL: Record<string, string> = {
  paid: 'Paid', partial: 'Partial', unpaid: 'Unpaid',
}

type PaymentTarget = { id: string; name: string } | null

export function BridgeCourseClient({
  students,
  deposits,
  activeYearLabel,
}: BridgeCourseClientProps) {
  const router = useRouter()
  const [isPending, startTransition] = useTransition()
  const [addStudentOpen, setAddStudentOpen] = useState(false)
  const [depositDialogOpen, setDepositDialogOpen] = useState(false)
  const [paymentTarget, setPaymentTarget] = useState<PaymentTarget>(null)
  const [courseFilter, setCourseFilter] = useState('all')
  const [statusFilter, setStatusFilter] = useState('all')
  const [deletingId, setDeletingId] = useState<string | null>(null)
  const [deletingDepositId, setDeletingDepositId] = useState<string | null>(null)

  const filtered = useMemo(() => {
    return students.filter(s => {
      if (courseFilter !== 'all' && s.course !== courseFilter) return false
      if (statusFilter !== 'all' && s.status !== statusFilter) return false
      return true
    })
  }, [students, courseFilter, statusFilter])

  const totalStudents = filtered.length
  const totalFee = filtered.reduce((s, r) => s + r.totalFee, 0)
  const totalPaid = filtered.reduce((s, r) => s + r.totalPaid, 0)
  const totalPending = filtered.reduce((s, r) => s + r.balance, 0)
  const totalDeposited = deposits.reduce((s, d) => s + d.amount, 0)

  function handleDeleteStudent(id: string, name: string) {
    if (!window.confirm(`Delete ${name}? This will also delete all their payments.`)) return
    setDeletingId(id)
    startTransition(async () => {
      const result = await deleteBridgeStudent(id)
      setDeletingId(null)
      if (result.error) { alert(`Delete failed: ${result.error}`); return }
      router.refresh()
    })
  }

  function handleDeleteDeposit(id: string) {
    if (!window.confirm('Delete this deposit? This cannot be undone.')) return
    setDeletingDepositId(id)
    startTransition(async () => {
      const result = await deleteBridgeDeposit(id)
      setDeletingDepositId(null)
      if (result.error) { alert(`Delete failed: ${result.error}`); return }
      router.refresh()
    })
  }

  function handleExport() {
    const csv = toCsv(
      ['Voucher', 'Name', 'Course', 'Gender', 'Phone', 'Total Fee', 'Cash', 'PhonePe', 'HDFC', 'Total Paid', 'Balance', 'Status'],
      filtered.map(s => [
        s.voucherNo, s.name, s.course, s.gender, s.phone ?? '',
        s.totalFee, s.cash, s.phonepe, s.hdfc, s.totalPaid, s.balance,
        STATUS_LABEL[s.status],
      ])
    )
    const blob = new Blob([csv], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `bridge-course-${activeYearLabel}.csv`
    a.click()
    URL.revokeObjectURL(url)
  }

  return (
    <div className="space-y-6 p-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Bridge Course</h1>
          <p className="mt-1 text-sm text-gray-500">Academic Year: {activeYearLabel}</p>
        </div>
        <Button onClick={() => setAddStudentOpen(true)} className="gap-2">
          <Plus className="h-4 w-4" />
          Add Student
        </Button>
      </div>

      {/* Summary cards */}
      <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
        <div className="rounded-lg border bg-white p-4">
          <p className="text-sm text-gray-500">Students</p>
          <p className="mt-1 text-2xl font-bold text-blue-600">{totalStudents}</p>
        </div>
        <div className="rounded-lg border bg-white p-4">
          <p className="text-sm text-gray-500">Total Fee</p>
          <p className="mt-1 text-2xl font-bold text-gray-900">{formatCurrency(totalFee)}</p>
        </div>
        <div className="rounded-lg border bg-white p-4">
          <p className="text-sm text-gray-500">Collected</p>
          <p className="mt-1 text-2xl font-bold text-green-600">{formatCurrency(totalPaid)}</p>
        </div>
        <div className="rounded-lg border bg-white p-4">
          <p className="text-sm text-gray-500">Pending</p>
          <p className="mt-1 text-2xl font-bold text-red-600">{formatCurrency(totalPending)}</p>
        </div>
      </div>

      {/* Filters + export */}
      <div className="flex flex-wrap items-center gap-3">
        <Select value={courseFilter} onValueChange={setCourseFilter}>
          <SelectTrigger className="w-32">
            <SelectValue placeholder="Course" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Courses</SelectItem>
            <SelectItem value="IIT">IIT</SelectItem>
            <SelectItem value="NON-IIT">NON-IIT</SelectItem>
          </SelectContent>
        </Select>

        <Select value={statusFilter} onValueChange={setStatusFilter}>
          <SelectTrigger className="w-32">
            <SelectValue placeholder="Status" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Status</SelectItem>
            <SelectItem value="paid">Paid</SelectItem>
            <SelectItem value="partial">Partial</SelectItem>
            <SelectItem value="unpaid">Unpaid</SelectItem>
          </SelectContent>
        </Select>

        <Button
          variant="outline" size="sm"
          onClick={handleExport}
          disabled={filtered.length === 0}
          className="ml-auto gap-2"
        >
          <Download className="h-4 w-4" />
          Export CSV
        </Button>
      </div>

      {/* Students table */}
      {filtered.length === 0 ? (
        <p className="text-sm text-gray-500">No students found.</p>
      ) : (
        <div className="overflow-x-auto rounded-lg border bg-white">
          <table className="min-w-full text-sm">
            <thead className="bg-gray-50 text-gray-600">
              <tr>
                <th scope="col" className="px-3 py-3 text-left font-medium">Voucher</th>
                <th scope="col" className="px-3 py-3 text-left font-medium">Name</th>
                <th scope="col" className="px-3 py-3 text-left font-medium">Course</th>
                <th scope="col" className="px-3 py-3 text-left font-medium">Phone</th>
                <th scope="col" className="px-3 py-3 text-right font-medium">Fee</th>
                <th scope="col" className="px-3 py-3 text-right font-medium">Cash</th>
                <th scope="col" className="px-3 py-3 text-right font-medium">PhonePe</th>
                <th scope="col" className="px-3 py-3 text-right font-medium">HDFC</th>
                <th scope="col" className="px-3 py-3 text-right font-medium">Balance</th>
                <th scope="col" className="px-3 py-3 text-center font-medium">Status</th>
                <th scope="col" className="px-3 py-3" />
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {filtered.map(s => (
                <tr key={s.id} className="hover:bg-gray-50">
                  <td className="px-3 py-3 font-mono text-xs">{s.voucherNo}</td>
                  <td className="px-3 py-3 font-medium">{s.name}</td>
                  <td className="px-3 py-3">
                    <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${
                      s.course === 'IIT' ? 'bg-purple-100 text-purple-700' : 'bg-blue-100 text-blue-700'
                    }`}>
                      {s.course}
                    </span>
                  </td>
                  <td className="px-3 py-3 text-gray-500">{s.phone ?? '—'}</td>
                  <td className="px-3 py-3 text-right tabular-nums">{formatCurrency(s.totalFee)}</td>
                  <td className="px-3 py-3 text-right tabular-nums text-green-600">
                    {s.cash > 0 ? formatCurrency(s.cash) : '—'}
                  </td>
                  <td className="px-3 py-3 text-right tabular-nums text-green-600">
                    {s.phonepe > 0 ? formatCurrency(s.phonepe) : '—'}
                  </td>
                  <td className="px-3 py-3 text-right tabular-nums text-green-600">
                    {s.hdfc > 0 ? formatCurrency(s.hdfc) : '—'}
                  </td>
                  <td className="px-3 py-3 text-right tabular-nums font-semibold text-red-600">
                    {s.balance > 0 ? formatCurrency(s.balance) : '—'}
                  </td>
                  <td className="px-3 py-3 text-center">
                    <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${STATUS_BADGE[s.status]}`}>
                      {STATUS_LABEL[s.status]}
                    </span>
                  </td>
                  <td className="px-3 py-3 text-right">
                    <div className="flex items-center justify-end gap-1">
                      {s.status !== 'paid' && (
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => setPaymentTarget({ id: s.id, name: s.name })}
                          className="h-7 text-xs"
                        >
                          Pay
                        </Button>
                      )}
                      <button
                        onClick={() => handleDeleteStudent(s.id, s.name)}
                        disabled={isPending && deletingId === s.id}
                        className="rounded p-1 text-gray-400 hover:bg-red-50 hover:text-red-600 disabled:opacity-40"
                        aria-label="Delete student"
                      >
                        <Trash2 className="h-4 w-4" />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {/* Bridge Deposits */}
      <div className="space-y-3">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="font-semibold text-gray-900">Bank Deposits</h2>
            <p className="text-sm text-gray-500">
              Total deposited: <span className="font-medium text-blue-600">{formatCurrency(totalDeposited)}</span>
            </p>
          </div>
          <Button variant="outline" size="sm" onClick={() => setDepositDialogOpen(true)} className="gap-2">
            <Plus className="h-4 w-4" />
            Add Deposit
          </Button>
        </div>

        {deposits.length === 0 ? (
          <p className="text-sm text-gray-500">No deposits recorded.</p>
        ) : (
          <div className="overflow-x-auto rounded-lg border bg-white">
            <table className="min-w-full text-sm">
              <thead className="bg-gray-50 text-gray-600">
                <tr>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Date</th>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Bank</th>
                  <th scope="col" className="px-4 py-3 text-right font-medium">Amount</th>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Reference</th>
                  <th scope="col" className="px-4 py-3" />
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {deposits.map(d => (
                  <tr key={d.id} className="hover:bg-gray-50">
                    <td className="px-4 py-3 tabular-nums">{d.depositDate}</td>
                    <td className="px-4 py-3 font-medium">{d.bankName}</td>
                    <td className="px-4 py-3 text-right font-semibold text-green-600">
                      {formatCurrency(d.amount)}
                    </td>
                    <td className="px-4 py-3 text-gray-500">{d.reference ?? '—'}</td>
                    <td className="px-4 py-3 text-right">
                      <button
                        onClick={() => handleDeleteDeposit(d.id)}
                        disabled={isPending && deletingDepositId === d.id}
                        className="rounded p-1 text-gray-400 hover:bg-red-50 hover:text-red-600 disabled:opacity-40"
                        aria-label="Delete deposit"
                      >
                        <Trash2 className="h-4 w-4" />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      <AddStudentDialog open={addStudentOpen} onOpenChange={setAddStudentOpen} />
      <PaymentDialog
        open={paymentTarget !== null}
        onOpenChange={open => { if (!open) setPaymentTarget(null) }}
        studentId={paymentTarget?.id ?? ''}
        studentName={paymentTarget?.name ?? ''}
      />
      <BridgeDepositDialog open={depositDialogOpen} onOpenChange={setDepositDialogOpen} />
    </div>
  )
}
```

- [ ] **Step 2: TypeScript check**

Run: `npx tsc --noEmit`
Expected: clean

- [ ] **Step 3: Run tests**

Run: `npx vitest run`
Expected: 32 tests pass

- [ ] **Step 4: Commit**

```bash
git add app/(dashboard)/bridge-course/bridge-course-client.tsx
git commit -m "feat: bridge course client with student table, filters, payments, and deposits"
```

---

### Task 5: Academic Year management tab

**Files:**
- Modify: `app/(dashboard)/fee-setup/actions.ts` (add 2 actions)
- Create: `app/(dashboard)/fee-setup/academic-year-tab.tsx`
- Create: `app/(dashboard)/fee-setup/academic-year-row.tsx`
- Create: `app/(dashboard)/fee-setup/create-year-form.tsx`
- Modify: `app/(dashboard)/fee-setup/page.tsx` (wire up AcademicYearTab)

- [ ] **Step 1: Add actions to fee-setup/actions.ts**

Append to the bottom of the existing file:

```typescript
export async function createAcademicYear(label: string): Promise<{ error?: string }> {
  const supabase = await createClient()
  if (!label.trim()) return { error: 'Label is required' }
  const { error } = await supabase
    .from('academic_years')
    .insert({ label: label.trim(), is_active: false })
  if (error) return { error: error.message }
  revalidatePath('/fee-setup')
  return {}
}

export async function setActiveYear(id: string): Promise<{ error?: string }> {
  const supabase = await createClient()
  // Deactivate all currently active years
  const { error: e1 } = await supabase
    .from('academic_years')
    .update({ is_active: false })
    .eq('is_active', true)
  if (e1) return { error: e1.message }
  // Activate the selected year
  const { error: e2 } = await supabase
    .from('academic_years')
    .update({ is_active: true })
    .eq('id', id)
  if (e2) return { error: e2.message }
  revalidatePath('/fee-setup')
  revalidatePath('/')
  revalidatePath('/students')
  revalidatePath('/collect-fee')
  revalidatePath('/pending-fees')
  revalidatePath('/reports')
  revalidatePath('/bank-deposits')
  revalidatePath('/bridge-course')
  return {}
}
```

- [ ] **Step 2: Create academic-year-tab.tsx**

```typescript
import { createClient } from '@/lib/supabase/server'
import { AcademicYearRow } from './academic-year-row'
import { CreateYearForm } from './create-year-form'

export async function AcademicYearTab() {
  const supabase = await createClient()
  const { data: years } = await supabase
    .from('academic_years')
    .select('id, label, is_active')
    .order('created_at', { ascending: false })

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
    </div>
  )
}
```

- [ ] **Step 3: Create academic-year-row.tsx**

```typescript
'use client'

import { useTransition } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { setActiveYear } from './actions'

interface AcademicYearRowProps {
  id: string
  label: string
  isActive: boolean
}

export function AcademicYearRow({ id, label, isActive }: AcademicYearRowProps) {
  const [isPending, startTransition] = useTransition()
  const router = useRouter()

  function handleSetActive() {
    startTransition(async () => {
      await setActiveYear(id)
      router.refresh()
    })
  }

  return (
    <div className="flex items-center justify-between rounded-lg border bg-white px-4 py-3">
      <div className="flex items-center gap-3">
        <span className="font-medium">{label}</span>
        {isActive && (
          <span className="rounded-full bg-green-100 px-2 py-0.5 text-xs font-medium text-green-700">
            Active
          </span>
        )}
      </div>
      {!isActive && (
        <Button variant="outline" size="sm" onClick={handleSetActive} disabled={isPending}>
          {isPending ? 'Setting…' : 'Set Active'}
        </Button>
      )}
    </div>
  )
}
```

- [ ] **Step 4: Create create-year-form.tsx**

```typescript
'use client'

import { useState, useTransition } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { createAcademicYear } from './actions'

export function CreateYearForm() {
  const [label, setLabel] = useState('')
  const [error, setError] = useState<string | null>(null)
  const [isPending, startTransition] = useTransition()
  const router = useRouter()

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setError(null)
    startTransition(async () => {
      const result = await createAcademicYear(label)
      if (result.error) { setError(result.error); return }
      setLabel('')
      router.refresh()
    })
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-2">
      <div className="flex max-w-sm gap-2">
        <Input
          value={label}
          onChange={e => setLabel(e.target.value)}
          placeholder="e.g. 2026-27"
          required
          className="flex-1"
        />
        <Button type="submit" disabled={isPending}>
          {isPending ? 'Creating…' : 'Create'}
        </Button>
      </div>
      {error && <p className="text-sm text-red-500">{error}</p>}
    </form>
  )
}
```

- [ ] **Step 5: Update fee-setup/page.tsx to wire up AcademicYearTab**

In `app/(dashboard)/fee-setup/page.tsx`, add the import and replace the stub `TabsContent` for `academic-year`:

Add import at the top:
```typescript
import { AcademicYearTab } from './academic-year-tab'
```

Replace:
```typescript
        <TabsContent value="academic-year">
          <div className="mt-4 p-4 bg-gray-50 rounded border text-gray-500 text-sm">
            Academic year management coming in a future update.
          </div>
        </TabsContent>
```

With:
```typescript
        <TabsContent value="academic-year">
          <Suspense fallback={<div className="mt-4 p-4 text-sm text-gray-400">Loading…</div>}>
            <AcademicYearTab />
          </Suspense>
        </TabsContent>
```

- [ ] **Step 6: TypeScript check**

Run: `npx tsc --noEmit`
Expected: clean

- [ ] **Step 7: Run tests**

Run: `npx vitest run`
Expected: 32 tests pass

- [ ] **Step 8: Commit**

```bash
git add app/(dashboard)/fee-setup/actions.ts app/(dashboard)/fee-setup/academic-year-tab.tsx app/(dashboard)/fee-setup/academic-year-row.tsx app/(dashboard)/fee-setup/create-year-form.tsx app/(dashboard)/fee-setup/page.tsx
git commit -m "feat: academic year management tab (create, list, set active)"
```

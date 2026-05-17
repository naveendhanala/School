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
  { value: 'tuition', label: 'Tuition' },
  { value: 'book', label: 'Book' },
  { value: 'transport', label: 'Transport' },
  { value: 'hostel', label: 'Hostel' },
  { value: 'admission', label: 'Admission' },
  { value: 'uniform', label: 'Uniform' },
  { value: 'exam', label: 'Exam' },
  { value: 'other', label: 'Other' },
]

const PAYMENT_MODES: { value: PaymentMode; label: string }[] = [
  { value: 'cash', label: 'Cash' },
  { value: 'upi', label: 'UPI' },
  { value: 'cheque', label: 'Cheque' },
  { value: 'neft_rtgs', label: 'NEFT/RTGS' },
  { value: 'demand_draft', label: 'Demand Draft' },
]

export type EditPaymentTarget = {
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
  payment: EditPaymentTarget
  open: boolean
  onOpenChange: (open: boolean) => void
}

export function EditPaymentDialog({ payment, open, onOpenChange }: EditPaymentDialogProps) {
  const router = useRouter()
  const [isPending, startTransition] = useTransition()
  const [error, setError] = useState<string | null>(null)
  const [form, setForm] = useState({
    amount: String(payment.amount),
    mode: payment.mode,
    paymentDate: payment.paymentDate,
    feeHead: payment.feeHead,
    reference: payment.reference ?? '',
    remarks: payment.remarks ?? '',
    reason: '',
  })

  function handleOpenChange(o: boolean) {
    if (!o) {
      setError(null)
      setForm({
        amount: String(payment.amount),
        mode: payment.mode,
        paymentDate: payment.paymentDate,
        feeHead: payment.feeHead,
        reference: payment.reference ?? '',
        remarks: payment.remarks ?? '',
        reason: '',
      })
    }
    onOpenChange(o)
  }

  function handleSave(e: React.FormEvent) {
    e.preventDefault()
    const parsedAmount = parseFloat(form.amount)
    if (!Number.isFinite(parsedAmount) || parsedAmount <= 0) {
      setError('Amount must be greater than 0')
      return
    }
    if (!form.reason.trim()) {
      setError('Edit reason is required')
      return
    }
    setError(null)
    startTransition(async () => {
      const result = await editPayment(
        payment.id,
        {
          amount: parsedAmount,
          mode: form.mode,
          payment_date: form.paymentDate,
          fee_head: form.feeHead,
          reference: form.reference.trim() || null,
          remarks: form.remarks.trim() || null,
        },
        form.reason.trim()
      )
      if (result.error) { setError(result.error); return }
      onOpenChange(false)
      router.refresh()
    })
  }

  function handleDelete() {
    if (!window.confirm(`Delete receipt ${payment.receiptNo}? This cannot be undone.`)) return
    startTransition(async () => {
      const result = await deletePayment(payment.id)
      if (result.error) { setError(result.error); return }
      onOpenChange(false)
      router.refresh()
    })
  }

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogContent className="max-w-lg">
        <DialogHeader>
          <DialogTitle>Edit Payment — Receipt {payment.receiptNo}</DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSave} className="space-y-4">
          <div className="grid grid-cols-2 gap-4 rounded-md bg-gray-50 px-3 py-2 text-sm">
            <div>
              <span className="text-gray-500">Student</span>
              <p className="font-medium">{payment.studentName}</p>
            </div>
            <div>
              <span className="text-gray-500">Receipt No</span>
              <p className="font-mono font-medium">{payment.receiptNo}</p>
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1">
              <Label htmlFor="ep-amount">Amount (₹)</Label>
              <Input
                id="ep-amount"
                type="number"
                min="0.01"
                step="0.01"
                value={form.amount}
                onChange={e => setForm(f => ({ ...f, amount: e.target.value }))}
                required
              />
            </div>
            <div className="space-y-1">
              <Label htmlFor="ep-date">Payment Date</Label>
              <Input
                id="ep-date"
                type="date"
                value={form.paymentDate}
                onChange={e => setForm(f => ({ ...f, paymentDate: e.target.value }))}
                required
              />
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1">
              <Label>Mode</Label>
              <Select
                value={form.mode}
                onValueChange={v => setForm(f => ({ ...f, mode: v as PaymentMode }))}
              >
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>
                  {PAYMENT_MODES.map(m => (
                    <SelectItem key={m.value} value={m.value}>{m.label}</SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-1">
              <Label>Fee Head</Label>
              <Select
                value={form.feeHead}
                onValueChange={v => setForm(f => ({ ...f, feeHead: v as FeeHead }))}
              >
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>
                  {FEE_HEADS.map(h => (
                    <SelectItem key={h.value} value={h.value}>{h.label}</SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          </div>

          <div className="space-y-1">
            <Label htmlFor="ep-reference">
              Reference <span className="font-normal text-gray-400">(optional)</span>
            </Label>
            <Input
              id="ep-reference"
              value={form.reference}
              onChange={e => setForm(f => ({ ...f, reference: e.target.value }))}
              placeholder="Cheque no / UPI ref"
            />
          </div>

          <div className="space-y-1">
            <Label htmlFor="ep-remarks">
              Remarks <span className="font-normal text-gray-400">(optional)</span>
            </Label>
            <Input
              id="ep-remarks"
              value={form.remarks}
              onChange={e => setForm(f => ({ ...f, remarks: e.target.value }))}
            />
          </div>

          <div className="space-y-1">
            <Label htmlFor="ep-reason">Edit Reason</Label>
            <textarea
              id="ep-reason"
              className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm shadow-sm placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring"
              rows={2}
              placeholder="Why is this payment being edited?"
              value={form.reason}
              onChange={e => setForm(f => ({ ...f, reason: e.target.value }))}
              required
            />
          </div>

          {error && <p className="text-sm text-red-500">{error}</p>}

          <div className="flex gap-3 pt-2">
            <Button type="submit" disabled={isPending} className="flex-1">
              {isPending ? 'Saving…' : 'Save Changes'}
            </Button>
            <Button
              type="button"
              variant="outline"
              onClick={() => onOpenChange(false)}
              disabled={isPending}
            >
              Cancel
            </Button>
            <Button
              type="button"
              variant="outline"
              className="border-red-200 text-red-600 hover:bg-red-50 hover:text-red-700"
              onClick={handleDelete}
              disabled={isPending}
            >
              Delete
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}

'use client'

import { useState, useTransition } from 'react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { recordPayment } from './actions'
import { formatCurrency } from '@/lib/utils/currency'
import type { FeeHead, PaymentMode } from '@/lib/types'
import type { CollectFeeStudent } from './page'

const FEE_HEAD_OPTIONS: { value: FeeHead; label: string }[] = [
  { value: 'tuition', label: 'Tuition Fee' },
  { value: 'book', label: 'Book Fee' },
  { value: 'transport', label: 'Transport Fee' },
  { value: 'hostel', label: 'Hostel Fee' },
  { value: 'admission', label: 'Admission Fee' },
  { value: 'uniform', label: 'Uniform Fee' },
  { value: 'exam', label: 'Exam Fee' },
  { value: 'other', label: 'Other' },
]

const MODE_OPTIONS: { value: PaymentMode; label: string }[] = [
  { value: 'cash', label: 'Cash' },
  { value: 'upi', label: 'UPI' },
  { value: 'cheque', label: 'Cheque' },
  { value: 'neft_rtgs', label: 'NEFT / RTGS' },
  { value: 'demand_draft', label: 'Demand Draft' },
]

function todayIso(): string {
  return new Date().toISOString().slice(0, 10)
}

interface PaymentFormProps {
  student: CollectFeeStudent
  onSuccess: (paymentId: string) => void
}

export function PaymentForm({ student, onSuccess }: PaymentFormProps) {
  const [feeHead, setFeeHead] = useState<FeeHead>('tuition')
  const [amount, setAmount] = useState('')
  const [mode, setMode] = useState<PaymentMode>('cash')
  const [paymentDate, setPaymentDate] = useState(todayIso())
  const [reference, setReference] = useState('')
  const [remarks, setRemarks] = useState('')
  const [error, setError] = useState<string | null>(null)
  const [isPending, startTransition] = useTransition()

  const selectedBreakdown = student.breakdown.find(b => b.head === feeHead)
  const suggestedBalance = selectedBreakdown ? selectedBreakdown.balance : 0

  function handleFeeHeadChange(value: FeeHead) {
    setFeeHead(value)
    setAmount('')
  }

  function fillBalance() {
    if (suggestedBalance > 0) setAmount(String(suggestedBalance))
  }

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    const parsed = parseFloat(amount)
    if (!Number.isFinite(parsed) || parsed <= 0) {
      setError('Amount must be greater than 0')
      return
    }
    setError(null)

    startTransition(async () => {
      const result = await recordPayment({
        enrollmentId: student.enrollmentId,
        feeHead,
        amount: parsed,
        mode,
        paymentDate,
        reference: reference.trim() || null,
        remarks: remarks.trim() || null,
      })

      if ('error' in result) {
        setError(result.error)
        return
      }

      setAmount('')
      setReference('')
      setRemarks('')
      setFeeHead('tuition')
      setMode('cash')
      setPaymentDate(todayIso())
      onSuccess(result.paymentId)
    })
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
        <div className="space-y-1">
          <Label htmlFor="fee-head">Fee Head</Label>
          <Select value={feeHead} onValueChange={v => handleFeeHeadChange(v as FeeHead)}>
            <SelectTrigger id="fee-head">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              {FEE_HEAD_OPTIONS.map(o => (
                <SelectItem key={o.value} value={o.value}>
                  {o.label}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        <div className="space-y-1">
          <div className="flex items-center justify-between">
            <Label htmlFor="amount">Amount (₹)</Label>
            {suggestedBalance > 0 && (
              <button
                type="button"
                onClick={fillBalance}
                className="text-xs text-blue-600 hover:underline"
              >
                Balance: {formatCurrency(suggestedBalance)}
              </button>
            )}
          </div>
          <Input
            id="amount"
            type="number"
            min="0.01"
            step="0.01"
            value={amount}
            onChange={e => setAmount(e.target.value)}
            placeholder="0.00"
            required
          />
        </div>

        <div className="space-y-1">
          <Label htmlFor="mode">Payment Mode</Label>
          <Select value={mode} onValueChange={v => setMode(v as PaymentMode)}>
            <SelectTrigger id="mode">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              {MODE_OPTIONS.map(o => (
                <SelectItem key={o.value} value={o.value}>
                  {o.label}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        <div className="space-y-1">
          <Label htmlFor="payment-date">Date</Label>
          <Input
            id="payment-date"
            type="date"
            value={paymentDate}
            onChange={e => setPaymentDate(e.target.value)}
            required
          />
        </div>

        <div className="space-y-1">
          <Label htmlFor="reference">
            Reference{' '}
            <span className="font-normal text-gray-400">(optional)</span>
          </Label>
          <Input
            id="reference"
            value={reference}
            onChange={e => setReference(e.target.value)}
            placeholder="Cheque no., UTR, etc."
          />
        </div>

        <div className="space-y-1">
          <Label htmlFor="remarks">
            Remarks{' '}
            <span className="font-normal text-gray-400">(optional)</span>
          </Label>
          <Input
            id="remarks"
            value={remarks}
            onChange={e => setRemarks(e.target.value)}
          />
        </div>
      </div>

      {error && <p className="text-sm text-red-500">{error}</p>}

      <Button type="submit" disabled={isPending} className="w-full">
        {isPending ? 'Recording…' : 'Record Payment & Print Receipt'}
      </Button>
    </form>
  )
}

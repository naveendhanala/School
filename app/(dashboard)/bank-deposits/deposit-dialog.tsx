'use client'

import { useState, useTransition } from 'react'
import { useRouter } from 'next/navigation'
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { createDeposit } from './actions'

interface DepositDialogProps {
  open: boolean
  onOpenChange: (open: boolean) => void
}

function todayIso(): string {
  return new Date().toISOString().slice(0, 10)
}

const EMPTY_FORM = {
  bankName: '',
  accountNo: '',
  amount: '',
  depositDate: todayIso(),
  reference: '',
  remarks: '',
}

export function DepositDialog({ open, onOpenChange }: DepositDialogProps) {
  const router = useRouter()
  const [isPending, startTransition] = useTransition()
  const [error, setError] = useState<string | null>(null)
  const [form, setForm] = useState(EMPTY_FORM)

  function handleChange(field: keyof typeof form, value: string) {
    setForm(prev => ({ ...prev, [field]: value }))
  }

  function resetForm() {
    setForm({ ...EMPTY_FORM, depositDate: todayIso() })
    setError(null)
  }

  function handleClose() {
    onOpenChange(false)
    resetForm()
  }

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    const parsedAmount = parseFloat(form.amount)
    if (!Number.isFinite(parsedAmount) || parsedAmount <= 0) {
      setError('Amount must be greater than 0')
      return
    }
    setError(null)

    startTransition(async () => {
      const result = await createDeposit({
        bankName: form.bankName.trim(),
        accountNo: form.accountNo.trim(),
        amount: parsedAmount,
        depositDate: form.depositDate,
        reference: form.reference.trim() || null,
        remarks: form.remarks.trim() || null,
      })

      if (result.error) {
        setError(result.error)
        return
      }

      resetForm()
      onOpenChange(false)
      router.refresh()
    })
  }

  return (
    <Dialog open={open} onOpenChange={open => { if (!open) handleClose(); else onOpenChange(true) }}>
      <DialogContent className="max-w-md">
        <DialogHeader>
          <DialogTitle>Add Bank Deposit</DialogTitle>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-1">
            <Label htmlFor="bank-name">Bank Name</Label>
            <Input
              id="bank-name"
              value={form.bankName}
              onChange={e => handleChange('bankName', e.target.value)}
              placeholder="e.g. SBI, Andhra Bank"
              required
            />
          </div>

          <div className="space-y-1">
            <Label htmlFor="account-no">Account Number</Label>
            <Input
              id="account-no"
              value={form.accountNo}
              onChange={e => handleChange('accountNo', e.target.value)}
              placeholder="Account number"
              required
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1">
              <Label htmlFor="amount">Amount (₹)</Label>
              <Input
                id="amount"
                type="number"
                min="0.01"
                step="0.01"
                value={form.amount}
                onChange={e => handleChange('amount', e.target.value)}
                placeholder="0.00"
                required
              />
            </div>
            <div className="space-y-1">
              <Label htmlFor="deposit-date">Date</Label>
              <Input
                id="deposit-date"
                type="date"
                value={form.depositDate}
                onChange={e => handleChange('depositDate', e.target.value)}
                required
              />
            </div>
          </div>

          <div className="space-y-1">
            <Label htmlFor="reference">
              Reference <span className="font-normal text-gray-400">(optional)</span>
            </Label>
            <Input
              id="reference"
              value={form.reference}
              onChange={e => handleChange('reference', e.target.value)}
              placeholder="Challan no., UTR, etc."
            />
          </div>

          <div className="space-y-1">
            <Label htmlFor="remarks">
              Remarks <span className="font-normal text-gray-400">(optional)</span>
            </Label>
            <Input
              id="remarks"
              value={form.remarks}
              onChange={e => handleChange('remarks', e.target.value)}
            />
          </div>

          {error && <p className="text-sm text-red-500">{error}</p>}

          <div className="flex gap-3 pt-2">
            <Button type="submit" disabled={isPending} className="flex-1">
              {isPending ? 'Saving…' : 'Add Deposit'}
            </Button>
            <Button
              type="button"
              variant="outline"
              onClick={handleClose}
              disabled={isPending}
            >
              Cancel
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}

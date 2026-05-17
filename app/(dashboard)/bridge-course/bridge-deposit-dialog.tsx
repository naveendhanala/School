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

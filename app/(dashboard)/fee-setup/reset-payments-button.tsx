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
import { toast } from 'sonner'

interface ResetPaymentsButtonProps {
  activeYearId: string
  activeYearLabel: string
}

export function ResetPaymentsButton({ activeYearId, activeYearLabel }: ResetPaymentsButtonProps) {
  const router = useRouter()
  const [isPending, startTransition] = useTransition()
  const [open, setOpen] = useState(false)
  const [confirmText, setConfirmText] = useState('')
  const [error, setError] = useState<string | null>(null)

  function handleClose() {
    setOpen(false)
    setConfirmText('')
    setError(null)
  }

  function handleConfirm() {
    if (confirmText !== activeYearLabel) return
    setError(null)
    startTransition(async () => {
      const result = await resetActiveYearPayments(activeYearId)
      if (result.error) { setError(result.error); return }
      toast.success(`All payment data reset for ${activeYearLabel}`)
      handleClose()
      router.refresh()
    })
  }

  return (
    <>
      <Button
        variant="outline"
        className="border-red-200 text-red-600 hover:bg-red-50 hover:text-red-700"
        onClick={() => setOpen(true)}
      >
        Reset All Payments
      </Button>

      <Dialog open={open} onOpenChange={o => { if (!o) handleClose() }}>
        <DialogContent className="max-w-md">
          <DialogHeader>
            <DialogTitle className="text-red-600">Reset Active Year Data</DialogTitle>
          </DialogHeader>
          <div className="space-y-4">
            <p className="text-sm text-gray-600">
              This will permanently delete all payments, deposits, and bridge course records for{' '}
              <span className="font-semibold">{activeYearLabel}</span>. Student and enrollment
              records are preserved.
            </p>
            <p className="text-sm font-medium text-red-600">This action cannot be undone.</p>
            <div className="space-y-1">
              <Label htmlFor="confirm-label">
                Type <span className="font-mono font-semibold">{activeYearLabel}</span> to confirm
              </Label>
              <Input
                id="confirm-label"
                value={confirmText}
                onChange={e => setConfirmText(e.target.value)}
                placeholder={activeYearLabel}
                autoComplete="off"
              />
            </div>

            {error && <p className="text-sm text-red-500">{error}</p>}

            <div className="flex gap-3">
              <Button
                className="flex-1 bg-red-600 hover:bg-red-700"
                onClick={handleConfirm}
                disabled={confirmText !== activeYearLabel || isPending}
              >
                {isPending ? 'Resetting…' : 'Confirm Reset'}
              </Button>
              <Button variant="outline" onClick={handleClose} disabled={isPending}>
                Cancel
              </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </>
  )
}

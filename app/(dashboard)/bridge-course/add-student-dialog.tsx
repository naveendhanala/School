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

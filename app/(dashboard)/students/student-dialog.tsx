'use client'

import { useState, useTransition } from 'react'
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog'
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
import { createStudent, updateStudent } from './actions'
import type { Gender } from '@/lib/types'

interface EditData {
  studentId: string
  enrollmentId: string
  name: string
  gender: Gender
  village: string | null
  mobile: string | null
  classId: string
  routeId: string | null
  admNo: string
}

interface Props {
  open: boolean
  onClose: () => void
  classes: { id: string; name: string }[]
  routes: { id: string; name: string }[]
  suggestedAdmNo: string
  editData?: EditData
}

interface FormState {
  admNo: string
  name: string
  gender: Gender | ''
  village: string
  mobile: string
  classId: string
  routeId: string
}

function initialForm(editData?: EditData): FormState {
  return {
    admNo: editData?.admNo ?? '',
    name: editData?.name ?? '',
    gender: editData?.gender ?? '',
    village: editData?.village ?? '',
    mobile: editData?.mobile ?? '',
    classId: editData?.classId ?? '',
    routeId: editData?.routeId ?? '',
  }
}

export function StudentDialog({ open, onClose, classes, routes, suggestedAdmNo, editData }: Props) {
  const isEdit = Boolean(editData)
  const [form, setForm] = useState<FormState>(() => initialForm(editData))
  const [error, setError] = useState<string | null>(null)
  const [isPending, startTransition] = useTransition()

  // Reset form when editData changes (dialog re-opened for different student)
  const [prevEdit, setPrevEdit] = useState(editData)
  if (prevEdit !== editData) {
    setPrevEdit(editData)
    setForm(initialForm(editData))
    setError(null)
  }

  const set = <K extends keyof FormState>(key: K, value: FormState[K]) =>
    setForm(f => ({ ...f, [key]: value }))

  const handleSubmit = () => {
    if (!form.name.trim()) { setError('Name is required.'); return }
    if (!form.gender) { setError('Gender is required.'); return }
    if (!form.classId) { setError('Class is required.'); return }
    setError(null)

    startTransition(async () => {
      try {
        if (isEdit && editData) {
          await updateStudent(editData.studentId, editData.enrollmentId, {
            name: form.name.trim(),
            gender: form.gender as Gender,
            village: form.village.trim(),
            mobile: form.mobile.trim(),
            classId: form.classId,
            routeId: form.routeId || null,
          })
        } else {
          await createStudent({
            name: form.name.trim(),
            gender: form.gender as Gender,
            village: form.village.trim(),
            mobile: form.mobile.trim(),
            classId: form.classId,
            routeId: form.routeId || null,
            admNo: form.admNo.trim(),
          })
        }
        onClose()
      } catch (e) {
        setError(e instanceof Error ? e.message : 'Failed to save student.')
      }
    })
  }

  return (
    <Dialog open={open} onOpenChange={v => { if (!v) onClose() }}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>{isEdit ? 'Edit Student' : 'Add Student'}</DialogTitle>
        </DialogHeader>
        <div className="space-y-4 pt-2">
          {!isEdit && (
            <div>
              <Label className="text-sm">
                Adm No <span className="text-gray-400 font-normal">(blank = auto: {suggestedAdmNo})</span>
              </Label>
              <Input
                value={form.admNo}
                onChange={e => set('admNo', e.target.value)}
                placeholder={suggestedAdmNo}
              />
            </div>
          )}

          <div>
            <Label className="text-sm">Name *</Label>
            <Input
              value={form.name}
              onChange={e => set('name', e.target.value)}
              placeholder="Student name"
            />
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <Label className="text-sm">Gender *</Label>
              <Select value={form.gender} onValueChange={v => set('gender', v as Gender)}>
                <SelectTrigger>
                  <SelectValue placeholder="Select" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="male">Male</SelectItem>
                  <SelectItem value="female">Female</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div>
              <Label className="text-sm">Class *</Label>
              <Select value={form.classId} onValueChange={v => set('classId', v)}>
                <SelectTrigger>
                  <SelectValue placeholder="Select" />
                </SelectTrigger>
                <SelectContent>
                  {classes.map(c => (
                    <SelectItem key={c.id} value={c.id}>{c.name}</SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          </div>

          <div>
            <Label className="text-sm">Transport Route</Label>
            <Select value={form.routeId} onValueChange={v => set('routeId', v)}>
              <SelectTrigger>
                <SelectValue placeholder="None (own transport)" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="">None</SelectItem>
                {routes.map(r => (
                  <SelectItem key={r.id} value={r.id}>{r.name}</SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <Label className="text-sm">Village</Label>
              <Input
                value={form.village}
                onChange={e => set('village', e.target.value)}
                placeholder="Village name"
              />
            </div>
            <div>
              <Label className="text-sm">Mobile</Label>
              <Input
                value={form.mobile}
                onChange={e => set('mobile', e.target.value)}
                placeholder="Parent contact"
              />
            </div>
          </div>

          {error && (
            <p className="text-sm text-red-600">{error}</p>
          )}

          <div className="flex gap-2 justify-end pt-2">
            <Button variant="outline" onClick={onClose} disabled={isPending}>
              Cancel
            </Button>
            <Button onClick={handleSubmit} disabled={isPending}>
              {isPending ? 'Saving…' : isEdit ? 'Update' : 'Add Student'}
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  )
}

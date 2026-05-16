'use client'

import { useState, useTransition } from 'react'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'
import { upsertClassFee } from './actions'

interface Props {
  classId: string
  className: string
  academicYearId: string
  tuition: number
  book: number
}

export function ClassFeeRow({ classId, className, academicYearId, tuition, book }: Props) {
  const [tuitionVal, setTuitionVal] = useState(String(tuition))
  const [bookVal, setBookVal] = useState(String(book))
  const [isPending, startTransition] = useTransition()
  const [saved, setSaved] = useState(false)

  const handleSave = () => {
    startTransition(async () => {
      await upsertClassFee(academicYearId, classId, 'tuition', parseFloat(tuitionVal) || 0)
      await upsertClassFee(academicYearId, classId, 'book', parseFloat(bookVal) || 0)
      setSaved(true)
      setTimeout(() => setSaved(false), 2000)
    })
  }

  return (
    <tr className="border-b">
      <td className="px-3 py-2 font-medium">{className}</td>
      <td className="px-3 py-2">
        <Input
          type="number"
          min="0"
          value={tuitionVal}
          onChange={e => { setTuitionVal(e.target.value); setSaved(false) }}
          className="w-32 h-8 text-sm"
        />
      </td>
      <td className="px-3 py-2">
        <Input
          type="number"
          min="0"
          value={bookVal}
          onChange={e => { setBookVal(e.target.value); setSaved(false) }}
          className="w-32 h-8 text-sm"
        />
      </td>
      <td className="px-3 py-2">
        <Button size="sm" onClick={handleSave} disabled={isPending}>
          {isPending ? 'Saving…' : saved ? 'Saved ✓' : 'Save'}
        </Button>
      </td>
    </tr>
  )
}

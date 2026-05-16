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
  const [error, setError] = useState<string | null>(null)

  const handleSave = () => {
    const parsedTuition = parseFloat(tuitionVal)
    const parsedBook = parseFloat(bookVal)

    if (isNaN(parsedTuition) || parsedTuition < 0) {
      setError('Tuition fee must be a valid non-negative number.')
      return
    }
    if (isNaN(parsedBook) || parsedBook < 0) {
      setError('Book fee must be a valid non-negative number.')
      return
    }

    startTransition(async () => {
      try {
        await upsertClassFee(academicYearId, classId, 'tuition', parsedTuition)
        await upsertClassFee(academicYearId, classId, 'book', parsedBook)
        setError(null)
        setSaved(true)
        setTimeout(() => setSaved(false), 2000)
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to save fees. Please try again.')
      }
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
          onChange={e => { setTuitionVal(e.target.value); setSaved(false); setError(null) }}
          className="w-32 h-8 text-sm"
          aria-label="Tuition fee"
        />
      </td>
      <td className="px-3 py-2">
        <Input
          type="number"
          min="0"
          value={bookVal}
          onChange={e => { setBookVal(e.target.value); setSaved(false); setError(null) }}
          className="w-32 h-8 text-sm"
          aria-label="Book fee"
        />
      </td>
      <td className="px-3 py-2">
        <Button size="sm" onClick={handleSave} disabled={isPending}>
          {isPending ? 'Saving…' : saved ? 'Saved ✓' : 'Save'}
        </Button>
        {error !== null && (
          <p className="text-xs text-red-600 mt-1">{error}</p>
        )}
      </td>
    </tr>
  )
}

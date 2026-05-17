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

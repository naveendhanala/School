'use client'

import { useTransition } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { setActiveYear } from './actions'

interface AcademicYearRowProps {
  id: string
  label: string
  isActive: boolean
}

export function AcademicYearRow({ id, label, isActive }: AcademicYearRowProps) {
  const [isPending, startTransition] = useTransition()
  const router = useRouter()

  function handleSetActive() {
    startTransition(async () => {
      await setActiveYear(id)
      router.refresh()
    })
  }

  return (
    <div className="flex items-center justify-between rounded-lg border bg-white px-4 py-3">
      <div className="flex items-center gap-3">
        <span className="font-medium">{label}</span>
        {isActive && (
          <span className="rounded-full bg-green-100 px-2 py-0.5 text-xs font-medium text-green-700">
            Active
          </span>
        )}
      </div>
      {!isActive && (
        <Button variant="outline" size="sm" onClick={handleSetActive} disabled={isPending}>
          {isPending ? 'Setting…' : 'Set Active'}
        </Button>
      )}
    </div>
  )
}

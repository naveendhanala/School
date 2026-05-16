'use client'

import { useState, useTransition } from 'react'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'
import { upsertTransportRoute, deleteTransportRoute } from './actions'

interface Props {
  id: string
  name: string
  feeAmount: number
}

export function TransportRouteRow({ id, name, feeAmount }: Props) {
  const [nameVal, setNameVal] = useState(name)
  const [feeVal, setFeeVal] = useState(String(feeAmount))
  const [isPending, startTransition] = useTransition()
  const [saved, setSaved] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const handleSave = () => {
    if (!nameVal.trim()) {
      setError('Route name cannot be empty.')
      return
    }
    const parsedFee = parseFloat(feeVal)
    if (isNaN(parsedFee) || parsedFee < 0) {
      setError('Enter a valid non-negative fee amount.')
      return
    }
    setError(null)
    startTransition(async () => {
      try {
        await upsertTransportRoute(id, nameVal.trim(), parsedFee)
        setSaved(true)
        setTimeout(() => setSaved(false), 2000)
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to save route.')
      }
    })
  }

  const handleDelete = () => {
    if (!confirm(`Delete route "${nameVal}"? This cannot be undone.`)) return
    startTransition(async () => {
      try {
        await deleteTransportRoute(id)
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to delete route.')
      }
    })
  }

  return (
    <tr className="border-b">
      <td className="px-3 py-2">
        <Input
          aria-label="Route name"
          value={nameVal}
          onChange={e => { setNameVal(e.target.value); setSaved(false); setError(null) }}
          className="w-36 h-8 text-sm"
        />
      </td>
      <td className="px-3 py-2">
        <Input
          aria-label="Annual fee"
          type="number"
          min="0"
          value={feeVal}
          onChange={e => { setFeeVal(e.target.value); setSaved(false); setError(null) }}
          className="w-32 h-8 text-sm"
        />
      </td>
      <td className="px-3 py-2">
        <div className="flex gap-2 items-center">
          <Button size="sm" onClick={handleSave} disabled={isPending}>
            {isPending ? '…' : saved ? 'Saved ✓' : 'Save'}
          </Button>
          <Button size="sm" variant="destructive" onClick={handleDelete} disabled={isPending}>
            Delete
          </Button>
        </div>
        {error && <p className="text-xs text-red-600 mt-1">{error}</p>}
      </td>
    </tr>
  )
}

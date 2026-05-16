'use client'

import { useState, useTransition } from 'react'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'
import { Label } from '@/components/ui/label'
import { upsertTransportRoute } from './actions'

export function AddRouteForm() {
  const [name, setName] = useState('')
  const [fee, setFee] = useState('')
  const [isPending, startTransition] = useTransition()
  const [error, setError] = useState<string | null>(null)

  const handleAdd = () => {
    if (!name.trim()) {
      setError('Route name is required.')
      return
    }
    const parsedFee = parseFloat(fee) || 0
    if (fee.trim() !== '' && (isNaN(parseFloat(fee)) || parseFloat(fee) < 0)) {
      setError('Enter a valid non-negative fee amount.')
      return
    }
    setError(null)
    startTransition(async () => {
      try {
        await upsertTransportRoute(null, name.trim(), parsedFee)
        setName('')
        setFee('')
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to add route.')
      }
    })
  }

  return (
    <div className="space-y-3">
      <div className="flex gap-3 items-end">
        <div>
          <Label htmlFor="route-name" className="text-sm mb-1 block">Route Name</Label>
          <Input
            id="route-name"
            value={name}
            onChange={e => { setName(e.target.value); setError(null) }}
            placeholder="e.g. BUS-A"
            className="w-40"
          />
        </div>
        <div>
          <Label htmlFor="route-fee" className="text-sm mb-1 block">Annual Fee (₹)</Label>
          <Input
            id="route-fee"
            type="number"
            min="0"
            value={fee}
            onChange={e => { setFee(e.target.value); setError(null) }}
            placeholder="0"
            className="w-32"
          />
        </div>
        <Button onClick={handleAdd} disabled={isPending || !name.trim()}>
          {isPending ? 'Adding…' : 'Add Route'}
        </Button>
      </div>
      {error && <p className="text-sm text-red-600">{error}</p>}
    </div>
  )
}

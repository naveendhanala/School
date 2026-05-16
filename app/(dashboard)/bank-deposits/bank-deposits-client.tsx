'use client'

import { useMemo, useState, useTransition } from 'react'
import { useRouter } from 'next/navigation'
import { toCsv } from '@/lib/utils/csv'
import { formatCurrency } from '@/lib/utils/currency'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Download, Plus, Trash2 } from 'lucide-react'
import { deleteDeposit } from './actions'
import { DepositDialog } from './deposit-dialog'
import type { DepositRow } from './page'

interface BankDepositsClientProps {
  deposits: DepositRow[]
  activeYearLabel: string
}

export function BankDepositsClient({ deposits, activeYearLabel }: BankDepositsClientProps) {
  const router = useRouter()
  const [isPending, startTransition] = useTransition()
  const [dialogOpen, setDialogOpen] = useState(false)
  const [fromDate, setFromDate] = useState('')
  const [toDate, setToDate] = useState('')
  const [deletingId, setDeletingId] = useState<string | null>(null)

  const filtered = useMemo(() => {
    return deposits.filter(d => {
      if (fromDate && d.depositDate < fromDate) return false
      if (toDate && d.depositDate > toDate) return false
      return true
    })
  }, [deposits, fromDate, toDate])

  const totalDeposited = filtered.reduce((s, d) => s + d.amount, 0)

  const bankSummary = useMemo(() => {
    const map = new Map<string, number>()
    for (const d of filtered) {
      map.set(d.bankName, (map.get(d.bankName) ?? 0) + d.amount)
    }
    return Array.from(map.entries())
      .sort((a, b) => b[1] - a[1])
      .map(([name, total]) => ({ name, total }))
  }, [filtered])

  function handleDelete(id: string, bankName: string) {
    if (!window.confirm(`Delete deposit from ${bankName}? This cannot be undone.`)) return
    setDeletingId(id)
    startTransition(async () => {
      const result = await deleteDeposit(id)
      setDeletingId(null)
      if (result.error) {
        alert(`Delete failed: ${result.error}`)
        return
      }
      router.refresh()
    })
  }

  function handleExport() {
    const csv = toCsv(
      ['Date', 'Bank', 'Account No', 'Amount', 'Reference', 'Remarks'],
      filtered.map(d => [
        d.depositDate,
        d.bankName,
        d.accountNo,
        d.amount,
        d.reference ?? '',
        d.remarks ?? '',
      ])
    )
    const blob = new Blob([csv], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `bank-deposits-${activeYearLabel}.csv`
    a.click()
    URL.revokeObjectURL(url)
  }

  return (
    <div className="space-y-6 p-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Bank Deposits</h1>
          <p className="mt-1 text-sm text-gray-500">Academic Year: {activeYearLabel}</p>
        </div>
        <Button onClick={() => setDialogOpen(true)} className="gap-2">
          <Plus className="h-4 w-4" />
          Add Deposit
        </Button>
      </div>

      {/* Summary cards */}
      <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
        <div className="rounded-lg border bg-white p-4">
          <p className="text-sm text-gray-500">Total Deposited</p>
          <p className="mt-1 text-2xl font-bold text-green-600">{formatCurrency(totalDeposited)}</p>
        </div>
        <div className="rounded-lg border bg-white p-4">
          <p className="text-sm text-gray-500">Entries</p>
          <p className="mt-1 text-2xl font-bold text-blue-600">{filtered.length}</p>
        </div>
        {bankSummary.slice(0, 2).map(b => (
          <div key={b.name} className="rounded-lg border bg-white p-4">
            <p className="truncate text-sm text-gray-500">{b.name}</p>
            <p className="mt-1 text-2xl font-bold text-indigo-600">{formatCurrency(b.total)}</p>
          </div>
        ))}
      </div>

      {/* Filters + export */}
      <div className="flex flex-wrap items-end gap-3">
        <div className="space-y-1">
          <Label htmlFor="from-date" className="text-xs text-gray-500">From</Label>
          <Input
            id="from-date"
            type="date"
            value={fromDate}
            onChange={e => setFromDate(e.target.value)}
            className="w-40"
          />
        </div>
        <div className="space-y-1">
          <Label htmlFor="to-date" className="text-xs text-gray-500">To</Label>
          <Input
            id="to-date"
            type="date"
            value={toDate}
            onChange={e => setToDate(e.target.value)}
            className="w-40"
          />
        </div>
        {(fromDate || toDate) && (
          <Button
            variant="ghost"
            size="sm"
            onClick={() => { setFromDate(''); setToDate('') }}
          >
            Clear
          </Button>
        )}
        <Button
          variant="outline"
          size="sm"
          onClick={handleExport}
          className="ml-auto gap-2"
          disabled={filtered.length === 0}
        >
          <Download className="h-4 w-4" />
          Export CSV
        </Button>
      </div>

      {/* Deposits table */}
      {filtered.length === 0 ? (
        <p className="text-sm text-gray-500">No deposits found.</p>
      ) : (
        <div className="overflow-x-auto rounded-lg border bg-white">
          <table className="min-w-full text-sm">
            <thead className="bg-gray-50 text-gray-600">
              <tr>
                <th scope="col" className="px-4 py-3 text-left font-medium">Date</th>
                <th scope="col" className="px-4 py-3 text-left font-medium">Bank</th>
                <th scope="col" className="px-4 py-3 text-left font-medium">Account No</th>
                <th scope="col" className="px-4 py-3 text-right font-medium">Amount</th>
                <th scope="col" className="px-4 py-3 text-left font-medium">Reference</th>
                <th scope="col" className="px-4 py-3 text-left font-medium">Remarks</th>
                <th scope="col" className="px-4 py-3" />
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {filtered.map(d => (
                <tr key={d.id} className="hover:bg-gray-50">
                  <td className="px-4 py-3 tabular-nums">{d.depositDate}</td>
                  <td className="px-4 py-3 font-medium">{d.bankName}</td>
                  <td className="px-4 py-3 font-mono text-xs text-gray-600">{d.accountNo}</td>
                  <td className="px-4 py-3 text-right font-semibold text-green-600">
                    {formatCurrency(d.amount)}
                  </td>
                  <td className="px-4 py-3 text-gray-500">{d.reference ?? '—'}</td>
                  <td className="px-4 py-3 text-gray-500">{d.remarks ?? '—'}</td>
                  <td className="px-4 py-3 text-right">
                    <button
                      onClick={() => handleDelete(d.id, d.bankName)}
                      disabled={isPending && deletingId === d.id}
                      className="rounded p-1 text-gray-400 hover:bg-red-50 hover:text-red-600 disabled:opacity-40"
                      aria-label="Delete deposit"
                    >
                      <Trash2 className="h-4 w-4" />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      <DepositDialog open={dialogOpen} onOpenChange={setDialogOpen} />
    </div>
  )
}

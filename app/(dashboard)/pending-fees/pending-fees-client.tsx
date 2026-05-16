'use client'

import { useMemo, useState } from 'react'
import { toCsv } from '@/lib/utils/csv'
import { formatCurrency } from '@/lib/utils/currency'
import { Button } from '@/components/ui/button'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { Download } from 'lucide-react'
import type { PendingRow } from './page'

type SortKey = 'balance_desc' | 'balance_asc' | 'name_asc'

interface PendingFeesClientProps {
  rows: PendingRow[]
  classes: { id: string; name: string }[]
  routes: { id: string; name: string }[]
  activeYearLabel: string
}

export function PendingFeesClient({
  rows,
  classes,
  routes,
  activeYearLabel,
}: PendingFeesClientProps) {
  const [classFilter, setClassFilter] = useState('all')
  const [routeFilter, setRouteFilter] = useState('all')
  const [sort, setSort] = useState<SortKey>('balance_desc')

  const filtered = useMemo(() => {
    let result = rows
    if (classFilter !== 'all') result = result.filter(r => r.classId === classFilter)
    if (routeFilter === 'none') result = result.filter(r => r.routeId === null)
    else if (routeFilter !== 'all') result = result.filter(r => r.routeId === routeFilter)

    return [...result].sort((a, b) => {
      if (sort === 'balance_desc') return b.balance - a.balance
      if (sort === 'balance_asc') return a.balance - b.balance
      return a.name.localeCompare(b.name)
    })
  }, [rows, classFilter, routeFilter, sort])

  const totalPending = filtered.reduce((s, r) => s + r.balance, 0)

  function handleExport() {
    const csv = toCsv(
      ['Adm No', 'Name', 'Class', 'Route', 'Total Fee', 'Paid', 'Balance'],
      filtered.map(r => [
        r.admNo,
        r.name,
        r.className,
        r.routeName ?? '',
        r.totalFee,
        r.totalPaid,
        r.balance,
      ])
    )
    const blob = new Blob([csv], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `pending-fees-${activeYearLabel}.csv`
    a.click()
    URL.revokeObjectURL(url)
  }

  return (
    <div className="space-y-6 p-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Pending Fees</h1>
        <p className="mt-1 text-sm text-gray-500">Academic Year: {activeYearLabel}</p>
      </div>

      {/* Stat cards */}
      <div className="grid max-w-md grid-cols-2 gap-4">
        <div className="rounded-lg border bg-white p-4">
          <p className="text-sm text-gray-500">Students Pending</p>
          <p className="mt-1 text-2xl font-bold text-red-600">{filtered.length}</p>
        </div>
        <div className="rounded-lg border bg-white p-4">
          <p className="text-sm text-gray-500">Total Outstanding</p>
          <p className="mt-1 text-2xl font-bold text-red-600">{formatCurrency(totalPending)}</p>
        </div>
      </div>

      {/* Filters + export */}
      <div className="flex flex-wrap items-center gap-3">
        <Select value={classFilter} onValueChange={setClassFilter}>
          <SelectTrigger className="w-36">
            <SelectValue placeholder="All classes" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Classes</SelectItem>
            {classes.map(c => (
              <SelectItem key={c.id} value={c.id}>
                {c.name}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        <Select value={routeFilter} onValueChange={setRouteFilter}>
          <SelectTrigger className="w-40">
            <SelectValue placeholder="All routes" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Routes</SelectItem>
            <SelectItem value="none">No Route</SelectItem>
            {routes.map(r => (
              <SelectItem key={r.id} value={r.id}>
                {r.name}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        <Select value={sort} onValueChange={v => setSort(v as SortKey)}>
          <SelectTrigger className="w-48">
            <SelectValue />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="balance_desc">Balance: High to Low</SelectItem>
            <SelectItem value="balance_asc">Balance: Low to High</SelectItem>
            <SelectItem value="name_asc">Name: A to Z</SelectItem>
          </SelectContent>
        </Select>

        <Button variant="outline" size="sm" onClick={handleExport} className="ml-auto gap-2">
          <Download className="h-4 w-4" />
          Export CSV
        </Button>
      </div>

      {/* Table */}
      {filtered.length === 0 ? (
        <p className="text-sm text-gray-500">No students with outstanding balance.</p>
      ) : (
        <div className="overflow-x-auto rounded-lg border bg-white">
          <table className="min-w-full text-sm">
            <thead className="bg-gray-50 text-gray-600">
              <tr>
                <th scope="col" className="px-4 py-3 text-left font-medium">Name</th>
                <th scope="col" className="px-4 py-3 text-left font-medium">Adm No</th>
                <th scope="col" className="px-4 py-3 text-left font-medium">Class</th>
                <th scope="col" className="px-4 py-3 text-left font-medium">Route</th>
                <th scope="col" className="px-4 py-3 text-right font-medium">Total Fee</th>
                <th scope="col" className="px-4 py-3 text-right font-medium">Paid</th>
                <th scope="col" className="px-4 py-3 text-right font-medium">Balance</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {filtered.map(row => (
                <tr key={row.enrollmentId} className="hover:bg-gray-50">
                  <td className="px-4 py-3 font-medium">{row.name}</td>
                  <td className="px-4 py-3 text-gray-500">{row.admNo}</td>
                  <td className="px-4 py-3">{row.className}</td>
                  <td className="px-4 py-3 text-gray-500">{row.routeName ?? '—'}</td>
                  <td className="px-4 py-3 text-right">{formatCurrency(row.totalFee)}</td>
                  <td className="px-4 py-3 text-right text-green-600">{formatCurrency(row.totalPaid)}</td>
                  <td className="px-4 py-3 text-right font-semibold text-red-600">
                    {formatCurrency(row.balance)}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  )
}

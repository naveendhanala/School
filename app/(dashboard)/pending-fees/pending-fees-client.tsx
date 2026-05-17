'use client'

import { useMemo, useState } from 'react'
import { toCsv } from '@/lib/utils/csv'
import { formatCurrency } from '@/lib/utils/currency'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { Download, Printer } from 'lucide-react'
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
  const [search, setSearch] = useState('')
  const [classFilter, setClassFilter] = useState('all')
  const [routeFilter, setRouteFilter] = useState('all')
  const [sort, setSort] = useState<SortKey>('balance_desc')

  const filtered = useMemo(() => {
    let result = rows
    if (search.trim()) {
      const q = search.trim().toLowerCase()
      result = result.filter(r =>
        r.name.toLowerCase().includes(q) || r.admNo.toLowerCase().includes(q)
      )
    }
    if (classFilter !== 'all') result = result.filter(r => r.classId === classFilter)
    if (routeFilter === 'none') result = result.filter(r => r.routeId === null)
    else if (routeFilter !== 'all') result = result.filter(r => r.routeId === routeFilter)

    return [...result].sort((a, b) => {
      if (sort === 'balance_desc') return b.balance - a.balance
      if (sort === 'balance_asc') return a.balance - b.balance
      return a.name.localeCompare(b.name)
    })
  }, [rows, search, classFilter, routeFilter, sort])

  const totalPending = filtered.reduce((s, r) => s + r.balance, 0)

  function handleExport() {
    const csv = toCsv(
      ['Adm No', 'Name', 'Class', 'Route', 'Mobile', 'Village', 'Total Fee', 'Paid', 'Balance'],
      filtered.map(r => [
        r.admNo,
        r.name,
        r.className,
        r.routeName ?? '',
        r.mobile ?? '',
        r.village ?? '',
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
    <>
      <style>{`@media print { .no-print { display: none !important; } }`}</style>

      <div className="space-y-6 p-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Pending Fees</h1>
          <p className="mt-1 text-sm text-gray-500">Academic Year: {activeYearLabel}</p>
        </div>

        {/* Stat cards */}
        <div className="no-print grid max-w-md grid-cols-2 gap-4">
          <div className="rounded-lg border bg-white p-4">
            <p className="text-sm text-gray-500">Students Pending</p>
            <p className="mt-1 text-2xl font-bold text-red-600">{filtered.length}</p>
          </div>
          <div className="rounded-lg border bg-white p-4">
            <p className="text-sm text-gray-500">Total Outstanding</p>
            <p className="mt-1 text-2xl font-bold text-red-600">{formatCurrency(totalPending)}</p>
          </div>
        </div>

        {/* Filters + export + print */}
        <div className="no-print flex flex-wrap items-center gap-3">
          <Input
            placeholder="Search name or adm no…"
            value={search}
            onChange={e => setSearch(e.target.value)}
            className="w-52"
          />

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

          <div className="ml-auto flex gap-2">
            <Button variant="outline" size="sm" onClick={() => window.print()} className="gap-2">
              <Printer className="h-4 w-4" />
              Print
            </Button>
            <Button variant="outline" size="sm" onClick={handleExport} className="gap-2">
              <Download className="h-4 w-4" />
              Export CSV
            </Button>
          </div>
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
                  <th scope="col" className="px-4 py-3 text-left font-medium">Mobile</th>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Village</th>
                  <th scope="col" className="px-4 py-3 text-right font-medium">Total Fee</th>
                  <th scope="col" className="px-4 py-3 text-right font-medium">Paid</th>
                  <th scope="col" className="px-4 py-3 text-right font-medium">Balance</th>
                  <th scope="col" className="px-4 py-3 no-print" />
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {filtered.map(row => (
                  <tr key={row.enrollmentId} className="hover:bg-gray-50">
                    <td className="px-4 py-3 font-medium">{row.name}</td>
                    <td className="px-4 py-3 text-gray-500">{row.admNo}</td>
                    <td className="px-4 py-3">{row.className}</td>
                    <td className="px-4 py-3 text-gray-500">{row.routeName ?? '—'}</td>
                    <td className="px-4 py-3 text-gray-500">{row.mobile ?? '—'}</td>
                    <td className="px-4 py-3 text-gray-500">{row.village ?? '—'}</td>
                    <td className="px-4 py-3 text-right">{formatCurrency(row.totalFee)}</td>
                    <td className="px-4 py-3 text-right text-green-600">{formatCurrency(row.totalPaid)}</td>
                    <td className="px-4 py-3 text-right font-semibold text-red-600">
                      {formatCurrency(row.balance)}
                    </td>
                    {row.mobile ? (
                      <td className="px-4 py-3 no-print">
                        <a
                          href={`https://wa.me/91${row.mobile.replace(/\D/g, '')}?text=${encodeURIComponent(`Hi, this is a reminder that ${row.name}'s school fee balance is ₹${row.balance.toLocaleString('en-IN')}. Please arrange payment at the earliest. Thank you.`)}`}
                          target="_blank"
                          rel="noreferrer"
                          className="inline-flex items-center gap-1 rounded-md border border-green-300 bg-green-50 px-2 py-1 text-xs font-medium text-green-700 hover:bg-green-100"
                        >
                          WhatsApp
                        </a>
                      </td>
                    ) : (
                      <td className="px-4 py-3 no-print" />
                    )}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </>
  )
}

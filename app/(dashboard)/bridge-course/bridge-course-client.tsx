'use client'

import { useMemo, useState, useTransition } from 'react'
import { useUser } from '@/lib/user-context'
import { useRouter } from 'next/navigation'
import { toCsv } from '@/lib/utils/csv'
import { formatCurrency } from '@/lib/utils/currency'
import { Button } from '@/components/ui/button'
import {
  Select, SelectContent, SelectItem, SelectTrigger, SelectValue,
} from '@/components/ui/select'
import { Download, Plus, Trash2 } from 'lucide-react'
import { deleteBridgeStudent, deleteBridgeDeposit } from './actions'
import { AddStudentDialog } from './add-student-dialog'
import { PaymentDialog } from './payment-dialog'
import { BridgeDepositDialog } from './bridge-deposit-dialog'
import type { BridgeStudentRow, BridgeDepositRow } from './page'

interface BridgeCourseClientProps {
  students: BridgeStudentRow[]
  deposits: BridgeDepositRow[]
  activeYearLabel: string
}

const STATUS_BADGE: Record<string, string> = {
  paid: 'bg-green-100 text-green-700',
  partial: 'bg-amber-100 text-amber-700',
  unpaid: 'bg-red-100 text-red-700',
}
const STATUS_LABEL: Record<string, string> = {
  paid: 'Paid', partial: 'Partial', unpaid: 'Unpaid',
}

type PaymentTarget = { id: string; name: string } | null

export function BridgeCourseClient({
  students,
  deposits,
  activeYearLabel,
}: BridgeCourseClientProps) {
  const router = useRouter()
  const [isPending, startTransition] = useTransition()
  const [addStudentOpen, setAddStudentOpen] = useState(false)
  const [depositDialogOpen, setDepositDialogOpen] = useState(false)
  const [paymentTarget, setPaymentTarget] = useState<PaymentTarget>(null)
  const [courseFilter, setCourseFilter] = useState('all')
  const [statusFilter, setStatusFilter] = useState('all')
  const [deletingId, setDeletingId] = useState<string | null>(null)
  const [deletingDepositId, setDeletingDepositId] = useState<string | null>(null)
  const { role } = useUser()
  const canWrite = role !== 'cashier'

  const filtered = useMemo(() => {
    return students.filter(s => {
      if (courseFilter !== 'all' && s.course !== courseFilter) return false
      if (statusFilter !== 'all' && s.status !== statusFilter) return false
      return true
    })
  }, [students, courseFilter, statusFilter])

  const totalFee = filtered.reduce((s, r) => s + r.totalFee, 0)
  const totalPaid = filtered.reduce((s, r) => s + r.totalPaid, 0)
  const totalPending = filtered.reduce((s, r) => s + r.balance, 0)
  const totalDeposited = deposits.reduce((s, d) => s + d.amount, 0)

  function handleDeleteStudent(id: string, name: string) {
    if (!window.confirm(`Delete ${name}? This will also delete all their payments.`)) return
    setDeletingId(id)
    startTransition(async () => {
      const result = await deleteBridgeStudent(id)
      setDeletingId(null)
      if (result.error) { alert(`Delete failed: ${result.error}`); return }
      router.refresh()
    })
  }

  function handleDeleteDeposit(id: string) {
    if (!window.confirm('Delete this deposit? This cannot be undone.')) return
    setDeletingDepositId(id)
    startTransition(async () => {
      const result = await deleteBridgeDeposit(id)
      setDeletingDepositId(null)
      if (result.error) { alert(`Delete failed: ${result.error}`); return }
      router.refresh()
    })
  }

  function handleExport() {
    const csv = toCsv(
      ['Voucher', 'Name', 'Course', 'Gender', 'Phone', 'Total Fee', 'Cash', 'PhonePe', 'HDFC', 'Total Paid', 'Balance', 'Status'],
      filtered.map(s => [
        s.voucherNo, s.name, s.course, s.gender, s.phone ?? '',
        s.totalFee, s.cash, s.phonepe, s.hdfc, s.totalPaid, s.balance,
        STATUS_LABEL[s.status],
      ])
    )
    const blob = new Blob([csv], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `bridge-course-${activeYearLabel}.csv`
    a.click()
    URL.revokeObjectURL(url)
  }

  return (
    <div className="space-y-6 p-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Bridge Course</h1>
          <p className="mt-1 text-sm text-gray-500">Academic Year: {activeYearLabel}</p>
        </div>
        {canWrite && (
          <Button onClick={() => setAddStudentOpen(true)} className="gap-2">
            <Plus className="h-4 w-4" />
            Add Student
          </Button>
        )}
      </div>

      {/* Summary cards */}
      <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
        <div className="rounded-lg border bg-white p-4">
          <p className="text-sm text-gray-500">Students</p>
          <p className="mt-1 text-2xl font-bold text-blue-600">{filtered.length}</p>
        </div>
        <div className="rounded-lg border bg-white p-4">
          <p className="text-sm text-gray-500">Total Fee</p>
          <p className="mt-1 text-2xl font-bold text-gray-900">{formatCurrency(totalFee)}</p>
        </div>
        <div className="rounded-lg border bg-white p-4">
          <p className="text-sm text-gray-500">Collected</p>
          <p className="mt-1 text-2xl font-bold text-green-600">{formatCurrency(totalPaid)}</p>
        </div>
        <div className="rounded-lg border bg-white p-4">
          <p className="text-sm text-gray-500">Pending</p>
          <p className="mt-1 text-2xl font-bold text-red-600">{formatCurrency(totalPending)}</p>
        </div>
      </div>

      {/* Filters + export */}
      <div className="flex flex-wrap items-center gap-3">
        <Select value={courseFilter} onValueChange={setCourseFilter}>
          <SelectTrigger className="w-36">
            <SelectValue placeholder="Course" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Courses</SelectItem>
            <SelectItem value="IIT">IIT</SelectItem>
            <SelectItem value="NON-IIT">NON-IIT</SelectItem>
          </SelectContent>
        </Select>

        <Select value={statusFilter} onValueChange={setStatusFilter}>
          <SelectTrigger className="w-32">
            <SelectValue placeholder="Status" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Status</SelectItem>
            <SelectItem value="paid">Paid</SelectItem>
            <SelectItem value="partial">Partial</SelectItem>
            <SelectItem value="unpaid">Unpaid</SelectItem>
          </SelectContent>
        </Select>

        <Button
          variant="outline" size="sm"
          onClick={handleExport}
          disabled={filtered.length === 0}
          className="ml-auto gap-2"
        >
          <Download className="h-4 w-4" />
          Export CSV
        </Button>
      </div>

      {/* Students table */}
      {filtered.length === 0 ? (
        <p className="text-sm text-gray-500">No students found.</p>
      ) : (
        <div className="overflow-x-auto rounded-lg border bg-white">
          <table className="min-w-full text-sm">
            <thead className="bg-gray-50 text-gray-600">
              <tr>
                <th scope="col" className="px-3 py-3 text-left font-medium">Voucher</th>
                <th scope="col" className="px-3 py-3 text-left font-medium">Name</th>
                <th scope="col" className="px-3 py-3 text-left font-medium">Course</th>
                <th scope="col" className="px-3 py-3 text-left font-medium">Phone</th>
                <th scope="col" className="px-3 py-3 text-right font-medium">Fee</th>
                <th scope="col" className="px-3 py-3 text-right font-medium">Cash</th>
                <th scope="col" className="px-3 py-3 text-right font-medium">PhonePe</th>
                <th scope="col" className="px-3 py-3 text-right font-medium">HDFC</th>
                <th scope="col" className="px-3 py-3 text-right font-medium">Balance</th>
                <th scope="col" className="px-3 py-3 text-center font-medium">Status</th>
                <th scope="col" className="px-3 py-3" />
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {filtered.map(s => (
                <tr key={s.id} className="hover:bg-gray-50">
                  <td className="px-3 py-3 font-mono text-xs">{s.voucherNo}</td>
                  <td className="px-3 py-3 font-medium">{s.name}</td>
                  <td className="px-3 py-3">
                    <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${
                      s.course === 'IIT'
                        ? 'bg-purple-100 text-purple-700'
                        : 'bg-blue-100 text-blue-700'
                    }`}>
                      {s.course}
                    </span>
                  </td>
                  <td className="px-3 py-3 text-gray-500">{s.phone ?? '—'}</td>
                  <td className="px-3 py-3 text-right tabular-nums">{formatCurrency(s.totalFee)}</td>
                  <td className="px-3 py-3 text-right tabular-nums text-green-600">
                    {s.cash > 0 ? formatCurrency(s.cash) : '—'}
                  </td>
                  <td className="px-3 py-3 text-right tabular-nums text-green-600">
                    {s.phonepe > 0 ? formatCurrency(s.phonepe) : '—'}
                  </td>
                  <td className="px-3 py-3 text-right tabular-nums text-green-600">
                    {s.hdfc > 0 ? formatCurrency(s.hdfc) : '—'}
                  </td>
                  <td className="px-3 py-3 text-right tabular-nums font-semibold text-red-600">
                    {s.balance > 0 ? formatCurrency(s.balance) : '—'}
                  </td>
                  <td className="px-3 py-3 text-center">
                    <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${STATUS_BADGE[s.status]}`}>
                      {STATUS_LABEL[s.status]}
                    </span>
                  </td>
                  <td className="px-3 py-3 text-right">
                    <div className="flex items-center justify-end gap-1">
                      {canWrite && s.status !== 'paid' && (
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => setPaymentTarget({ id: s.id, name: s.name })}
                          className="h-7 text-xs"
                        >
                          Pay
                        </Button>
                      )}
                      {canWrite && (
                        <button
                          onClick={() => handleDeleteStudent(s.id, s.name)}
                          disabled={isPending && deletingId === s.id}
                          className="rounded p-1 text-gray-400 hover:bg-red-50 hover:text-red-600 disabled:opacity-40"
                          aria-label="Delete student"
                        >
                          <Trash2 className="h-4 w-4" />
                        </button>
                      )}
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {/* Bridge Deposits */}
      <div className="space-y-3">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="font-semibold text-gray-900">Bank Deposits</h2>
            <p className="text-sm text-gray-500">
              Total deposited:{' '}
              <span className="font-medium text-blue-600">{formatCurrency(totalDeposited)}</span>
            </p>
          </div>
          {canWrite && (
            <Button
              variant="outline"
              size="sm"
              onClick={() => setDepositDialogOpen(true)}
              className="gap-2"
            >
              <Plus className="h-4 w-4" />
              Add Deposit
            </Button>
          )}
        </div>

        {deposits.length === 0 ? (
          <p className="text-sm text-gray-500">No deposits recorded.</p>
        ) : (
          <div className="overflow-x-auto rounded-lg border bg-white">
            <table className="min-w-full text-sm">
              <thead className="bg-gray-50 text-gray-600">
                <tr>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Date</th>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Bank</th>
                  <th scope="col" className="px-4 py-3 text-right font-medium">Amount</th>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Reference</th>
                  <th scope="col" className="px-4 py-3" />
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {deposits.map(d => (
                  <tr key={d.id} className="hover:bg-gray-50">
                    <td className="px-4 py-3 tabular-nums">{d.depositDate}</td>
                    <td className="px-4 py-3 font-medium">{d.bankName}</td>
                    <td className="px-4 py-3 text-right font-semibold text-green-600">
                      {formatCurrency(d.amount)}
                    </td>
                    <td className="px-4 py-3 text-gray-500">{d.reference ?? '—'}</td>
                    <td className="px-4 py-3 text-right">
                      {canWrite && (
                        <button
                          onClick={() => handleDeleteDeposit(d.id)}
                          disabled={isPending && deletingDepositId === d.id}
                          className="rounded p-1 text-gray-400 hover:bg-red-50 hover:text-red-600 disabled:opacity-40"
                          aria-label="Delete deposit"
                        >
                          <Trash2 className="h-4 w-4" />
                        </button>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      <AddStudentDialog open={addStudentOpen} onOpenChange={setAddStudentOpen} />
      <PaymentDialog
        open={paymentTarget !== null}
        onOpenChange={open => { if (!open) setPaymentTarget(null) }}
        studentId={paymentTarget?.id ?? ''}
        studentName={paymentTarget?.name ?? ''}
      />
      <BridgeDepositDialog open={depositDialogOpen} onOpenChange={setDepositDialogOpen} />
    </div>
  )
}

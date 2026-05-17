'use client'

import { useMemo, useState } from 'react'
import { toCsv } from '@/lib/utils/csv'
import { formatCurrency } from '@/lib/utils/currency'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Download } from 'lucide-react'
import type {
  ReportsData, MonthStat, ClasswiseRow, TransportwiseRow, ReconciliationRow,
} from './page'

type Tab = 'daily' | 'monthly' | 'reconciliation' | 'classwise' | 'transportwise'

const TABS: { key: Tab; label: string }[] = [
  { key: 'daily', label: 'Daily' },
  { key: 'monthly', label: 'Monthly' },
  { key: 'reconciliation', label: 'Reconciliation' },
  { key: 'classwise', label: 'Class-wise' },
  { key: 'transportwise', label: 'Transport-wise' },
]

const HEAD_LABELS: Record<string, string> = {
  tuition: 'Tuition', book: 'Book', transport: 'Transport',
  hostel: 'Hostel', admission: 'Admission', uniform: 'Uniform',
  exam: 'Exam', other: 'Other',
}
const MODE_LABELS: Record<string, string> = {
  cash: 'Cash', upi: 'UPI', cheque: 'Cheque',
  neft_rtgs: 'NEFT/RTGS', demand_draft: 'DD',
}

function downloadCsv(csv: string, filename: string) {
  const blob = new Blob([csv], { type: 'text/csv' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = filename
  a.click()
  URL.revokeObjectURL(url)
}

export function ReportsClient({ data }: { data: ReportsData }) {
  const [tab, setTab] = useState<Tab>('daily')
  const [dailyDate, setDailyDate] = useState(new Date().toISOString().slice(0, 10))

  const dailyPayments = useMemo(
    () => data.payments.filter(p => p.paymentDate === dailyDate),
    [data.payments, dailyDate]
  )
  const dailyTotal = dailyPayments.reduce((s, p) => s + p.amount, 0)

  function exportDaily() {
    downloadCsv(
      toCsv(
        ['Receipt No', 'Student', 'Adm No', 'Class', 'Fee Head', 'Mode', 'Amount', 'Reference'],
        dailyPayments.map(p => [
          p.receiptNo, p.studentName, p.admNo, p.className,
          HEAD_LABELS[p.feeHead] ?? p.feeHead,
          MODE_LABELS[p.mode] ?? p.mode,
          p.amount, p.reference ?? '',
        ])
      ),
      `daily-${dailyDate}.csv`
    )
  }

  function exportMonthly() {
    downloadCsv(
      toCsv(
        ['Month', 'Receipts', 'Cash', 'UPI', 'Cheque', 'NEFT/RTGS', 'DD', 'Total'],
        data.monthStats.map((m: MonthStat) => [
          m.label, m.count, m.cash, m.upi, m.cheque, m.neft_rtgs, m.demand_draft, m.total,
        ])
      ),
      `monthly-${data.activeYearLabel}.csv`
    )
  }

  function exportReconciliation() {
    downloadCsv(
      toCsv(
        ['Date', 'Collected', 'Deposited', 'Difference'],
        data.reconciliation.map((r: ReconciliationRow) => [
          r.date, r.collected, r.deposited, r.difference,
        ])
      ),
      `reconciliation-${data.activeYearLabel}.csv`
    )
  }

  function exportClasswise() {
    downloadCsv(
      toCsv(
        ['Class', 'Students', 'Total Fee', 'Collected', 'Pending', '%'],
        data.classwiseStats.map((r: ClasswiseRow) => [
          r.name, r.studentCount, r.totalFee, r.collected, r.pending, r.percent,
        ])
      ),
      `classwise-${data.activeYearLabel}.csv`
    )
  }

  function exportTransportwise() {
    downloadCsv(
      toCsv(
        ['Route', 'Students', 'Total Fee', 'Collected', 'Pending', '%'],
        data.transportwiseStats.map((r: TransportwiseRow) => [
          r.name, r.studentCount, r.totalFee, r.collected, r.pending, r.percent,
        ])
      ),
      `transportwise-${data.activeYearLabel}.csv`
    )
  }

  return (
    <div className="space-y-6 p-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Reports</h1>
        <p className="mt-1 text-sm text-gray-500">Academic Year: {data.activeYearLabel}</p>
      </div>

      {/* Tab bar */}
      <div className="flex gap-1 rounded-lg border bg-gray-100 p-1 w-fit">
        {TABS.map(t => (
          <button
            key={t.key}
            onClick={() => setTab(t.key)}
            className={`rounded-md px-4 py-1.5 text-sm font-medium transition-colors ${
              tab === t.key
                ? 'bg-white shadow text-gray-900'
                : 'text-gray-500 hover:text-gray-700'
            }`}
          >
            {t.label}
          </button>
        ))}
      </div>

      {/* DAILY TAB */}
      {tab === 'daily' && (
        <div className="space-y-4">
          <div className="flex flex-wrap items-end gap-3">
            <div>
              <label className="block text-xs text-gray-500 mb-1">Date</label>
              <Input
                type="date"
                value={dailyDate}
                onChange={e => setDailyDate(e.target.value)}
                className="w-44"
              />
            </div>
            <div className="rounded-lg border bg-white px-4 py-2">
              <span className="text-sm text-gray-500">Total: </span>
              <span className="font-bold text-green-600">{formatCurrency(dailyTotal)}</span>
              <span className="ml-2 text-sm text-gray-400">({dailyPayments.length} receipts)</span>
            </div>
            <Button
              variant="outline" size="sm"
              onClick={exportDaily}
              disabled={dailyPayments.length === 0}
              className="ml-auto gap-2"
            >
              <Download className="h-4 w-4" />
              Export CSV
            </Button>
          </div>

          {dailyPayments.length === 0 ? (
            <p className="text-sm text-gray-500">No payments on {dailyDate}.</p>
          ) : (
            <div className="overflow-x-auto rounded-lg border bg-white">
              <table className="min-w-full text-sm">
                <thead className="bg-gray-50 text-gray-600">
                  <tr>
                    <th scope="col" className="px-4 py-3 text-left font-medium">Receipt No</th>
                    <th scope="col" className="px-4 py-3 text-left font-medium">Student</th>
                    <th scope="col" className="px-4 py-3 text-left font-medium">Class</th>
                    <th scope="col" className="px-4 py-3 text-left font-medium">Fee Head</th>
                    <th scope="col" className="px-4 py-3 text-left font-medium">Mode</th>
                    <th scope="col" className="px-4 py-3 text-left font-medium">Reference</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Amount</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {dailyPayments.map(p => (
                    <tr key={p.id} className="hover:bg-gray-50">
                      <td className="px-4 py-3 font-mono text-xs">{p.receiptNo}</td>
                      <td className="px-4 py-3">
                        <span className="font-medium">{p.studentName}</span>
                        <span className="ml-1 text-xs text-gray-400">({p.admNo})</span>
                      </td>
                      <td className="px-4 py-3">{p.className}</td>
                      <td className="px-4 py-3">{HEAD_LABELS[p.feeHead] ?? p.feeHead}</td>
                      <td className="px-4 py-3">{MODE_LABELS[p.mode] ?? p.mode}</td>
                      <td className="px-4 py-3 text-gray-500">{p.reference ?? '—'}</td>
                      <td className="px-4 py-3 text-right font-semibold text-green-600">
                        {formatCurrency(p.amount)}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      )}

      {/* MONTHLY TAB */}
      {tab === 'monthly' && (
        <div className="space-y-4">
          <div className="flex justify-end">
            <Button
              variant="outline" size="sm"
              onClick={exportMonthly}
              disabled={data.monthStats.length === 0}
              className="gap-2"
            >
              <Download className="h-4 w-4" />
              Export CSV
            </Button>
          </div>

          {data.monthStats.length === 0 ? (
            <p className="text-sm text-gray-500">No payments recorded yet.</p>
          ) : (
            <div className="overflow-x-auto rounded-lg border bg-white">
              <table className="min-w-full text-sm">
                <thead className="bg-gray-50 text-gray-600">
                  <tr>
                    <th scope="col" className="px-4 py-3 text-left font-medium">Month</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Receipts</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Cash</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">UPI</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Cheque</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">NEFT/RTGS</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">DD</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Total</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {data.monthStats.map((m: MonthStat) => (
                    <tr key={m.month} className="hover:bg-gray-50">
                      <td className="px-4 py-3 font-medium">{m.label}</td>
                      <td className="px-4 py-3 text-right tabular-nums">{m.count}</td>
                      <td className="px-4 py-3 text-right tabular-nums">{formatCurrency(m.cash)}</td>
                      <td className="px-4 py-3 text-right tabular-nums">{formatCurrency(m.upi)}</td>
                      <td className="px-4 py-3 text-right tabular-nums">{formatCurrency(m.cheque)}</td>
                      <td className="px-4 py-3 text-right tabular-nums">{formatCurrency(m.neft_rtgs)}</td>
                      <td className="px-4 py-3 text-right tabular-nums">{formatCurrency(m.demand_draft)}</td>
                      <td className="px-4 py-3 text-right font-semibold tabular-nums text-green-600">
                        {formatCurrency(m.total)}
                      </td>
                    </tr>
                  ))}
                </tbody>
                <tfoot className="border-t-2 bg-gray-50 font-semibold text-gray-700">
                  <tr>
                    <td className="px-4 py-3">Total</td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {data.monthStats.reduce((s, m) => s + m.count, 0)}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {formatCurrency(data.monthStats.reduce((s, m) => s + m.cash, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {formatCurrency(data.monthStats.reduce((s, m) => s + m.upi, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {formatCurrency(data.monthStats.reduce((s, m) => s + m.cheque, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {formatCurrency(data.monthStats.reduce((s, m) => s + m.neft_rtgs, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {formatCurrency(data.monthStats.reduce((s, m) => s + m.demand_draft, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums text-green-600">
                      {formatCurrency(data.monthStats.reduce((s, m) => s + m.total, 0))}
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>
          )}
        </div>
      )}

      {/* RECONCILIATION TAB */}
      {tab === 'reconciliation' && (
        <div className="space-y-4">
          <div className="flex justify-end">
            <Button
              variant="outline" size="sm"
              onClick={exportReconciliation}
              disabled={data.reconciliation.length === 0}
              className="gap-2"
            >
              <Download className="h-4 w-4" />
              Export CSV
            </Button>
          </div>

          {data.reconciliation.length === 0 ? (
            <p className="text-sm text-gray-500">No collections or deposits recorded yet.</p>
          ) : (
            <div className="overflow-x-auto rounded-lg border bg-white">
              <table className="min-w-full text-sm">
                <thead className="bg-gray-50 text-gray-600">
                  <tr>
                    <th scope="col" className="px-4 py-3 text-left font-medium">Date</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Collected</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Deposited</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Difference</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {data.reconciliation.map((r: ReconciliationRow) => (
                    <tr key={r.date} className="hover:bg-gray-50">
                      <td className="px-4 py-3 tabular-nums">{r.date}</td>
                      <td className="px-4 py-3 text-right tabular-nums text-green-600">
                        {formatCurrency(r.collected)}
                      </td>
                      <td className="px-4 py-3 text-right tabular-nums text-blue-600">
                        {formatCurrency(r.deposited)}
                      </td>
                      <td className={`px-4 py-3 text-right tabular-nums font-semibold ${
                        r.difference > 0 ? 'text-amber-600'
                        : r.difference < 0 ? 'text-red-600'
                        : 'text-gray-500'
                      }`}>
                        {r.difference > 0 ? '+' : ''}{formatCurrency(r.difference)}
                      </td>
                    </tr>
                  ))}
                </tbody>
                <tfoot className="border-t-2 bg-gray-50 font-semibold text-gray-700">
                  <tr>
                    <td className="px-4 py-3">Total</td>
                    <td className="px-4 py-3 text-right tabular-nums text-green-600">
                      {formatCurrency(data.reconciliation.reduce((s, r) => s + r.collected, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums text-blue-600">
                      {formatCurrency(data.reconciliation.reduce((s, r) => s + r.deposited, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {formatCurrency(data.reconciliation.reduce((s, r) => s + r.difference, 0))}
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>
          )}
        </div>
      )}

      {/* CLASS-WISE TAB */}
      {tab === 'classwise' && (
        <div className="space-y-4">
          <div className="flex justify-end">
            <Button
              variant="outline" size="sm"
              onClick={exportClasswise}
              disabled={data.classwiseStats.length === 0}
              className="gap-2"
            >
              <Download className="h-4 w-4" />
              Export CSV
            </Button>
          </div>

          {data.classwiseStats.length === 0 ? (
            <p className="text-sm text-gray-500">No data yet.</p>
          ) : (
            <div className="overflow-x-auto rounded-lg border bg-white">
              <table className="min-w-full text-sm">
                <thead className="bg-gray-50 text-gray-600">
                  <tr>
                    <th scope="col" className="px-4 py-3 text-left font-medium">Class</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Students</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Total Fee</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Collected</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Pending</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">%</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {data.classwiseStats.map((r: ClasswiseRow) => (
                    <tr key={r.name} className="hover:bg-gray-50">
                      <td className="px-4 py-3 font-medium">{r.name}</td>
                      <td className="px-4 py-3 text-right tabular-nums">{r.studentCount}</td>
                      <td className="px-4 py-3 text-right tabular-nums">{formatCurrency(r.totalFee)}</td>
                      <td className="px-4 py-3 text-right tabular-nums text-green-600">
                        {formatCurrency(r.collected)}
                      </td>
                      <td className="px-4 py-3 text-right tabular-nums text-red-600">
                        {formatCurrency(r.pending)}
                      </td>
                      <td className="px-4 py-3 text-right tabular-nums">
                        <span className={
                          r.percent >= 100 ? 'font-semibold text-green-600'
                          : r.percent >= 50 ? 'text-amber-600'
                          : 'text-red-600'
                        }>
                          {r.percent}%
                        </span>
                      </td>
                    </tr>
                  ))}
                </tbody>
                <tfoot className="border-t-2 bg-gray-50 font-semibold text-gray-700">
                  <tr>
                    <td className="px-4 py-3">Total</td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {data.classwiseStats.reduce((s, r) => s + r.studentCount, 0)}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {formatCurrency(data.classwiseStats.reduce((s, r) => s + r.totalFee, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums text-green-600">
                      {formatCurrency(data.classwiseStats.reduce((s, r) => s + r.collected, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums text-red-600">
                      {formatCurrency(data.classwiseStats.reduce((s, r) => s + r.pending, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {(() => {
                        const tf = data.classwiseStats.reduce((s, r) => s + r.totalFee, 0)
                        const col = data.classwiseStats.reduce((s, r) => s + r.collected, 0)
                        return tf > 0 ? `${Math.round((col / tf) * 100)}%` : '—'
                      })()}
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>
          )}
        </div>
      )}

      {/* TRANSPORT-WISE TAB */}
      {tab === 'transportwise' && (
        <div className="space-y-4">
          <div className="flex justify-end">
            <Button
              variant="outline" size="sm"
              onClick={exportTransportwise}
              disabled={data.transportwiseStats.length === 0}
              className="gap-2"
            >
              <Download className="h-4 w-4" />
              Export CSV
            </Button>
          </div>

          {data.transportwiseStats.length === 0 ? (
            <p className="text-sm text-gray-500">No data yet.</p>
          ) : (
            <div className="overflow-x-auto rounded-lg border bg-white">
              <table className="min-w-full text-sm">
                <thead className="bg-gray-50 text-gray-600">
                  <tr>
                    <th scope="col" className="px-4 py-3 text-left font-medium">Route</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Students</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Total Fee</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Collected</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">Pending</th>
                    <th scope="col" className="px-4 py-3 text-right font-medium">%</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {data.transportwiseStats.map((r: TransportwiseRow) => (
                    <tr key={r.name} className="hover:bg-gray-50">
                      <td className="px-4 py-3 font-medium">{r.name}</td>
                      <td className="px-4 py-3 text-right tabular-nums">{r.studentCount}</td>
                      <td className="px-4 py-3 text-right tabular-nums">{formatCurrency(r.totalFee)}</td>
                      <td className="px-4 py-3 text-right tabular-nums text-green-600">
                        {formatCurrency(r.collected)}
                      </td>
                      <td className="px-4 py-3 text-right tabular-nums text-red-600">
                        {formatCurrency(r.pending)}
                      </td>
                      <td className="px-4 py-3 text-right tabular-nums">
                        <span className={
                          r.percent >= 100 ? 'font-semibold text-green-600'
                          : r.percent >= 50 ? 'text-amber-600'
                          : 'text-red-600'
                        }>
                          {r.percent}%
                        </span>
                      </td>
                    </tr>
                  ))}
                </tbody>
                <tfoot className="border-t-2 bg-gray-50 font-semibold text-gray-700">
                  <tr>
                    <td className="px-4 py-3">Total</td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {data.transportwiseStats.reduce((s, r) => s + r.studentCount, 0)}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {formatCurrency(data.transportwiseStats.reduce((s, r) => s + r.totalFee, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums text-green-600">
                      {formatCurrency(data.transportwiseStats.reduce((s, r) => s + r.collected, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums text-red-600">
                      {formatCurrency(data.transportwiseStats.reduce((s, r) => s + r.pending, 0))}
                    </td>
                    <td className="px-4 py-3 text-right tabular-nums">
                      {(() => {
                        const tf = data.transportwiseStats.reduce((s, r) => s + r.totalFee, 0)
                        const col = data.transportwiseStats.reduce((s, r) => s + r.collected, 0)
                        return tf > 0 ? `${Math.round((col / tf) * 100)}%` : '—'
                      })()}
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>
          )}
        </div>
      )}
    </div>
  )
}

'use client'

import { useState } from 'react'
import dynamic from 'next/dynamic'
import { Pencil } from 'lucide-react'
import { formatCurrency } from '@/lib/utils/currency'
import { useUser } from '@/lib/user-context'
import { EditPaymentDialog } from '@/components/payments/edit-payment-dialog'
import type { EditPaymentTarget } from '@/components/payments/edit-payment-dialog'
import type { DashboardData } from './page'
import type { FeeHead, PaymentMode } from '@/lib/types'
import { HEAD_LABELS, MODE_LABELS } from '@/lib/constants/labels'

const DashboardCharts = dynamic(
  () => import('./dashboard-charts').then(m => ({ default: m.DashboardCharts })),
  { ssr: false, loading: () => <div className="h-72 animate-pulse rounded-lg bg-gray-100" /> }
)

interface StatCardProps {
  title: string
  value: string
  colorClass: string
}

function StatCard({ title, value, colorClass }: StatCardProps) {
  return (
    <div className="rounded-lg border bg-white p-4">
      <p className="text-sm text-gray-500">{title}</p>
      <p className={`mt-1 text-2xl font-bold ${colorClass}`}>{value}</p>
    </div>
  )
}

interface DashboardClientProps {
  data: DashboardData
}

export function DashboardClient({ data }: DashboardClientProps) {
  const { role } = useUser()
  const isAdmin = role === 'admin'
  const [editTarget, setEditTarget] = useState<EditPaymentTarget | null>(null)

  return (
    <div className="space-y-6 p-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Dashboard</h1>
        <p className="mt-1 text-sm text-gray-500">Academic Year: {data.activeYearLabel}</p>
      </div>

      {/* Stat cards */}
      <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
        <StatCard
          title="Total Collected"
          value={formatCurrency(data.totalCollected)}
          colorClass="text-green-600"
        />
        <StatCard
          title="Total Pending"
          value={formatCurrency(data.totalPending)}
          colorClass="text-red-600"
        />
        <StatCard
          title="Students"
          value={data.studentCount.toString()}
          colorClass="text-blue-600"
        />
        <StatCard
          title="Today's Collection"
          value={formatCurrency(data.todayCollection)}
          colorClass="text-indigo-600"
        />
      </div>

      {/* Undeposited warning banner */}
      {data.totalCollected > 0 && (
        data.undepositedAmount > 0 ? (
          <div className="flex items-center justify-between rounded-lg border border-amber-200 bg-amber-50 px-4 py-3 text-sm">
            <span className="text-amber-800">
              <span className="font-semibold">{formatCurrency(data.undepositedAmount)}</span> collected but not yet deposited to bank.
            </span>
            <a href="/bank-deposits" className="font-medium text-amber-700 underline hover:text-amber-900">
              Record deposit →
            </a>
          </div>
        ) : (
          <div className="rounded-lg border border-green-200 bg-green-50 px-4 py-3 text-sm text-green-800">
            All collections deposited. Accounts balanced.
          </div>
        )
      )}

      {/* Charts row */}
      <DashboardCharts classStats={data.classStats} routeStats={data.routeStats} />

      {/* Recent payments */}
      <div className="rounded-lg border bg-white">
        <div className="border-b px-4 py-3">
          <h2 className="font-semibold text-gray-900">Recent Payments</h2>
        </div>
        {data.recentPayments.length === 0 ? (
          <p className="px-4 py-3 text-sm text-gray-400">No payments recorded yet.</p>
        ) : (
          <div className="overflow-x-auto">
            <table className="min-w-full text-sm">
              <thead className="bg-gray-50 text-gray-600">
                <tr>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Receipt No</th>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Student</th>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Fee Head</th>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Mode</th>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Date</th>
                  <th scope="col" className="px-4 py-3 text-right font-medium">Amount</th>
                  {isAdmin && <th scope="col" className="px-4 py-3" />}
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {data.recentPayments.map(p => (
                  <tr key={p.id} className="hover:bg-gray-50">
                    <td className="px-4 py-3 font-mono text-xs">{p.receiptNo}</td>
                    <td className="px-4 py-3">
                      <span className="font-medium">{p.studentName}</span>
                      <span className="ml-1 text-xs text-gray-400">({p.admNo})</span>
                    </td>
                    <td className="px-4 py-3">{HEAD_LABELS[p.feeHead] ?? p.feeHead}</td>
                    <td className="px-4 py-3">{MODE_LABELS[p.mode] ?? p.mode}</td>
                    <td className="px-4 py-3">{p.paymentDate}</td>
                    <td className="px-4 py-3 text-right font-semibold text-green-600">
                      {formatCurrency(p.amount)}
                    </td>
                    {isAdmin && (
                      <td className="px-4 py-3 text-right">
                        <button
                          onClick={() => setEditTarget({
                            id: p.id,
                            receiptNo: p.receiptNo,
                            studentName: p.studentName,
                            amount: p.amount,
                            mode: p.mode as PaymentMode,
                            paymentDate: p.paymentDate,
                            feeHead: p.feeHead as FeeHead,
                            reference: p.reference,
                            remarks: p.remarks,
                          })}
                          className="rounded p-1 text-gray-400 hover:bg-gray-100 hover:text-gray-600"
                          aria-label="Edit payment"
                        >
                          <Pencil className="h-3.5 w-3.5" />
                        </button>
                      </td>
                    )}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {editTarget && (
        <EditPaymentDialog
          payment={editTarget}
          open={editTarget !== null}
          onOpenChange={open => { if (!open) setEditTarget(null) }}
        />
      )}
    </div>
  )
}

'use client'

import {
  BarChart, Bar, XAxis, YAxis, Tooltip, CartesianGrid, Legend,
  PieChart, Pie, Cell, ResponsiveContainer,
} from 'recharts'
import { formatCurrency } from '@/lib/utils/currency'
import type { DashboardData } from './page'

const PIE_COLORS = [
  '#4f46e5', '#16a34a', '#dc2626', '#d97706',
  '#0891b2', '#7c3aed', '#db2777', '#65a30d',
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

      {/* Charts row */}
      <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
        {/* Class-wise bar chart */}
        <div className="rounded-lg border bg-white p-4">
          <h2 className="mb-4 font-semibold text-gray-900">Class-wise Collection</h2>
          {data.classStats.length === 0 ? (
            <p className="text-sm text-gray-400">No data yet.</p>
          ) : (
            <ResponsiveContainer width="100%" height={280}>
              <BarChart
                data={data.classStats}
                margin={{ top: 5, right: 20, left: 10, bottom: 5 }}
              >
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="name" tick={{ fontSize: 11 }} />
                <YAxis
                  tick={{ fontSize: 11 }}
                  tickFormatter={(v: number) =>
                    v >= 1000 ? `₹${(v / 1000).toFixed(0)}k` : `₹${v}`
                  }
                />
                <Tooltip
                  formatter={(value: number) => [formatCurrency(value), undefined]}
                />
                <Legend />
                <Bar dataKey="totalFee" name="Total Fee" fill="#93c5fd" radius={[4, 4, 0, 0]} />
                <Bar dataKey="collected" name="Collected" fill="#4ade80" radius={[4, 4, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          )}
        </div>

        {/* Transport pie chart */}
        <div className="rounded-lg border bg-white p-4">
          <h2 className="mb-4 font-semibold text-gray-900">Transport Distribution</h2>
          {data.routeStats.length === 0 ? (
            <p className="text-sm text-gray-400">No data yet.</p>
          ) : (
            <ResponsiveContainer width="100%" height={280}>
              <PieChart>
                <Pie
                  data={data.routeStats}
                  dataKey="studentCount"
                  nameKey="name"
                  cx="50%"
                  cy="50%"
                  outerRadius={100}
                  label={({ name, percent }: { name: string; percent: number }) =>
                    `${name} ${(percent * 100).toFixed(0)}%`
                  }
                  labelLine={false}
                >
                  {data.routeStats.map((_, i) => (
                    <Cell key={i} fill={PIE_COLORS[i % PIE_COLORS.length]} />
                  ))}
                </Pie>
                <Tooltip formatter={(value: number) => [`${value} students`, undefined]} />
              </PieChart>
            </ResponsiveContainer>
          )}
        </div>
      </div>

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
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  )
}

'use client'

import {
  BarChart, Bar, XAxis, YAxis, Tooltip, CartesianGrid, Legend,
  PieChart, Pie, Cell, ResponsiveContainer,
} from 'recharts'
import { formatCurrency } from '@/lib/utils/currency'
import type { ClassStat, RouteStat } from './page'

const PIE_COLORS = [
  '#4f46e5', '#16a34a', '#dc2626', '#d97706',
  '#0891b2', '#7c3aed', '#db2777', '#65a30d',
]

interface DashboardChartsProps {
  classStats: ClassStat[]
  routeStats: RouteStat[]
}

export function DashboardCharts({ classStats, routeStats }: DashboardChartsProps) {
  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <div className="rounded-lg border bg-white p-4">
        <h2 className="mb-4 font-semibold text-gray-900">Class-wise Collection</h2>
        {classStats.length === 0 ? (
          <p className="text-sm text-gray-400">No data yet.</p>
        ) : (
          <ResponsiveContainer width="100%" height={280}>
            <BarChart
              data={classStats}
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
                formatter={(value: unknown) => [formatCurrency(Number(value)), undefined]}
              />
              <Legend />
              <Bar dataKey="totalFee" name="Total Fee" fill="#93c5fd" radius={[4, 4, 0, 0]} />
              <Bar dataKey="collected" name="Collected" fill="#4ade80" radius={[4, 4, 0, 0]} />
            </BarChart>
          </ResponsiveContainer>
        )}
      </div>

      <div className="rounded-lg border bg-white p-4">
        <h2 className="mb-4 font-semibold text-gray-900">Transport Distribution</h2>
        {routeStats.length === 0 ? (
          <p className="text-sm text-gray-400">No data yet.</p>
        ) : (
          <ResponsiveContainer width="100%" height={280}>
            <PieChart>
              <Pie
                data={routeStats}
                dataKey="studentCount"
                nameKey="name"
                cx="50%"
                cy="50%"
                outerRadius={100}
                label={({ name, percent }: { name?: string; percent?: number }) =>
                  `${name ?? ''} ${((percent ?? 0) * 100).toFixed(0)}%`
                }
                labelLine={false}
              >
                {routeStats.map((_, i) => (
                  <Cell key={i} fill={PIE_COLORS[i % PIE_COLORS.length]} />
                ))}
              </Pie>
              <Tooltip formatter={(value: unknown) => [`${value} students`, undefined]} />
            </PieChart>
          </ResponsiveContainer>
        )}
      </div>
    </div>
  )
}

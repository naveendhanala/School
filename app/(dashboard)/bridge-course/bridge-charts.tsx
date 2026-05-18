'use client'

import {
  BarChart, Bar, XAxis, YAxis, Tooltip, CartesianGrid, Legend,
  PieChart, Pie, Cell, ResponsiveContainer,
} from 'recharts'

interface BarEntry {
  name: string
  Collected: number
  Balance: number
}

interface PieEntry {
  name: string
  value: number
}

interface BridgeChartsProps {
  barData: BarEntry[]
  pieData: PieEntry[]
}

const PIE_COLORS = ['#4ade80', '#60a5fa', '#f97316']

export function BridgeCharts({ barData, pieData }: BridgeChartsProps) {
  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <div className="rounded-lg border bg-white p-4">
        <h2 className="mb-4 font-semibold text-gray-900">Course-wise Collection</h2>
        <ResponsiveContainer width="100%" height={240}>
          <BarChart data={barData} margin={{ top: 5, right: 20, left: 10, bottom: 5 }}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="name" tick={{ fontSize: 12 }} />
            <YAxis
              tick={{ fontSize: 11 }}
              tickFormatter={(v: number) => v >= 1000 ? `₹${(v / 1000).toFixed(0)}k` : `₹${v}`}
            />
            <Tooltip formatter={(value: unknown) => [`₹${Number(value).toLocaleString('en-IN')}`, undefined]} />
            <Legend />
            <Bar dataKey="Collected" fill="#4ade80" radius={[4, 4, 0, 0]} />
            <Bar dataKey="Balance" fill="#f87171" radius={[4, 4, 0, 0]} />
          </BarChart>
        </ResponsiveContainer>
      </div>

      <div className="rounded-lg border bg-white p-4">
        <h2 className="mb-4 font-semibold text-gray-900">Payment Mode Split</h2>
        {pieData.length === 0 ? (
          <p className="text-sm text-gray-400">No payments yet.</p>
        ) : (
          <ResponsiveContainer width="100%" height={240}>
            <PieChart>
              <Pie
                data={pieData}
                dataKey="value"
                nameKey="name"
                cx="50%"
                cy="50%"
                outerRadius={90}
                label={({ name, percent }: { name?: string; percent?: number }) =>
                  `${name ?? ''} ${((percent ?? 0) * 100).toFixed(0)}%`
                }
                labelLine={false}
              >
                {pieData.map((_, i) => (
                  <Cell key={i} fill={PIE_COLORS[i % PIE_COLORS.length]} />
                ))}
              </Pie>
              <Tooltip formatter={(value: unknown) => [`₹${Number(value).toLocaleString('en-IN')}`, undefined]} />
            </PieChart>
          </ResponsiveContainer>
        )}
      </div>
    </div>
  )
}

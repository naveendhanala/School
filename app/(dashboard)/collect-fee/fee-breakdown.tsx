'use client'

import { formatCurrency } from '@/lib/utils/currency'
import type { CollectFeeStudent } from './page'

interface FeeBreakdownProps {
  student: CollectFeeStudent
}

export function FeeBreakdown({ student }: FeeBreakdownProps) {
  const pct =
    student.totalFee > 0
      ? Math.min(Math.round((student.totalPaid / student.totalFee) * 100), 100)
      : 0

  return (
    <div className="space-y-4">
      {/* Progress bar */}
      <div>
        <div className="mb-1 flex justify-between text-xs text-gray-500">
          <span>{pct}% paid</span>
          <span>
            {formatCurrency(student.totalPaid)} / {formatCurrency(student.totalFee)}
          </span>
        </div>
        <div className="h-2 w-full rounded-full bg-gray-200">
          <div
            className="h-2 rounded-full bg-green-500 transition-all"
            style={{ width: `${pct}%` }}
          />
        </div>
      </div>

      {/* Summary */}
      <div className="grid grid-cols-3 text-center text-sm">
        <div>
          <p className="text-gray-500">Total</p>
          <p className="font-semibold">{formatCurrency(student.totalFee)}</p>
        </div>
        <div>
          <p className="text-gray-500">Paid</p>
          <p className="font-semibold text-green-600">{formatCurrency(student.totalPaid)}</p>
        </div>
        <div>
          <p className="text-gray-500">Balance</p>
          <p className="font-semibold text-red-600">{formatCurrency(student.balance)}</p>
        </div>
      </div>

      {/* Per-head table */}
      {student.breakdown.length > 0 && (
        <table className="w-full text-sm">
          <thead>
            <tr className="border-b text-gray-500">
              <th className="py-1 text-left" scope="col">Fee Head</th>
              <th className="py-1 text-right" scope="col">Total</th>
              <th className="py-1 text-right" scope="col">Paid</th>
              <th className="py-1 text-right" scope="col">Balance</th>
            </tr>
          </thead>
          <tbody>
            {student.breakdown.map(row => (
              <tr key={row.head} className="border-b last:border-0">
                <td className="py-1">{row.label}</td>
                <td className="py-1 text-right">{formatCurrency(row.total)}</td>
                <td className="py-1 text-right text-green-600">{formatCurrency(row.paid)}</td>
                <td className="py-1 text-right text-red-600">{formatCurrency(row.balance)}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  )
}

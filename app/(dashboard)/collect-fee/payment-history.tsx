'use client'

import { formatCurrency } from '@/lib/utils/currency'
import type { PaymentRecord } from './page'

const MODE_LABELS: Record<string, string> = {
  cash: 'Cash',
  upi: 'UPI',
  cheque: 'Cheque',
  neft_rtgs: 'NEFT/RTGS',
  demand_draft: 'DD',
}

const HEAD_LABELS: Record<string, string> = {
  tuition: 'Tuition',
  book: 'Book',
  transport: 'Transport',
  hostel: 'Hostel',
  admission: 'Admission',
  uniform: 'Uniform',
  exam: 'Exam',
  other: 'Other',
}

interface PaymentHistoryProps {
  payments: PaymentRecord[]
}

export function PaymentHistory({ payments }: PaymentHistoryProps) {
  if (payments.length === 0) {
    return <p className="text-sm text-gray-400">No payments recorded yet.</p>
  }

  return (
    <div className="space-y-3">
      {payments.map(p => (
        <div key={p.id} className="border-b pb-3 last:border-0 last:pb-0">
          <div className="flex items-start justify-between">
            <div>
              <p className="text-sm font-medium">{HEAD_LABELS[p.feeHead] ?? p.feeHead}</p>
              <p className="text-xs text-gray-500">
                {p.paymentDate} · {MODE_LABELS[p.mode] ?? p.mode}
                {p.reference ? ` · ${p.reference}` : ''}
              </p>
              <p className="text-xs text-gray-400">{p.receiptNo}</p>
              {p.remarks && (
                <p className="text-xs italic text-gray-400">{p.remarks}</p>
              )}
            </div>
            <span className="text-sm font-semibold text-green-600">
              {formatCurrency(p.amount)}
            </span>
          </div>
        </div>
      ))}
    </div>
  )
}

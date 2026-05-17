'use client'

import { useState } from 'react'
import Link from 'next/link'
import { Pencil } from 'lucide-react'
import { formatCurrency } from '@/lib/utils/currency'
import { useUser } from '@/lib/user-context'
import { EditPaymentDialog } from '@/components/payments/edit-payment-dialog'
import type { EditPaymentTarget } from '@/components/payments/edit-payment-dialog'
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
  studentName: string
}

export function PaymentHistory({ payments, studentName }: PaymentHistoryProps) {
  const { role } = useUser()
  const isAdmin = role === 'admin'
  const [editTarget, setEditTarget] = useState<EditPaymentTarget | null>(null)

  if (payments.length === 0) {
    return <p className="text-sm text-gray-400">No payments recorded yet.</p>
  }

  return (
    <>
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
              <div className="flex items-center gap-2">
                <span className="text-sm font-semibold text-green-600">
                  {formatCurrency(p.amount)}
                </span>
                <Link
                  href={`/receipt/${p.id}`}
                  target="_blank"
                  className="rounded p-1 text-xs text-blue-500 hover:text-blue-700"
                  aria-label="View receipt"
                >
                  Receipt
                </Link>
                {isAdmin && (
                  <button
                    onClick={() => setEditTarget({
                      id: p.id,
                      receiptNo: p.receiptNo,
                      studentName,
                      amount: p.amount,
                      mode: p.mode,
                      paymentDate: p.paymentDate,
                      feeHead: p.feeHead,
                      reference: p.reference,
                      remarks: p.remarks,
                    })}
                    className="rounded p-1 text-gray-400 hover:bg-gray-100 hover:text-gray-600"
                    aria-label="Edit payment"
                  >
                    <Pencil className="h-3.5 w-3.5" />
                  </button>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>

      {editTarget && (
        <EditPaymentDialog
          payment={editTarget}
          open={editTarget !== null}
          onOpenChange={open => { if (!open) setEditTarget(null) }}
        />
      )}
    </>
  )
}

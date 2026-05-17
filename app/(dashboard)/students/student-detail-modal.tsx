'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import {
  Dialog, DialogContent, DialogHeader, DialogTitle,
} from '@/components/ui/dialog'
import { formatCurrency } from '@/lib/utils/currency'
import { getStudentPaymentHistory } from './actions'
import type { StudentRow } from './page'

const MODE_LABELS: Record<string, string> = {
  cash: 'Cash', upi: 'UPI', cheque: 'Cheque',
  neft_rtgs: 'NEFT/RTGS', demand_draft: 'DD',
}
const HEAD_LABELS: Record<string, string> = {
  tuition: 'Tuition', book: 'Book', transport: 'Transport',
  hostel: 'Hostel', admission: 'Admission', uniform: 'Uniform',
  exam: 'Exam', other: 'Other',
}

type PaymentRecord = {
  id: string; receiptNo: string; paymentDate: string
  feeHead: string; mode: string; amount: number; reference: string | null
}

interface Props {
  student: StudentRow | null
  onClose: () => void
}

export function StudentDetailModal({ student, onClose }: Props) {
  const [payments, setPayments] = useState<PaymentRecord[]>([])
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    if (!student) { setPayments([]); return }
    setLoading(true)
    getStudentPaymentHistory(student.enrollmentId).then(p => {
      setPayments(p)
      setLoading(false)
    })
  }, [student])

  const pct = student && student.totalFee > 0
    ? Math.min(100, Math.round((student.totalPaid / student.totalFee) * 100))
    : 0

  return (
    <Dialog open={student !== null} onOpenChange={o => { if (!o) onClose() }}>
      <DialogContent className="max-w-lg max-h-[80vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>{student?.name ?? ''}</DialogTitle>
        </DialogHeader>
        {student && (
          <div className="space-y-4">
            {/* Student info */}
            <div className="grid grid-cols-2 gap-x-4 gap-y-1 rounded-lg bg-gray-50 px-4 py-3 text-sm">
              <span className="text-gray-500">Adm No</span>
              <span>{student.admNo}</span>
              <span className="text-gray-500">Class</span>
              <span>{student.className}</span>
              <span className="text-gray-500">Gender</span>
              <span className="capitalize">{student.gender}</span>
              {student.routeName && (
                <>
                  <span className="text-gray-500">Route</span>
                  <span>{student.routeName}</span>
                </>
              )}
              {student.mobile && (
                <>
                  <span className="text-gray-500">Mobile</span>
                  <span>{student.mobile}</span>
                </>
              )}
              {student.village && (
                <>
                  <span className="text-gray-500">Village</span>
                  <span>{student.village}</span>
                </>
              )}
            </div>

            {/* Fee summary */}
            <div className="grid grid-cols-3 gap-3 text-center">
              <div className="rounded-lg border p-3">
                <p className="text-xs text-gray-500">Total Fee</p>
                <p className="font-semibold text-gray-900">{formatCurrency(student.totalFee)}</p>
              </div>
              <div className="rounded-lg border p-3">
                <p className="text-xs text-gray-500">Paid</p>
                <p className="font-semibold text-green-600">{formatCurrency(student.totalPaid)}</p>
              </div>
              <div className="rounded-lg border p-3">
                <p className="text-xs text-gray-500">Balance</p>
                <p className={`font-semibold ${student.balance > 0 ? 'text-red-600' : 'text-gray-500'}`}>
                  {formatCurrency(student.balance)}
                </p>
              </div>
            </div>

            {/* Progress bar */}
            {student.totalFee > 0 && (
              <div>
                <div className="mb-1 flex justify-between text-xs text-gray-500">
                  <span>Collection progress</span>
                  <span>{pct}%</span>
                </div>
                <div className="h-2 w-full rounded-full bg-gray-200">
                  <div
                    className="h-2 rounded-full bg-green-500 transition-all"
                    style={{ width: `${pct}%` }}
                  />
                </div>
              </div>
            )}

            {/* Payment history */}
            <div>
              <h3 className="mb-2 text-sm font-medium text-gray-700">Payment History</h3>
              {loading ? (
                <p className="text-sm text-gray-400">Loading…</p>
              ) : payments.length === 0 ? (
                <p className="text-sm text-gray-400">No payments recorded.</p>
              ) : (
                <div className="divide-y rounded-lg border bg-white">
                  {payments.map(p => (
                    <div key={p.id} className="flex items-center justify-between px-3 py-2 text-sm">
                      <div>
                        <p className="font-medium">{HEAD_LABELS[p.feeHead] ?? p.feeHead}</p>
                        <p className="text-xs text-gray-500">
                          {p.paymentDate} · {MODE_LABELS[p.mode] ?? p.mode}
                          {p.reference ? ` · ${p.reference}` : ''}
                        </p>
                        <p className="font-mono text-xs text-gray-400">{p.receiptNo}</p>
                      </div>
                      <div className="flex items-center gap-2">
                        <span className="font-semibold text-green-600">{formatCurrency(p.amount)}</span>
                        <Link
                          href={`/receipt/${p.id}`}
                          target="_blank"
                          className="text-xs text-blue-600 hover:underline"
                        >
                          Receipt
                        </Link>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </div>

            {/* Action */}
            <div className="flex justify-end border-t pt-3">
              <Link
                href="/collect-fee"
                onClick={onClose}
                className="inline-flex items-center gap-1 rounded-md bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-700"
              >
                Collect Fee →
              </Link>
            </div>
          </div>
        )}
      </DialogContent>
    </Dialog>
  )
}

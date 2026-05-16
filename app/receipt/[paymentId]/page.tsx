import { createClient } from '@/lib/supabase/server'
import { notFound } from 'next/navigation'
import { ReceiptActions } from './receipt-actions'
import type { FeeHead, PaymentMode } from '@/lib/types'

const MODE_LABELS: Record<PaymentMode, string> = {
  cash: 'Cash',
  upi: 'UPI',
  cheque: 'Cheque',
  neft_rtgs: 'NEFT / RTGS',
  demand_draft: 'Demand Draft',
}

const HEAD_LABELS: Record<FeeHead, string> = {
  tuition: 'Tuition Fee',
  book: 'Book Fee',
  transport: 'Transport Fee',
  hostel: 'Hostel Fee',
  admission: 'Admission Fee',
  uniform: 'Uniform Fee',
  exam: 'Exam Fee',
  other: 'Other',
}

export default async function ReceiptPage({
  params,
}: {
  params: Promise<{ paymentId: string }>
}) {
  const { paymentId } = await params
  const supabase = await createClient()

  const { data: payment } = await supabase
    .from('payments')
    .select(`
      id, fee_head, amount, mode, payment_date, reference, receipt_no, remarks,
      enrollments!inner (
        students!inner ( adm_no, name, village ),
        classes!inner ( name ),
        transport_routes ( name ),
        academic_years!inner ( label )
      )
    `)
    .eq('id', paymentId)
    .single()

  if (!payment) notFound()

  const enrollment = payment.enrollments as unknown as {
    students: { adm_no: string; name: string; village: string | null }
    classes: { name: string }
    transport_routes: { name: string } | null
    academic_years: { label: string }
  }

  const student = enrollment.students
  const cls = enrollment.classes
  const route = enrollment.transport_routes
  const yearLabel = enrollment.academic_years.label
  const amountStr = Number(payment.amount).toFixed(2)

  return (
    <>
      {/* Print-specific styles: suppress no-print elements and remove margins */}
      <style>{`
        @media print {
          @page { margin: 16mm; }
          .no-print { display: none !important; }
        }
        body { font-family: Arial, sans-serif; color: #000; }
      `}</style>

      <div className="mx-auto max-w-lg p-8">
        {/* Header */}
        <div className="mb-6 border-b-2 border-black pb-4 text-center">
          <h1 className="text-xl font-bold">Rama School of Excellence</h1>
          <p className="text-sm text-gray-600">Fee Receipt</p>
        </div>

        {/* Receipt no + date */}
        <div className="mb-4 flex justify-between text-sm">
          <span>
            <span className="font-semibold">Receipt No:</span> {payment.receipt_no}
          </span>
          <span>
            <span className="font-semibold">Date:</span> {payment.payment_date}
          </span>
        </div>

        {/* Student details */}
        <div className="mb-4">
          <h2 className="mb-2 border-b pb-1 text-sm font-semibold">Student Details</h2>
          <div className="grid grid-cols-2 gap-y-1 text-sm">
            <span className="text-gray-600">Name</span>
            <span>{student.name}</span>
            <span className="text-gray-600">Adm No</span>
            <span>{student.adm_no}</span>
            <span className="text-gray-600">Class</span>
            <span>{cls.name}</span>
            {route && (
              <>
                <span className="text-gray-600">Route</span>
                <span>{route.name}</span>
              </>
            )}
            {student.village && (
              <>
                <span className="text-gray-600">Village</span>
                <span>{student.village}</span>
              </>
            )}
            <span className="text-gray-600">Academic Year</span>
            <span>{yearLabel}</span>
          </div>
        </div>

        {/* Payment details */}
        <div className="mb-4">
          <h2 className="mb-2 border-b pb-1 text-sm font-semibold">Payment Details</h2>
          <div className="grid grid-cols-2 gap-y-1 text-sm">
            <span className="text-gray-600">Fee Head</span>
            <span>{HEAD_LABELS[payment.fee_head as FeeHead] ?? payment.fee_head}</span>
            <span className="text-gray-600">Mode</span>
            <span>{MODE_LABELS[payment.mode as PaymentMode] ?? payment.mode}</span>
            {payment.reference && (
              <>
                <span className="text-gray-600">Reference</span>
                <span>{payment.reference}</span>
              </>
            )}
            {payment.remarks && (
              <>
                <span className="text-gray-600">Remarks</span>
                <span>{payment.remarks}</span>
              </>
            )}
          </div>
        </div>

        {/* Amount box */}
        <div className="my-6 rounded border-2 border-black p-4 text-center">
          <p className="mb-1 text-xs text-gray-500">Amount Received</p>
          <p className="text-2xl font-bold">₹{amountStr}</p>
        </div>

        {/* Footer */}
        <div className="mt-8 border-t pt-4 text-center text-sm text-gray-500">
          Received with thanks
        </div>

        <ReceiptActions />
      </div>
    </>
  )
}

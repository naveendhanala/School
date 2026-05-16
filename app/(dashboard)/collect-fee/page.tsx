import { createClient } from '@/lib/supabase/server'
import { calcStudentFee } from '@/lib/utils/fee-calc'
import type { Gender, FeeHead, ClassFeeHead, StudentFeeHead, PaymentMode } from '@/lib/types'
import { CollectFeeClient } from './collect-fee-client'

export type FeeHeadBreakdown = {
  head: FeeHead
  label: string
  total: number
  paid: number
  balance: number
}

export type PaymentRecord = {
  id: string
  feeHead: FeeHead
  amount: number
  mode: PaymentMode
  paymentDate: string
  reference: string | null
  receiptNo: string
  remarks: string | null
  createdAt: string
}

export type CollectFeeStudent = {
  id: string
  admNo: string
  name: string
  gender: Gender
  className: string
  routeName: string | null
  enrollmentId: string
  totalFee: number
  totalPaid: number
  balance: number
  status: 'paid' | 'partial' | 'unpaid'
  breakdown: FeeHeadBreakdown[]
  payments: PaymentRecord[]
}

const FEE_HEAD_LABELS: Record<FeeHead, string> = {
  tuition: 'Tuition Fee',
  book: 'Book Fee',
  transport: 'Transport Fee',
  hostel: 'Hostel Fee',
  admission: 'Admission Fee',
  uniform: 'Uniform Fee',
  exam: 'Exam Fee',
  other: 'Other',
}

const FEE_HEADS: FeeHead[] = [
  'tuition', 'book', 'transport', 'hostel', 'admission', 'uniform', 'exam', 'other',
]

export default async function CollectFeePage() {
  const supabase = await createClient()

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id, label')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) {
    return (
      <div className="p-6">
        <h1 className="text-2xl font-bold text-gray-900">Collect Fee</h1>
        <p className="mt-2 text-gray-500">No active academic year. Set one up in Fee Setup.</p>
      </div>
    )
  }

  const { data: enrollmentsRaw } = await supabase
    .from('enrollments')
    .select(`
      id,
      class_id,
      route_id,
      students!inner ( id, adm_no, name, gender, is_active ),
      classes!inner ( name ),
      transport_routes ( name, fee_amount )
    `)
    .eq('academic_year_id', activeYear.id)

  const enrollments = enrollmentsRaw ?? []
  const enrollmentIds = enrollments.map(e => e.id)

  const { data: feeStructure } = await supabase
    .from('fee_structure')
    .select('class_id, fee_head, amount')
    .eq('academic_year_id', activeYear.id)

  const [{ data: studentFees }, { data: paymentsRaw }] = await Promise.all([
    enrollmentIds.length > 0
      ? supabase
          .from('student_fees')
          .select('enrollment_id, fee_head, amount')
          .in('enrollment_id', enrollmentIds)
      : { data: [] as { enrollment_id: string; fee_head: string; amount: number }[] },
    enrollmentIds.length > 0
      ? supabase
          .from('payments')
          .select('id, enrollment_id, fee_head, amount, mode, payment_date, reference, receipt_no, remarks, created_at')
          .in('enrollment_id', enrollmentIds)
          .order('created_at', { ascending: false })
      : {
          data: [] as {
            id: string; enrollment_id: string; fee_head: string; amount: number
            mode: string; payment_date: string; reference: string | null
            receipt_no: string; remarks: string | null; created_at: string
          }[],
        },
  ])

  // class_id → { tuition: number, book: number }
  const classFeeMap = new Map<string, Record<ClassFeeHead, number>>()
  for (const fs of feeStructure ?? []) {
    const entry = classFeeMap.get(fs.class_id) ?? { tuition: 0, book: 0 }
    ;(entry as Record<string, number>)[fs.fee_head] = Number(fs.amount)
    classFeeMap.set(fs.class_id, entry)
  }

  // enrollment_id → per-head student fees
  const studentFeeMap = new Map<string, Partial<Record<StudentFeeHead, number>>>()
  for (const sf of studentFees ?? []) {
    const entry = studentFeeMap.get(sf.enrollment_id) ?? {}
    ;(entry as Record<string, number>)[sf.fee_head] = Number(sf.amount)
    studentFeeMap.set(sf.enrollment_id, entry)
  }

  // enrollment_id → paid per FeeHead + full payment records
  const paidByHeadMap = new Map<string, Partial<Record<FeeHead, number>>>()
  const paymentRecordsMap = new Map<string, PaymentRecord[]>()
  for (const p of paymentsRaw ?? []) {
    const byHead = paidByHeadMap.get(p.enrollment_id) ?? {}
    ;(byHead as Record<string, number>)[p.fee_head] =
      ((byHead as Record<string, number>)[p.fee_head] ?? 0) + Number(p.amount)
    paidByHeadMap.set(p.enrollment_id, byHead)

    const records = paymentRecordsMap.get(p.enrollment_id) ?? []
    records.push({
      id: p.id,
      feeHead: p.fee_head as FeeHead,
      amount: Number(p.amount),
      mode: p.mode as PaymentMode,
      paymentDate: p.payment_date,
      reference: p.reference,
      receiptNo: p.receipt_no,
      remarks: p.remarks,
      createdAt: p.created_at,
    })
    paymentRecordsMap.set(p.enrollment_id, records)
  }

  const students: CollectFeeStudent[] = enrollments
    .filter(e => {
      const student = e.students as unknown as { is_active: boolean }
      return student.is_active
    })
    .map(e => {
      const student = e.students as unknown as {
        id: string; adm_no: string; name: string; gender: string; is_active: boolean
      }
      const cls = e.classes as unknown as { name: string }
      const route = e.transport_routes as unknown as { name: string; fee_amount: number } | null

      const classFees = classFeeMap.get(e.class_id) ?? { tuition: 0, book: 0 }
      const stuFees = studentFeeMap.get(e.id) ?? {}
      const paidByHead = paidByHeadMap.get(e.id) ?? {}
      const transportFee = route ? Number(route.fee_amount) : 0

      const breakdown: FeeHeadBreakdown[] = FEE_HEADS.flatMap(head => {
        let total = 0
        if (head === 'tuition') total = classFees.tuition
        else if (head === 'book') total = classFees.book
        else if (head === 'transport') total = transportFee
        else total = (stuFees as Record<string, number>)[head] ?? 0

        const paid = (paidByHead as Record<string, number>)[head] ?? 0
        if (total === 0 && paid === 0) return []
        return [{ head, label: FEE_HEAD_LABELS[head], total, paid, balance: total - paid }]
      })

      const feeCalc = calcStudentFee({
        classFees: [{ amount: classFees.tuition }, { amount: classFees.book }].filter(f => f.amount > 0),
        studentFees: (Object.values(stuFees) as number[]).map(a => ({ amount: Number(a) })),
        transportFee,
        payments: (paymentRecordsMap.get(e.id) ?? []).map(p => ({ amount: p.amount })),
      })

      return {
        id: student.id,
        admNo: student.adm_no,
        name: student.name,
        gender: student.gender as Gender,
        className: cls.name,
        routeName: route?.name ?? null,
        enrollmentId: e.id,
        ...feeCalc,
        breakdown,
        payments: paymentRecordsMap.get(e.id) ?? [],
      }
    })

  return <CollectFeeClient students={students} />
}

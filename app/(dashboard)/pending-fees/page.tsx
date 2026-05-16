import { createClient } from '@/lib/supabase/server'
import { calcStudentFee } from '@/lib/utils/fee-calc'
import type { ClassFeeHead, StudentFeeHead } from '@/lib/types'
import { PendingFeesClient } from './pending-fees-client'

export type PendingRow = {
  enrollmentId: string
  admNo: string
  name: string
  className: string
  classId: string
  routeName: string | null
  routeId: string | null
  totalFee: number
  totalPaid: number
  balance: number
}

export default async function PendingFeesPage() {
  const supabase = await createClient()

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id, label')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) {
    return (
      <div className="p-6">
        <h1 className="text-2xl font-bold text-gray-900">Pending Fees</h1>
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
      students!inner ( adm_no, name, is_active ),
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

  const [{ data: studentFees }, { data: payments }] = await Promise.all([
    enrollmentIds.length > 0
      ? supabase
          .from('student_fees')
          .select('enrollment_id, fee_head, amount')
          .in('enrollment_id', enrollmentIds)
      : { data: [] as { enrollment_id: string; fee_head: string; amount: number }[] },
    enrollmentIds.length > 0
      ? supabase
          .from('payments')
          .select('enrollment_id, amount')
          .in('enrollment_id', enrollmentIds)
      : { data: [] as { enrollment_id: string; amount: number }[] },
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

  // enrollment_id → total paid
  const paymentTotalMap = new Map<string, number>()
  for (const p of payments ?? []) {
    paymentTotalMap.set(p.enrollment_id, (paymentTotalMap.get(p.enrollment_id) ?? 0) + Number(p.amount))
  }

  const { data: classes } = await supabase.from('classes').select('id, name').order('sort_order')
  const { data: routes } = await supabase.from('transport_routes').select('id, name').order('name')

  const rows: PendingRow[] = enrollments
    .filter(e => {
      const student = e.students as unknown as { is_active: boolean }
      return student.is_active
    })
    .map(e => {
      const student = e.students as unknown as { adm_no: string; name: string }
      const cls = e.classes as unknown as { name: string }
      const route = e.transport_routes as unknown as { name: string; fee_amount: number } | null

      const classFees = classFeeMap.get(e.class_id) ?? { tuition: 0, book: 0 }
      const stuFees = studentFeeMap.get(e.id) ?? {}
      const transportFee = route ? Number(route.fee_amount) : 0
      const totalPaid = paymentTotalMap.get(e.id) ?? 0

      const feeCalc = calcStudentFee({
        classFees: [{ amount: classFees.tuition }, { amount: classFees.book }].filter(f => f.amount > 0),
        studentFees: (Object.values(stuFees) as number[]).map(a => ({ amount: Number(a) })),
        transportFee,
        payments: totalPaid > 0 ? [{ amount: totalPaid }] : [],
      })

      return {
        enrollmentId: e.id,
        admNo: student.adm_no,
        name: student.name,
        className: cls.name,
        classId: e.class_id,
        routeName: route?.name ?? null,
        routeId: e.route_id,
        ...feeCalc,
      }
    })
    .filter(row => row.balance > 0)

  return (
    <PendingFeesClient
      rows={rows}
      classes={classes ?? []}
      routes={routes ?? []}
      activeYearLabel={activeYear.label}
    />
  )
}

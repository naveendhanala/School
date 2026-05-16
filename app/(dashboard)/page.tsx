import { createClient } from '@/lib/supabase/server'
import { calcStudentFee } from '@/lib/utils/fee-calc'
import type { ClassFeeHead } from '@/lib/types'
import { DashboardClient } from './dashboard-client'

export type ClassStat = {
  name: string
  sortOrder: number
  totalFee: number
  collected: number
}

export type RouteStat = {
  name: string
  studentCount: number
}

export type RecentPayment = {
  id: string
  receiptNo: string
  studentName: string
  admNo: string
  feeHead: string
  amount: number
  mode: string
  paymentDate: string
}

export type DashboardData = {
  activeYearLabel: string
  totalCollected: number
  totalPending: number
  studentCount: number
  todayCollection: number
  classStats: ClassStat[]
  routeStats: RouteStat[]
  recentPayments: RecentPayment[]
}

export default async function DashboardPage() {
  const supabase = await createClient()

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id, label')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) {
    return (
      <div className="p-6">
        <h1 className="text-2xl font-bold text-gray-900">Dashboard</h1>
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
      students!inner ( is_active ),
      classes!inner ( name, sort_order ),
      transport_routes ( name, fee_amount )
    `)
    .eq('academic_year_id', activeYear.id)

  const enrollments = enrollmentsRaw ?? []
  const enrollmentIds = enrollments.map(e => e.id)

  const [
    { data: feeStructure },
    { data: studentFees },
    { data: allPayments },
    { data: recentRaw },
  ] = await Promise.all([
    supabase
      .from('fee_structure')
      .select('class_id, fee_head, amount')
      .eq('academic_year_id', activeYear.id),
    enrollmentIds.length > 0
      ? supabase
          .from('student_fees')
          .select('enrollment_id, amount')
          .in('enrollment_id', enrollmentIds)
      : { data: [] as { enrollment_id: string; amount: number }[] },
    enrollmentIds.length > 0
      ? supabase
          .from('payments')
          .select('enrollment_id, amount, payment_date')
          .in('enrollment_id', enrollmentIds)
      : { data: [] as { enrollment_id: string; amount: number; payment_date: string }[] },
    enrollmentIds.length > 0
      ? supabase
          .from('payments')
          .select(`
            id, receipt_no, fee_head, amount, mode, payment_date,
            enrollments!inner ( students!inner ( adm_no, name ) )
          `)
          .in('enrollment_id', enrollmentIds)
          .order('payment_date', { ascending: false })
          .order('created_at', { ascending: false })
          .limit(10)
      : {
          data: [] as {
            id: string; receipt_no: string; fee_head: string; amount: number
            mode: string; payment_date: string
            enrollments: { students: { adm_no: string; name: string } }
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

  // enrollment_id → [{ amount }]
  const studentFeeMap = new Map<string, { amount: number }[]>()
  for (const sf of studentFees ?? []) {
    const list = studentFeeMap.get(sf.enrollment_id) ?? []
    list.push({ amount: Number(sf.amount) })
    studentFeeMap.set(sf.enrollment_id, list)
  }

  // enrollment_id → total paid; global totals
  const paymentTotalMap = new Map<string, number>()
  const today = new Date().toISOString().slice(0, 10)
  let totalCollected = 0
  let todayCollection = 0
  for (const p of allPayments ?? []) {
    const amt = Number(p.amount)
    paymentTotalMap.set(p.enrollment_id, (paymentTotalMap.get(p.enrollment_id) ?? 0) + amt)
    totalCollected += amt
    if (p.payment_date === today) todayCollection += amt
  }

  // Per-class and per-route aggregation
  const classStatsMap = new Map<string, ClassStat>()
  const routeStatsMap = new Map<string | null, RouteStat>()
  let studentCount = 0
  let totalPending = 0

  for (const e of enrollments) {
    const student = e.students as unknown as { is_active: boolean }
    if (!student.is_active) continue

    studentCount++

    const cls = e.classes as unknown as { name: string; sort_order: number }
    const route = e.transport_routes as unknown as { name: string; fee_amount: number } | null

    const classFees = classFeeMap.get(e.class_id) ?? { tuition: 0, book: 0 }
    const transportFee = route ? Number(route.fee_amount) : 0
    const totalPaid = paymentTotalMap.get(e.id) ?? 0

    const feeCalc = calcStudentFee({
      classFees: [{ amount: classFees.tuition }, { amount: classFees.book }].filter(f => f.amount > 0),
      studentFees: studentFeeMap.get(e.id) ?? [],
      transportFee,
      payments: totalPaid > 0 ? [{ amount: totalPaid }] : [],
    })

    totalPending += feeCalc.balance

    const classStat = classStatsMap.get(e.class_id) ?? {
      name: cls.name,
      sortOrder: cls.sort_order,
      totalFee: 0,
      collected: 0,
    }
    classStat.totalFee += feeCalc.totalFee
    classStat.collected += feeCalc.totalPaid
    classStatsMap.set(e.class_id, classStat)

    const routeKey = e.route_id ?? null
    const routeStat = routeStatsMap.get(routeKey) ?? {
      name: route?.name ?? 'No Route',
      studentCount: 0,
    }
    routeStat.studentCount++
    routeStatsMap.set(routeKey, routeStat)
  }

  const classStats: ClassStat[] = Array.from(classStatsMap.values())
    .sort((a, b) => a.sortOrder - b.sortOrder)

  const routeStats: RouteStat[] = Array.from(routeStatsMap.values())

  const recentPayments: RecentPayment[] = (recentRaw ?? []).map(p => {
    const enrollment = p.enrollments as unknown as {
      students: { adm_no: string; name: string }
    }
    return {
      id: p.id,
      receiptNo: p.receipt_no,
      studentName: enrollment.students.name,
      admNo: enrollment.students.adm_no,
      feeHead: p.fee_head,
      amount: Number(p.amount),
      mode: p.mode,
      paymentDate: p.payment_date,
    }
  })

  const data: DashboardData = {
    activeYearLabel: activeYear.label,
    totalCollected,
    totalPending,
    studentCount,
    todayCollection,
    classStats,
    routeStats,
    recentPayments,
  }

  return <DashboardClient data={data} />
}

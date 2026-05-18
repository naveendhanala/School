import { createClient } from '@/lib/supabase/server'
import { calcStudentFee } from '@/lib/utils/fee-calc'
import { buildClassFeeMap } from '@/lib/utils/fee-utils'
import { DashboardClient } from './dashboard-client'
import { NoActiveYear } from '@/components/no-active-year'

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
  reference: string | null
  remarks: string | null
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
  undepositedAmount: number
}

export default async function DashboardPage() {
  const supabase = await createClient()

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id, label')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) return <NoActiveYear title="Dashboard" />

  const [{ data: enrollmentsRaw }, { data: feeStructure }, { data: recentRaw }, { data: bankDepositsRaw }] =
    await Promise.all([
      supabase
        .from('enrollments')
        .select(`
          id,
          class_id,
          route_id,
          students!inner ( is_active ),
          classes!inner ( name, sort_order ),
          transport_routes ( name, fee_amount ),
          student_fees ( amount ),
          payments ( amount, payment_date )
        `)
        .eq('academic_year_id', activeYear.id),
      supabase
        .from('fee_structure')
        .select('class_id, fee_head, amount')
        .eq('academic_year_id', activeYear.id),
      supabase
        .from('payments')
        .select(`
          id, receipt_no, fee_head, amount, mode, payment_date, reference, remarks,
          enrollments!inner ( students!inner ( adm_no, name ) )
        `)
        .eq('enrollments.academic_year_id', activeYear.id)
        .order('payment_date', { ascending: false })
        .order('created_at', { ascending: false })
        .limit(10),
      supabase
        .from('bank_deposits')
        .select('amount')
        .eq('academic_year_id', activeYear.id),
    ])

  const enrollments = enrollmentsRaw ?? []

  const classFeeMap = buildClassFeeMap(feeStructure ?? [])

  // Per-class and per-route aggregation
  const classStatsMap = new Map<string, ClassStat>()
  const routeStatsMap = new Map<string | null, RouteStat>()
  let studentCount = 0
  let totalPending = 0
  const today = new Date().toISOString().slice(0, 10)
  let totalCollected = 0
  let todayCollection = 0

  for (const e of enrollments) {
    const student = e.students as unknown as { is_active: boolean }
    if (!student.is_active) continue

    studentCount++

    const cls = e.classes as unknown as { name: string; sort_order: number }
    const route = e.transport_routes as unknown as { name: string; fee_amount: number } | null
    const sf = (e.student_fees as unknown as { amount: number }[] | null) ?? []
    const pmts = (e.payments as unknown as { amount: number; payment_date: string }[] | null) ?? []

    const classFees = classFeeMap.get(e.class_id) ?? { tuition: 0, book: 0 }
    const transportFee = route ? Number(route.fee_amount) : 0

    for (const p of pmts) {
      const amt = Number(p.amount)
      totalCollected += amt
      if (p.payment_date === today) todayCollection += amt
    }

    const feeCalc = calcStudentFee({
      classFees: [{ amount: classFees.tuition }, { amount: classFees.book }].filter(f => f.amount > 0),
      studentFees: sf,
      transportFee,
      payments: pmts.map(p => ({ amount: Number(p.amount) })),
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
      reference: p.reference,
      remarks: p.remarks,
    }
  })

  const totalDeposited = (bankDepositsRaw ?? []).reduce((s, d) => s + Number(d.amount), 0)
  const undepositedAmount = totalCollected - totalDeposited

  const data: DashboardData = {
    activeYearLabel: activeYear.label,
    totalCollected,
    totalPending,
    studentCount,
    todayCollection,
    classStats,
    routeStats,
    recentPayments,
    undepositedAmount,
  }

  return <DashboardClient data={data} />
}

import { createClient } from '@/lib/supabase/server'
import { calcStudentFee } from '@/lib/utils/fee-calc'
import type { ClassFeeHead, FeeHead, PaymentMode } from '@/lib/types'
import { ReportsClient } from './reports-client'

export type ReportPayment = {
  id: string
  receiptNo: string
  paymentDate: string
  studentName: string
  admNo: string
  className: string
  feeHead: FeeHead
  mode: PaymentMode
  amount: number
  reference: string | null
}

export type MonthStat = {
  month: string
  label: string
  count: number
  cash: number
  upi: number
  cheque: number
  neft_rtgs: number
  demand_draft: number
  total: number
}

export type ReconciliationRow = {
  date: string
  collected: number
  deposited: number
  difference: number
}

export type ClasswiseRow = {
  name: string
  sortOrder: number
  studentCount: number
  totalFee: number
  collected: number
  pending: number
  percent: number
}

export type TransportwiseRow = {
  name: string
  studentCount: number
  totalFee: number
  collected: number
  pending: number
  percent: number
}

export type ReportsData = {
  activeYearLabel: string
  payments: ReportPayment[]
  monthStats: MonthStat[]
  reconciliation: ReconciliationRow[]
  classwiseStats: ClasswiseRow[]
  transportwiseStats: TransportwiseRow[]
}

function formatMonth(ym: string): string {
  const [y, m] = ym.split('-')
  const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
  return `${months[parseInt(m, 10) - 1]} ${y}`
}

export default async function ReportsPage() {
  const supabase = await createClient()

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id, label')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) {
    return (
      <div className="p-6">
        <h1 className="text-2xl font-bold text-gray-900">Reports</h1>
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
    { data: paymentsRaw },
    { data: depositsRaw },
    { data: feeStructure },
    { data: studentFees },
  ] = await Promise.all([
    enrollmentIds.length > 0
      ? supabase
          .from('payments')
          .select(`
            id, enrollment_id, receipt_no, fee_head, amount, mode, payment_date, reference,
            enrollments!inner (
              students!inner ( adm_no, name ),
              classes!inner ( name )
            )
          `)
          .in('enrollment_id', enrollmentIds)
          .order('payment_date', { ascending: false })
          .order('created_at', { ascending: false })
      : {
          data: [] as {
            id: string; enrollment_id: string; receipt_no: string; fee_head: string
            amount: number; mode: string; payment_date: string; reference: string | null
            enrollments: { students: { adm_no: string; name: string }; classes: { name: string } }
          }[],
        },
    supabase
      .from('bank_deposits')
      .select('amount, deposit_date')
      .eq('academic_year_id', activeYear.id),
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
  ])

  // payments list + paymentTotalMap in one pass
  const payments: ReportPayment[] = []
  const paymentTotalMap = new Map<string, number>()

  for (const p of paymentsRaw ?? []) {
    const enr = p.enrollments as unknown as {
      students: { adm_no: string; name: string }
      classes: { name: string }
    }
    payments.push({
      id: p.id,
      receiptNo: p.receipt_no,
      paymentDate: p.payment_date,
      studentName: enr.students.name,
      admNo: enr.students.adm_no,
      className: enr.classes.name,
      feeHead: p.fee_head as FeeHead,
      mode: p.mode as PaymentMode,
      amount: Number(p.amount),
      reference: p.reference,
    })
    paymentTotalMap.set(
      p.enrollment_id,
      (paymentTotalMap.get(p.enrollment_id) ?? 0) + Number(p.amount)
    )
  }

  // month stats
  const monthMap = new Map<string, MonthStat>()
  for (const p of payments) {
    const month = p.paymentDate.slice(0, 7)
    const stat = monthMap.get(month) ?? {
      month,
      label: formatMonth(month),
      count: 0,
      cash: 0, upi: 0, cheque: 0, neft_rtgs: 0, demand_draft: 0,
      total: 0,
    }
    stat.count++
    stat.total += p.amount
    ;(stat as unknown as Record<string, number>)[p.mode] += p.amount
    monthMap.set(month, stat)
  }
  const monthStats: MonthStat[] = Array.from(monthMap.values())
    .sort((a, b) => b.month.localeCompare(a.month))

  // reconciliation
  const collectedByDate = new Map<string, number>()
  for (const p of payments) {
    collectedByDate.set(p.paymentDate, (collectedByDate.get(p.paymentDate) ?? 0) + p.amount)
  }
  const depositedByDate = new Map<string, number>()
  for (const d of depositsRaw ?? []) {
    depositedByDate.set(
      d.deposit_date,
      (depositedByDate.get(d.deposit_date) ?? 0) + Number(d.amount)
    )
  }
  const allDates = new Set([...collectedByDate.keys(), ...depositedByDate.keys()])
  const reconciliation: ReconciliationRow[] = Array.from(allDates)
    .sort((a, b) => b.localeCompare(a))
    .map(date => ({
      date,
      collected: collectedByDate.get(date) ?? 0,
      deposited: depositedByDate.get(date) ?? 0,
      difference: (collectedByDate.get(date) ?? 0) - (depositedByDate.get(date) ?? 0),
    }))

  // class-wise + transport-wise
  const classFeeMap = new Map<string, Record<ClassFeeHead, number>>()
  for (const fs of feeStructure ?? []) {
    const entry = classFeeMap.get(fs.class_id) ?? { tuition: 0, book: 0 }
    ;(entry as Record<string, number>)[fs.fee_head] = Number(fs.amount)
    classFeeMap.set(fs.class_id, entry)
  }

  const studentFeeMap = new Map<string, { amount: number }[]>()
  for (const sf of studentFees ?? []) {
    const list = studentFeeMap.get(sf.enrollment_id) ?? []
    list.push({ amount: Number(sf.amount) })
    studentFeeMap.set(sf.enrollment_id, list)
  }

  const classStatsMap = new Map<string, ClasswiseRow>()
  const routeStatsMap = new Map<string | null, TransportwiseRow>()

  for (const e of enrollments) {
    const student = e.students as unknown as { is_active: boolean }
    if (!student.is_active) continue

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

    const classStat = classStatsMap.get(e.class_id) ?? {
      name: cls.name, sortOrder: cls.sort_order,
      studentCount: 0, totalFee: 0, collected: 0, pending: 0, percent: 0,
    }
    classStat.studentCount++
    classStat.totalFee += feeCalc.totalFee
    classStat.collected += feeCalc.totalPaid
    classStat.pending += feeCalc.balance
    classStatsMap.set(e.class_id, classStat)

    const routeKey = e.route_id ?? null
    const routeStat = routeStatsMap.get(routeKey) ?? {
      name: route?.name ?? 'No Route',
      studentCount: 0, totalFee: 0, collected: 0, pending: 0, percent: 0,
    }
    routeStat.studentCount++
    routeStat.totalFee += feeCalc.totalFee
    routeStat.collected += feeCalc.totalPaid
    routeStat.pending += feeCalc.balance
    routeStatsMap.set(routeKey, routeStat)
  }

  const classwiseStats: ClasswiseRow[] = Array.from(classStatsMap.values())
    .sort((a, b) => a.sortOrder - b.sortOrder)
    .map(r => ({
      ...r,
      percent: r.totalFee > 0 ? Math.round((r.collected / r.totalFee) * 100) : 0,
    }))

  const transportwiseStats: TransportwiseRow[] = Array.from(routeStatsMap.values())
    .map(r => ({
      ...r,
      percent: r.totalFee > 0 ? Math.round((r.collected / r.totalFee) * 100) : 0,
    }))

  return (
    <ReportsClient
      data={{
        activeYearLabel: activeYear.label,
        payments,
        monthStats,
        reconciliation,
        classwiseStats,
        transportwiseStats,
      }}
    />
  )
}

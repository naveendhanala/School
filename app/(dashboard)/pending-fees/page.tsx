import { createClient } from '@/lib/supabase/server'
import { calcStudentFee } from '@/lib/utils/fee-calc'
import { buildClassFeeMap } from '@/lib/utils/fee-utils'
import { PendingFeesClient } from './pending-fees-client'
import { NoActiveYear } from '@/components/no-active-year'

export type PendingRow = {
  enrollmentId: string
  admNo: string
  name: string
  mobile: string | null
  village: string | null
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

  if (!activeYear) return <NoActiveYear title="Pending Fees" />

  const [{ data: enrollmentsRaw }, { data: feeStructure }, { data: classes }, { data: routes }] =
    await Promise.all([
      supabase
        .from('enrollments')
        .select(`
          id,
          class_id,
          route_id,
          students!inner ( adm_no, name, is_active, mobile, village ),
          classes!inner ( name ),
          transport_routes ( name, fee_amount ),
          student_fees ( fee_head, amount ),
          payments ( amount )
        `)
        .eq('academic_year_id', activeYear.id),
      supabase
        .from('fee_structure')
        .select('class_id, fee_head, amount')
        .eq('academic_year_id', activeYear.id),
      supabase.from('classes').select('id, name').order('sort_order'),
      supabase.from('transport_routes').select('id, name').order('name'),
    ])

  const enrollments = enrollmentsRaw ?? []

  const classFeeMap = buildClassFeeMap(feeStructure ?? [])

  const rows: PendingRow[] = enrollments
    .filter(e => {
      const student = e.students as unknown as { is_active: boolean }
      return student.is_active
    })
    .map(e => {
      const student = e.students as unknown as { adm_no: string; name: string; mobile: string | null; village: string | null }
      const cls = e.classes as unknown as { name: string }
      const route = e.transport_routes as unknown as { name: string; fee_amount: number } | null
      const sf = (e.student_fees as unknown as { fee_head: string; amount: number }[] | null) ?? []
      const pmts = (e.payments as unknown as { amount: number }[] | null) ?? []

      const classFees = classFeeMap.get(e.class_id) ?? { tuition: 0, book: 0 }
      const transportFee = route ? Number(route.fee_amount) : 0

      const feeCalc = calcStudentFee({
        classFees: [{ amount: classFees.tuition }, { amount: classFees.book }].filter(f => f.amount > 0),
        studentFees: sf.map(s => ({ amount: Number(s.amount) })),
        transportFee,
        payments: pmts.map(p => ({ amount: Number(p.amount) })),
      })

      return {
        enrollmentId: e.id,
        admNo: student.adm_no,
        name: student.name,
        mobile: student.mobile,
        village: student.village,
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

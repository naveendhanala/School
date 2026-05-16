import { createClient } from '@/lib/supabase/server'
import { calcStudentFee } from '@/lib/utils/fee-calc'
import type { Gender } from '@/lib/types'

export interface StudentRow {
  id: string
  admNo: string
  name: string
  gender: Gender
  village: string | null
  mobile: string | null
  isActive: boolean
  className: string
  classId: string
  routeName: string | null
  routeId: string | null
  enrollmentId: string
  totalFee: number
  totalPaid: number
  balance: number
  status: 'paid' | 'partial' | 'unpaid'
}

export default async function StudentsPage() {
  const supabase = await createClient()

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id, label')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) {
    return (
      <div className="p-6">
        <h1 className="text-2xl font-bold text-gray-900">Students</h1>
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
      students!inner ( id, adm_no, name, gender, village, mobile, is_active ),
      classes!inner ( name ),
      transport_routes ( name, fee_amount )
    `)
    .eq('academic_year_id', activeYear.id)

  const enrollments = enrollmentsRaw ?? []
  const enrollmentIds = enrollments.map(e => e.id)

  const { data: feeStructure } = await supabase
    .from('fee_structure')
    .select('class_id, amount')
    .eq('academic_year_id', activeYear.id)

  const [{ data: studentFees }, { data: payments }] = await Promise.all([
    enrollmentIds.length > 0
      ? supabase.from('student_fees').select('enrollment_id, amount').in('enrollment_id', enrollmentIds)
      : { data: [] as { enrollment_id: string; amount: number }[] },
    enrollmentIds.length > 0
      ? supabase.from('payments').select('enrollment_id, amount').in('enrollment_id', enrollmentIds)
      : { data: [] as { enrollment_id: string; amount: number }[] },
  ])

  // class_id → [{ amount }]
  const classFeeMap = new Map<string, { amount: number }[]>()
  for (const fs of feeStructure ?? []) {
    const list = classFeeMap.get(fs.class_id) ?? []
    list.push({ amount: Number(fs.amount) })
    classFeeMap.set(fs.class_id, list)
  }

  // enrollment_id → [{ amount }]
  const studentFeeMap = new Map<string, { amount: number }[]>()
  for (const sf of studentFees ?? []) {
    const list = studentFeeMap.get(sf.enrollment_id) ?? []
    list.push({ amount: Number(sf.amount) })
    studentFeeMap.set(sf.enrollment_id, list)
  }

  const paymentMap = new Map<string, { amount: number }[]>()
  for (const p of payments ?? []) {
    const list = paymentMap.get(p.enrollment_id) ?? []
    list.push({ amount: Number(p.amount) })
    paymentMap.set(p.enrollment_id, list)
  }

  const rows: StudentRow[] = enrollments.map(e => {
    const student = e.students as unknown as {
      id: string; adm_no: string; name: string; gender: string
      village: string | null; mobile: string | null; is_active: boolean
    }
    const cls = e.classes as unknown as { name: string }
    const route = e.transport_routes as unknown as { name: string; fee_amount: number } | null

    const feeCalc = calcStudentFee({
      classFees: classFeeMap.get(e.class_id) ?? [],
      studentFees: studentFeeMap.get(e.id) ?? [],
      transportFee: route ? Number(route.fee_amount) : 0,
      payments: paymentMap.get(e.id) ?? [],
    })

    return {
      id: student.id,
      admNo: student.adm_no,
      name: student.name,
      gender: student.gender as Gender,
      village: student.village,
      mobile: student.mobile,
      isActive: student.is_active,
      className: cls.name,
      classId: e.class_id,
      routeName: route?.name ?? null,
      routeId: e.route_id,
      enrollmentId: e.id,
      ...feeCalc,
    }
  })

  const { data: classes } = await supabase
    .from('classes')
    .select('id, name')
    .order('sort_order')

  const { data: routes } = await supabase
    .from('transport_routes')
    .select('id, name')
    .order('name')

  // Suggested next admission number
  const { data: allStudents } = await supabase.from('students').select('adm_no')
  const nums = (allStudents ?? []).map(s => parseInt(s.adm_no, 10)).filter(n => !isNaN(n))
  const suggestedAdmNo = nums.length === 0 ? '1' : String(Math.max(...nums) + 1)

  // StudentsClient will be wired in Task 10
  return (
    <div className="p-6">
      <p className="text-gray-400 text-sm">Students client loading… (Task 10 will complete this)</p>
      <pre className="text-xs text-gray-300">{JSON.stringify({ rowCount: rows.length, activeYear: activeYear.label }, null, 2)}</pre>
    </div>
  )
  // Task 10 replaces the above return with:
  // return (
  //   <StudentsClient
  //     rows={rows}
  //     classes={classes ?? []}
  //     routes={routes ?? []}
  //     activeYearLabel={activeYear.label}
  //     suggestedAdmNo={suggestedAdmNo}
  //   />
  // )
}

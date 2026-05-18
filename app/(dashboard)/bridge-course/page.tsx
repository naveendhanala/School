import { createClient } from '@/lib/supabase/server'
import type { Course, Gender } from '@/lib/types'
import { BridgeCourseClient } from './bridge-course-client'
import { NoActiveYear } from '@/components/no-active-year'

export type BridgeStudentRow = {
  id: string
  voucherNo: string
  name: string
  course: Course
  gender: Gender
  phone: string | null
  totalFee: number
  cash: number
  phonepe: number
  hdfc: number
  totalPaid: number
  balance: number
  status: 'paid' | 'partial' | 'unpaid'
}

export type BridgeDepositRow = {
  id: string
  bankName: string
  amount: number
  depositDate: string
  reference: string | null
  createdAt: string
}

export default async function BridgeCoursePage() {
  const supabase = await createClient()

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id, label')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) return <NoActiveYear title="Bridge Course" />

  const { data: studentsRaw } = await supabase
    .from('bridge_students')
    .select('id, voucher_no, name, course, gender, phone, total_fee')
    .eq('academic_year_id', activeYear.id)
    .order('voucher_no')

  const students = studentsRaw ?? []
  const studentIds = students.map(s => s.id)

  const [{ data: paymentsRaw }, { data: depositsRaw }] = await Promise.all([
    studentIds.length > 0
      ? supabase
          .from('bridge_payments')
          .select('bridge_student_id, mode, amount')
          .in('bridge_student_id', studentIds)
      : { data: [] as { bridge_student_id: string; mode: string; amount: number }[] },
    supabase
      .from('bridge_deposits')
      .select('id, bank_name, amount, deposit_date, reference, created_at')
      .eq('academic_year_id', activeYear.id)
      .order('deposit_date', { ascending: false })
      .order('created_at', { ascending: false }),
  ])

  const paymentMap = new Map<string, { cash: number; phonepe: number; hdfc: number }>()
  for (const p of paymentsRaw ?? []) {
    const entry = paymentMap.get(p.bridge_student_id) ?? { cash: 0, phonepe: 0, hdfc: 0 }
    if (p.mode === 'cash') entry.cash += Number(p.amount)
    else if (p.mode === 'phonepe') entry.phonepe += Number(p.amount)
    else if (p.mode === 'hdfc') entry.hdfc += Number(p.amount)
    paymentMap.set(p.bridge_student_id, entry)
  }

  const bridgeStudents: BridgeStudentRow[] = students.map(s => {
    const modes = paymentMap.get(s.id) ?? { cash: 0, phonepe: 0, hdfc: 0 }
    const totalPaid = modes.cash + modes.phonepe + modes.hdfc
    const balance = Number(s.total_fee) - totalPaid
    const status: BridgeStudentRow['status'] =
      balance <= 0 ? 'paid' : totalPaid > 0 ? 'partial' : 'unpaid'
    return {
      id: s.id,
      voucherNo: s.voucher_no,
      name: s.name,
      course: s.course as Course,
      gender: s.gender as Gender,
      phone: s.phone,
      totalFee: Number(s.total_fee),
      cash: modes.cash,
      phonepe: modes.phonepe,
      hdfc: modes.hdfc,
      totalPaid,
      balance: Math.max(0, balance),
      status,
    }
  })

  const deposits: BridgeDepositRow[] = (depositsRaw ?? []).map(d => ({
    id: d.id,
    bankName: d.bank_name,
    amount: Number(d.amount),
    depositDate: d.deposit_date,
    reference: d.reference,
    createdAt: d.created_at,
  }))

  return (
    <BridgeCourseClient
      students={bridgeStudents}
      deposits={deposits}
      activeYearLabel={activeYear.label}
    />
  )
}

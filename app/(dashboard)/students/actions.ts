'use server'

import { revalidatePath } from 'next/cache'
import { createClient } from '@/lib/supabase/server'
import type { Gender } from '@/lib/types'
import type { SupabaseClient } from '@supabase/supabase-js'
import type { Database } from '@/lib/types'

async function generateAdmNo(
  supabase: SupabaseClient<Database>
): Promise<string> {
  const { data } = await supabase.from('students').select('adm_no')
  if (!data || data.length === 0) return '1'
  const nums = data.map(s => parseInt(s.adm_no, 10)).filter(n => !isNaN(n))
  return nums.length === 0 ? '1' : String(Math.max(...nums) + 1)
}

export async function createStudent(formData: {
  name: string
  gender: Gender
  village: string
  mobile: string
  classId: string
  routeId: string | null
  admNo: string
}) {
  const supabase = await createClient()

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) throw new Error('No active academic year')

  const admNo = formData.admNo.trim() || (await generateAdmNo(supabase))

  const { data: student, error: studentError } = await supabase
    .from('students')
    .insert({
      adm_no: admNo,
      name: formData.name,
      gender: formData.gender,
      village: formData.village || null,
      mobile: formData.mobile || null,
      is_active: true,
    })
    .select('id')
    .single()

  if (studentError) throw new Error(studentError.message)

  const { error: enrollError } = await supabase.from('enrollments').insert({
    student_id: student.id,
    academic_year_id: activeYear.id,
    class_id: formData.classId,
    route_id: formData.routeId || null,
  })

  if (enrollError) throw new Error(enrollError.message)

  revalidatePath('/students')
}

export async function updateStudent(
  studentId: string,
  enrollmentId: string,
  formData: {
    name: string
    gender: Gender
    village: string
    mobile: string
    classId: string
    routeId: string | null
  }
) {
  const supabase = await createClient()

  const { error: studentError } = await supabase
    .from('students')
    .update({
      name: formData.name,
      gender: formData.gender,
      village: formData.village || null,
      mobile: formData.mobile || null,
    })
    .eq('id', studentId)

  if (studentError) throw new Error(studentError.message)

  const { error: enrollError } = await supabase
    .from('enrollments')
    .update({
      class_id: formData.classId,
      route_id: formData.routeId || null,
    })
    .eq('id', enrollmentId)

  if (enrollError) throw new Error(enrollError.message)

  revalidatePath('/students')
}

export async function deactivateStudent(studentId: string) {
  const supabase = await createClient()
  const { error } = await supabase
    .from('students')
    .update({ is_active: false })
    .eq('id', studentId)
  if (error) throw new Error(error.message)
  revalidatePath('/students')
}

export async function getStudentPaymentHistory(enrollmentId: string): Promise<{
  id: string
  receiptNo: string
  paymentDate: string
  feeHead: string
  mode: string
  amount: number
  reference: string | null
}[]> {
  const supabase = await createClient()
  const { data } = await supabase
    .from('payments')
    .select('id, receipt_no, payment_date, fee_head, mode, amount, reference')
    .eq('enrollment_id', enrollmentId)
    .order('payment_date', { ascending: false })
    .order('created_at', { ascending: false })
  return (data ?? []).map(p => ({
    id: p.id,
    receiptNo: p.receipt_no,
    paymentDate: p.payment_date,
    feeHead: p.fee_head,
    mode: p.mode,
    amount: Number(p.amount),
    reference: p.reference,
  }))
}

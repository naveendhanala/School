'use server'

import { revalidatePath } from 'next/cache'
import { createClient } from '@/lib/supabase/server'
import type { Course, Gender, BridgePaymentMode } from '@/lib/types'

export async function addBridgeStudent(input: {
  voucherNo: string
  name: string
  course: Course
  gender: Gender
  phone: string | null
  totalFee: number
}): Promise<{ error?: string }> {
  const supabase = await createClient()

  if (!input.voucherNo.trim()) return { error: 'Voucher number is required' }
  if (!input.name.trim()) return { error: 'Name is required' }
  if (!Number.isFinite(input.totalFee) || input.totalFee <= 0) {
    return { error: 'Total fee must be greater than 0' }
  }

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) return { error: 'No active academic year' }

  const { error } = await supabase.from('bridge_students').insert({
    academic_year_id: activeYear.id,
    voucher_no: input.voucherNo.trim(),
    name: input.name.trim(),
    course: input.course,
    gender: input.gender,
    phone: input.phone?.trim() || null,
    total_fee: input.totalFee,
  })

  if (error) return { error: error.message }

  revalidatePath('/bridge-course')
  return {}
}

export async function recordBridgePayment(input: {
  studentId: string
  mode: BridgePaymentMode
  amount: number
}): Promise<{ error?: string }> {
  const supabase = await createClient()

  if (!Number.isFinite(input.amount) || input.amount <= 0) {
    return { error: 'Amount must be greater than 0' }
  }

  const { error } = await supabase.from('bridge_payments').insert({
    bridge_student_id: input.studentId,
    mode: input.mode,
    amount: input.amount,
  })

  if (error) return { error: error.message }

  revalidatePath('/bridge-course')
  return {}
}

export async function deleteBridgeStudent(id: string): Promise<{ error?: string }> {
  const supabase = await createClient()
  const { error } = await supabase.from('bridge_students').delete().eq('id', id)
  if (error) return { error: error.message }
  revalidatePath('/bridge-course')
  return {}
}

export async function addBridgeDeposit(input: {
  bankName: string
  amount: number
  depositDate: string
  reference: string | null
}): Promise<{ error?: string }> {
  const supabase = await createClient()

  if (!input.bankName.trim()) return { error: 'Bank name is required' }
  if (!Number.isFinite(input.amount) || input.amount <= 0) {
    return { error: 'Amount must be greater than 0' }
  }

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) return { error: 'No active academic year' }

  const { error } = await supabase.from('bridge_deposits').insert({
    academic_year_id: activeYear.id,
    bank_name: input.bankName.trim(),
    amount: input.amount,
    deposit_date: input.depositDate,
    reference: input.reference?.trim() || null,
  })

  if (error) return { error: error.message }

  revalidatePath('/bridge-course')
  return {}
}

export async function deleteBridgeDeposit(id: string): Promise<{ error?: string }> {
  const supabase = await createClient()
  const { error } = await supabase.from('bridge_deposits').delete().eq('id', id)
  if (error) return { error: error.message }
  revalidatePath('/bridge-course')
  return {}
}

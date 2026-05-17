'use server'

import { revalidatePath } from 'next/cache'
import { createClient } from '@/lib/supabase/server'

export async function upsertClassFee(
  academicYearId: string,
  classId: string,
  feeHead: 'tuition' | 'book',
  amount: number
) {
  const supabase = await createClient()
  const { error } = await supabase
    .from('fee_structure')
    .upsert(
      { academic_year_id: academicYearId, class_id: classId, fee_head: feeHead, amount },
      { onConflict: 'academic_year_id,class_id,fee_head' }
    )
  if (error) throw new Error(error.message)
  revalidatePath('/fee-setup')
}

export async function upsertTransportRoute(
  id: string | null,
  name: string,
  feeAmount: number
) {
  const supabase = await createClient()
  if (id) {
    const { error } = await supabase
      .from('transport_routes')
      .update({ name, fee_amount: feeAmount })
      .eq('id', id)
    if (error) throw new Error(error.message)
  } else {
    const { error } = await supabase
      .from('transport_routes')
      .insert({ name, fee_amount: feeAmount })
    if (error) throw new Error(error.message)
  }
  revalidatePath('/fee-setup')
}

export async function deleteTransportRoute(id: string) {
  const supabase = await createClient()
  const { error } = await supabase
    .from('transport_routes')
    .delete()
    .eq('id', id)
  if (error) {
    if (error.code === '23503') {
      throw new Error('This route has enrolled students and cannot be deleted.')
    }
    throw new Error(error.message)
  }
  revalidatePath('/fee-setup')
}

export async function createAcademicYear(label: string): Promise<{ error?: string }> {
  const supabase = await createClient()
  if (!label.trim()) return { error: 'Label is required' }
  const { error } = await supabase
    .from('academic_years')
    .insert({ label: label.trim(), is_active: false })
  if (error) return { error: error.message }
  revalidatePath('/fee-setup')
  return {}
}

export async function setActiveYear(id: string): Promise<{ error?: string }> {
  const supabase = await createClient()
  const { error: e1 } = await supabase
    .from('academic_years')
    .update({ is_active: false })
    .eq('is_active', true)
  if (e1) return { error: e1.message }
  const { error: e2 } = await supabase
    .from('academic_years')
    .update({ is_active: true })
    .eq('id', id)
  if (e2) return { error: e2.message }
  revalidatePath('/fee-setup')
  revalidatePath('/')
  revalidatePath('/students')
  revalidatePath('/collect-fee')
  revalidatePath('/pending-fees')
  revalidatePath('/reports')
  revalidatePath('/bank-deposits')
  revalidatePath('/bridge-course')
  return {}
}

export async function resetActiveYearPayments(yearId: string): Promise<{ error?: string }> {
  const supabase = await createClient()
  const { error } = await supabase.rpc('reset_active_year_payments', { year_id: yearId })
  if (error) return { error: error.message }
  revalidatePath('/')
  revalidatePath('/collect-fee')
  revalidatePath('/pending-fees')
  revalidatePath('/reports')
  revalidatePath('/bank-deposits')
  revalidatePath('/bridge-course')
  revalidatePath('/fee-setup')
  return {}
}

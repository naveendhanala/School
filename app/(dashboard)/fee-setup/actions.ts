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

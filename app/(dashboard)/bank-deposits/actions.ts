'use server'

import { revalidatePath } from 'next/cache'
import { createClient } from '@/lib/supabase/server'

export async function createDeposit(input: {
  bankName: string
  accountNo: string
  amount: number
  depositDate: string
  reference: string | null
  remarks: string | null
}): Promise<{ error?: string }> {
  const supabase = await createClient()

  if (!input.bankName.trim()) return { error: 'Bank name is required' }
  if (!input.accountNo.trim()) return { error: 'Account number is required' }
  if (!Number.isFinite(input.amount) || input.amount <= 0) {
    return { error: 'Amount must be greater than 0' }
  }

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) return { error: 'No active academic year' }

  const { error: insertError } = await supabase.from('bank_deposits').insert({
    academic_year_id: activeYear.id,
    bank_name: input.bankName.trim(),
    account_no: input.accountNo.trim(),
    amount: input.amount,
    deposit_date: input.depositDate,
    reference: input.reference,
    remarks: input.remarks,
  })

  if (insertError) return { error: insertError.message }

  revalidatePath('/bank-deposits')
  revalidatePath('/')
  return {}
}

export async function deleteDeposit(id: string): Promise<{ error?: string }> {
  const supabase = await createClient()

  const { error } = await supabase.from('bank_deposits').delete().eq('id', id)

  if (error) return { error: error.message }

  revalidatePath('/bank-deposits')
  revalidatePath('/')
  return {}
}

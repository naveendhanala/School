'use server'

import { revalidatePath } from 'next/cache'
import { createClient } from '@/lib/supabase/server'
import type { FeeHead, PaymentMode } from '@/lib/types'

export async function recordPayment(input: {
  enrollmentId: string
  feeHead: FeeHead
  amount: number
  mode: PaymentMode
  paymentDate: string
  reference: string | null
  remarks: string | null
}): Promise<{ paymentId: string } | { error: string }> {
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return { error: 'Not authenticated' }

  if (!Number.isFinite(input.amount) || input.amount <= 0) {
    return { error: 'Amount must be greater than 0' }
  }

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) return { error: 'No active academic year' }

  const { data: receiptNo, error: rpcError } = await supabase.rpc('next_receipt_number', {
    year_id: activeYear.id,
  })

  if (rpcError || !receiptNo) {
    return { error: rpcError?.message ?? 'Failed to generate receipt number' }
  }

  const { data: payment, error: insertError } = await supabase
    .from('payments')
    .insert({
      enrollment_id: input.enrollmentId,
      fee_head: input.feeHead,
      amount: input.amount,
      mode: input.mode,
      payment_date: input.paymentDate,
      reference: input.reference,
      receipt_no: receiptNo as string,
      remarks: input.remarks,
      created_by: user.id,
    })
    .select('id')
    .single()

  if (insertError || !payment) {
    return { error: insertError?.message ?? 'Failed to record payment' }
  }

  revalidatePath('/collect-fee')
  revalidatePath('/pending-fees')
  revalidatePath('/students')

  return { paymentId: payment.id }
}

export async function editPayment(
  paymentId: string,
  updates: {
    amount?: number
    mode?: PaymentMode
    payment_date?: string
    fee_head?: FeeHead
    reference?: string | null
    remarks?: string | null
  },
  reason: string
): Promise<{ error?: string }> {
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return { error: 'Not authenticated' }

  const { data: current, error: fetchError } = await supabase
    .from('payments')
    .select('amount, mode, payment_date, fee_head, reference, remarks')
    .eq('id', paymentId)
    .single()

  if (fetchError || !current) return { error: fetchError?.message ?? 'Payment not found' }

  const { error: updateError } = await supabase
    .from('payments')
    .update(updates)
    .eq('id', paymentId)

  if (updateError) return { error: updateError.message }

  const { error: auditError } = await supabase.from('payment_edits').insert({
    payment_id: paymentId,
    edited_by: user.id,
    reason,
    old_amount: 'amount' in updates ? current.amount : null,
    new_amount: 'amount' in updates ? (updates.amount ?? null) : null,
    old_mode: 'mode' in updates ? current.mode : null,
    new_mode: 'mode' in updates ? (updates.mode ?? null) : null,
    old_payment_date: 'payment_date' in updates ? current.payment_date : null,
    new_payment_date: 'payment_date' in updates ? (updates.payment_date ?? null) : null,
    old_fee_head: 'fee_head' in updates ? current.fee_head : null,
    new_fee_head: 'fee_head' in updates ? (updates.fee_head ?? null) : null,
    old_reference: 'reference' in updates ? current.reference : null,
    new_reference: 'reference' in updates ? (updates.reference ?? null) : null,
    old_remarks: 'remarks' in updates ? current.remarks : null,
    new_remarks: 'remarks' in updates ? (updates.remarks ?? null) : null,
  })

  if (auditError) return { error: auditError.message }

  revalidatePath('/')
  revalidatePath('/collect-fee')
  revalidatePath('/reports')

  return {}
}

export async function deletePayment(paymentId: string): Promise<{ error?: string }> {
  const supabase = await createClient()

  const { error } = await supabase.from('payments').delete().eq('id', paymentId)
  if (error) return { error: error.message }

  revalidatePath('/')
  revalidatePath('/collect-fee')
  revalidatePath('/reports')

  return {}
}

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

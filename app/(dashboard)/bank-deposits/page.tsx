import { createClient } from '@/lib/supabase/server'
import { BankDepositsClient } from './bank-deposits-client'

export type DepositRow = {
  id: string
  bankName: string
  accountNo: string
  amount: number
  depositDate: string
  reference: string | null
  remarks: string | null
  createdAt: string
}

export default async function BankDepositsPage() {
  const supabase = await createClient()

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id, label')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) {
    return (
      <div className="p-6">
        <h1 className="text-2xl font-bold text-gray-900">Bank Deposits</h1>
        <p className="mt-2 text-gray-500">No active academic year. Set one up in Fee Setup.</p>
      </div>
    )
  }

  const [{ data: depositsRaw }, { data: paymentsRaw }] = await Promise.all([
    supabase
      .from('bank_deposits')
      .select('id, bank_name, account_no, amount, deposit_date, reference, remarks, created_at')
      .eq('academic_year_id', activeYear.id)
      .order('deposit_date', { ascending: false })
      .order('created_at', { ascending: false }),
    supabase
      .from('payments')
      .select('amount, enrollments!inner(academic_year_id)')
      .eq('enrollments.academic_year_id', activeYear.id),
  ])

  const deposits: DepositRow[] = (depositsRaw ?? []).map(d => ({
    id: d.id,
    bankName: d.bank_name,
    accountNo: d.account_no,
    amount: Number(d.amount),
    depositDate: d.deposit_date,
    reference: d.reference,
    remarks: d.remarks,
    createdAt: d.created_at,
  }))

  const totalCollected = (paymentsRaw ?? []).reduce((s, p) => s + Number(p.amount), 0)
  const paymentCount   = (paymentsRaw ?? []).length

  return (
    <BankDepositsClient
      deposits={deposits}
      activeYearLabel={activeYear.label}
      totalCollected={totalCollected}
      paymentCount={paymentCount}
    />
  )
}

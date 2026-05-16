export type PaymentStatus = 'paid' | 'partial' | 'unpaid'

export interface FeeCalcInput {
  classFees: { amount: number }[]
  studentFees: { amount: number }[]
  transportFee: number
  payments: { amount: number }[]
}

export interface FeeCalcResult {
  totalFee: number
  totalPaid: number
  balance: number
  status: PaymentStatus
}

export function calcStudentFee(input: FeeCalcInput): FeeCalcResult {
  const totalFee =
    input.classFees.reduce((s, f) => s + f.amount, 0) +
    input.studentFees.reduce((s, f) => s + f.amount, 0) +
    input.transportFee

  const totalPaid = input.payments.reduce((s, p) => s + p.amount, 0)
  const balance = totalFee - totalPaid

  let status: PaymentStatus
  if (totalFee === 0 || totalPaid >= totalFee) {
    status = 'paid'
  } else if (totalPaid > 0) {
    status = 'partial'
  } else {
    status = 'unpaid'
  }

  return { totalFee, totalPaid, balance, status }
}

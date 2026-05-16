import { describe, it, expect } from 'vitest'
import { calcStudentFee } from '../fee-calc'

describe('calcStudentFee', () => {
  const base = {
    classFees: [{ amount: 10000 }, { amount: 2000 }],
    studentFees: [],
    transportFee: 0,
    payments: [],
  }

  it('returns unpaid status when no payments made', () => {
    const result = calcStudentFee(base)
    expect(result).toEqual({ totalFee: 12000, totalPaid: 0, balance: 12000, status: 'unpaid' })
  })

  it('returns partial status when some payment made', () => {
    const result = calcStudentFee({ ...base, payments: [{ amount: 5000 }] })
    expect(result).toEqual({ totalFee: 12000, totalPaid: 5000, balance: 7000, status: 'partial' })
  })

  it('returns paid status when fully paid', () => {
    const result = calcStudentFee({ ...base, payments: [{ amount: 12000 }] })
    expect(result).toEqual({ totalFee: 12000, totalPaid: 12000, balance: 0, status: 'paid' })
  })

  it('returns paid status when total fee is zero', () => {
    const result = calcStudentFee({ classFees: [], studentFees: [], transportFee: 0, payments: [] })
    expect(result).toEqual({ totalFee: 0, totalPaid: 0, balance: 0, status: 'paid' })
  })

  it('includes transport fee in total', () => {
    const result = calcStudentFee({ ...base, transportFee: 3000 })
    expect(result.totalFee).toBe(15000)
    expect(result.balance).toBe(15000)
  })

  it('includes student fees in total', () => {
    const result = calcStudentFee({ ...base, studentFees: [{ amount: 5000 }] })
    expect(result.totalFee).toBe(17000)
  })

  it('sums multiple payments correctly', () => {
    const result = calcStudentFee({ ...base, payments: [{ amount: 3000 }, { amount: 4000 }] })
    expect(result.totalPaid).toBe(7000)
    expect(result.status).toBe('partial')
  })
})

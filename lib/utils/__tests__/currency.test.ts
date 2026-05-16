import { describe, it, expect } from 'vitest'
import { formatCurrency } from '../currency'

describe('formatCurrency', () => {
  it('formats zero', () => {
    expect(formatCurrency(0)).toBe('₹0.00')
  })

  it('formats three-digit amount', () => {
    expect(formatCurrency(500)).toBe('₹500.00')
  })

  it('formats four-digit amount with comma', () => {
    expect(formatCurrency(1000)).toBe('₹1,000.00')
  })

  it('formats decimal correctly', () => {
    expect(formatCurrency(1234.5)).toBe('₹1,234.50')
  })

  it('formats large amount with Indian grouping (1,00,000)', () => {
    expect(formatCurrency(100000)).toBe('₹1,00,000.00')
  })

  it('formats very large amount', () => {
    expect(formatCurrency(10000000)).toBe('₹1,00,00,000.00')
  })

  it('rounds to two decimal places', () => {
    expect(formatCurrency(99.999)).toBe('₹100.00')
  })
})

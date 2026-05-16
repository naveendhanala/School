import { describe, it, expect } from 'vitest'
import { formatReceiptNo } from '../receipt'

describe('formatReceiptNo', () => {
  it('pads sequence to 6 digits', () => {
    expect(formatReceiptNo('2025-26', 1)).toBe('2025-26-000001')
  })

  it('handles large sequence numbers', () => {
    expect(formatReceiptNo('2025-26', 999999)).toBe('2025-26-999999')
  })

  it('uses correct year label', () => {
    expect(formatReceiptNo('2024-25', 42)).toBe('2024-25-000042')
  })

  it('handles three-digit sequence', () => {
    expect(formatReceiptNo('2025-26', 100)).toBe('2025-26-000100')
  })
})

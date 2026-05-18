import { describe, test, expect } from 'vitest'
import { buildClassFeeMap } from '@/lib/utils/fee-utils'

describe('buildClassFeeMap', () => {
  test('maps tuition and book amounts by class_id', () => {
    const rows = [
      { class_id: 'c1', fee_head: 'tuition', amount: '5000' },
      { class_id: 'c1', fee_head: 'book', amount: '500' },
      { class_id: 'c2', fee_head: 'tuition', amount: '4000' },
    ]
    const map = buildClassFeeMap(rows)
    expect(map.get('c1')).toEqual({ tuition: 5000, book: 500 })
    expect(map.get('c2')).toEqual({ tuition: 4000, book: 0 })
  })

  test('defaults missing fee_heads to 0', () => {
    const rows = [{ class_id: 'c1', fee_head: 'book', amount: 300 }]
    const map = buildClassFeeMap(rows)
    expect(map.get('c1')).toEqual({ tuition: 0, book: 300 })
  })

  test('returns empty map for empty input', () => {
    expect(buildClassFeeMap([]).size).toBe(0)
  })

  test('converts string amounts to numbers', () => {
    const rows = [{ class_id: 'c1', fee_head: 'tuition', amount: '1500.50' }]
    const map = buildClassFeeMap(rows)
    expect(map.get('c1')!.tuition).toBe(1500.5)
  })
})

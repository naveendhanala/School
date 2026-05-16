import { describe, it, expect } from 'vitest'
import { getNextClassName, isGraduating } from '../promotion'

describe('getNextClassName', () => {
  it('promotes LKG to UKG', () => {
    expect(getNextClassName('LKG')).toBe('UKG')
  })

  it('promotes UKG to I', () => {
    expect(getNextClassName('UKG')).toBe('I')
  })

  it('promotes I through IX sequentially', () => {
    expect(getNextClassName('I')).toBe('II')
    expect(getNextClassName('II')).toBe('III')
    expect(getNextClassName('VIII')).toBe('IX')
    expect(getNextClassName('IX')).toBe('X')
  })

  it('returns null for class X (graduating)', () => {
    expect(getNextClassName('X')).toBeNull()
  })

  it('returns null for unknown class name', () => {
    expect(getNextClassName('XI')).toBeNull()
  })
})

describe('isGraduating', () => {
  it('returns true only for class X', () => {
    expect(isGraduating('X')).toBe(true)
  })

  it('returns false for all other classes', () => {
    expect(isGraduating('IX')).toBe(false)
    expect(isGraduating('LKG')).toBe(false)
    expect(isGraduating('UKG')).toBe(false)
  })
})

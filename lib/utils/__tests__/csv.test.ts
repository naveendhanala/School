import { describe, it, expect } from 'vitest'
import { toCsv } from '../csv'

describe('toCsv', () => {
  it('outputs header row and data rows', () => {
    const result = toCsv(['Name', 'Age'], [['Alice', 30], ['Bob', 25]])
    expect(result).toBe('Name,Age\nAlice,30\nBob,25')
  })

  it('wraps values containing commas in double quotes', () => {
    const result = toCsv(['Note'], [['hello, world']])
    expect(result).toBe('Note\n"hello, world"')
  })

  it('escapes double quotes by doubling them', () => {
    const result = toCsv(['Val'], [['"quoted"']])
    expect(result).toBe('Val\n"""quoted"""')
  })

  it('wraps values containing newlines', () => {
    const result = toCsv(['Addr'], [['line1\nline2']])
    expect(result).toBe('Addr\n"line1\nline2"')
  })

  it('converts null and undefined to empty string', () => {
    const result = toCsv(['A', 'B'], [[null, undefined]])
    expect(result).toBe('A,B\n,')
  })

  it('handles empty rows array', () => {
    const result = toCsv(['H1', 'H2'], [])
    expect(result).toBe('H1,H2')
  })

  it('handles numbers in rows', () => {
    const result = toCsv(['Amount'], [[12500]])
    expect(result).toBe('Amount\n12500')
  })
})

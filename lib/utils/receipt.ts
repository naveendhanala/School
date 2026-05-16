export function formatReceiptNo(yearLabel: string, sequence: number): string {
  return `${yearLabel}-${String(sequence).padStart(6, '0')}`
}

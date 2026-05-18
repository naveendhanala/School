import type { ClassFeeHead } from '@/lib/types'

export function buildClassFeeMap(
  rows: { class_id: string; fee_head: string; amount: number | string }[]
): Map<string, Record<ClassFeeHead, number>> {
  const map = new Map<string, Record<ClassFeeHead, number>>()
  for (const fs of rows) {
    const entry = map.get(fs.class_id) ?? { tuition: 0, book: 0 }
    ;(entry as Record<string, number>)[fs.fee_head] = Number(fs.amount)
    map.set(fs.class_id, entry)
  }
  return map
}

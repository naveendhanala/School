const CLASS_ORDER = ['LKG', 'UKG', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'] as const

export function getNextClassName(currentClass: string): string | null {
  const idx = CLASS_ORDER.indexOf(currentClass as typeof CLASS_ORDER[number])
  if (idx === -1 || idx === CLASS_ORDER.length - 1) return null
  return CLASS_ORDER[idx + 1]
}

export function isGraduating(className: string): boolean {
  return className === 'X'
}

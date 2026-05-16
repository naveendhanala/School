import { createClient } from '@/lib/supabase/server'
import { ClassFeeRow } from './class-fee-row'

export async function ClassFeesTab() {
  const supabase = await createClient()

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id, label')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) {
    return (
      <div className="mt-4 p-4 bg-yellow-50 border border-yellow-200 rounded text-yellow-800 text-sm">
        No active academic year set. Create one in the Academic Year tab.
      </div>
    )
  }

  const { data: classes } = await supabase
    .from('classes')
    .select('id, name, sort_order')
    .order('sort_order')

  const { data: fees } = await supabase
    .from('fee_structure')
    .select('class_id, fee_head, amount')
    .eq('academic_year_id', activeYear.id)

  const feeMap = new Map<string, { tuition: number; book: number }>()
  for (const fee of fees ?? []) {
    const existing = feeMap.get(fee.class_id) ?? { tuition: 0, book: 0 }
    if (fee.fee_head === 'tuition') existing.tuition = Number(fee.amount)
    if (fee.fee_head === 'book') existing.book = Number(fee.amount)
    feeMap.set(fee.class_id, existing)
  }

  return (
    <div className="mt-4">
      <p className="text-sm text-gray-500 mb-4">
        Academic Year: <strong>{activeYear.label}</strong>
      </p>
      <div className="overflow-x-auto">
        <table className="w-full text-sm">
          <thead>
            <tr className="border-b bg-gray-50">
              <th scope="col" className="text-left px-3 py-2 font-medium text-gray-600">Class</th>
              <th scope="col" className="text-left px-3 py-2 font-medium text-gray-600">Tuition (₹)</th>
              <th scope="col" className="text-left px-3 py-2 font-medium text-gray-600">Book (₹)</th>
              <th scope="col" className="px-3 py-2"></th>
            </tr>
          </thead>
          <tbody>
            {(classes ?? []).map(cls => (
              <ClassFeeRow
                key={cls.id}
                classId={cls.id}
                className={cls.name}
                academicYearId={activeYear.id}
                tuition={feeMap.get(cls.id)?.tuition ?? 0}
                book={feeMap.get(cls.id)?.book ?? 0}
              />
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}

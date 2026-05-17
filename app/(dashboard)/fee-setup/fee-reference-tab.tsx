import { createClient } from '@/lib/supabase/server'
import { formatCurrency } from '@/lib/utils/currency'

export async function FeeReferenceTab() {
  const supabase = await createClient()

  const { data: activeYear } = await supabase
    .from('academic_years')
    .select('id, label')
    .eq('is_active', true)
    .maybeSingle()

  if (!activeYear) {
    return <p className="mt-4 text-sm text-gray-500">No active academic year.</p>
  }

  const [
    { data: classes },
    { data: feeStructure },
    { data: routes },
  ] = await Promise.all([
    supabase.from('classes').select('id, name').order('sort_order'),
    supabase.from('fee_structure').select('class_id, fee_head, amount').eq('academic_year_id', activeYear.id),
    supabase.from('transport_routes').select('id, name, fee_amount').order('name'),
  ])

  const feeMap = new Map<string, Record<string, number>>()
  for (const fs of feeStructure ?? []) {
    const entry = feeMap.get(fs.class_id) ?? {}
    entry[fs.fee_head] = Number(fs.amount)
    feeMap.set(fs.class_id, entry)
  }

  return (
    <div className="mt-4 space-y-6">
      <div>
        <h2 className="mb-3 font-semibold text-gray-900">Class Fees — {activeYear.label}</h2>
        {(classes ?? []).length === 0 ? (
          <p className="text-sm text-gray-400">No classes configured.</p>
        ) : (
          <div className="overflow-x-auto rounded-lg border bg-white">
            <table className="min-w-full text-sm">
              <thead className="bg-gray-50 text-gray-600">
                <tr>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Class</th>
                  <th scope="col" className="px-4 py-3 text-right font-medium">Tuition</th>
                  <th scope="col" className="px-4 py-3 text-right font-medium">Book</th>
                  <th scope="col" className="px-4 py-3 text-right font-medium">Total</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {(classes ?? []).map(cls => {
                  const fees = feeMap.get(cls.id) ?? {}
                  const tuition = fees['tuition'] ?? 0
                  const book = fees['book'] ?? 0
                  return (
                    <tr key={cls.id} className="hover:bg-gray-50">
                      <td className="px-4 py-3 font-medium">{cls.name}</td>
                      <td className="px-4 py-3 text-right tabular-nums">{tuition > 0 ? formatCurrency(tuition) : '—'}</td>
                      <td className="px-4 py-3 text-right tabular-nums">{book > 0 ? formatCurrency(book) : '—'}</td>
                      <td className="px-4 py-3 text-right tabular-nums font-semibold">{formatCurrency(tuition + book)}</td>
                    </tr>
                  )
                })}
              </tbody>
            </table>
          </div>
        )}
      </div>

      <div>
        <h2 className="mb-3 font-semibold text-gray-900">Transport Fees</h2>
        {(routes ?? []).length === 0 ? (
          <p className="text-sm text-gray-400">No routes configured.</p>
        ) : (
          <div className="overflow-x-auto rounded-lg border bg-white">
            <table className="min-w-full text-sm">
              <thead className="bg-gray-50 text-gray-600">
                <tr>
                  <th scope="col" className="px-4 py-3 text-left font-medium">Route</th>
                  <th scope="col" className="px-4 py-3 text-right font-medium">Annual Fee</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {(routes ?? []).map(r => (
                  <tr key={r.id} className="hover:bg-gray-50">
                    <td className="px-4 py-3 font-medium">{r.name}</td>
                    <td className="px-4 py-3 text-right tabular-nums font-semibold">
                      {formatCurrency(Number(r.fee_amount))}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  )
}

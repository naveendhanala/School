import { createClient } from '@/lib/supabase/server'
import { AcademicYearRow } from './academic-year-row'
import { CreateYearForm } from './create-year-form'

export async function AcademicYearTab() {
  const supabase = await createClient()
  const { data: years } = await supabase
    .from('academic_years')
    .select('id, label, is_active')
    .order('created_at', { ascending: false })

  return (
    <div className="mt-4 space-y-6">
      <div>
        <h3 className="mb-3 font-medium">Create New Year</h3>
        <CreateYearForm />
      </div>
      <div>
        <h3 className="mb-3 font-medium">Academic Years</h3>
        {(years ?? []).length === 0 ? (
          <p className="text-sm text-gray-500">No academic years yet.</p>
        ) : (
          <div className="space-y-2">
            {(years ?? []).map(y => (
              <AcademicYearRow key={y.id} id={y.id} label={y.label} isActive={y.is_active} />
            ))}
          </div>
        )}
      </div>
    </div>
  )
}

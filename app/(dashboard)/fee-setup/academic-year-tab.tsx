import { createClient } from '@/lib/supabase/server'
import { AcademicYearRow } from './academic-year-row'
import { CreateYearForm } from './create-year-form'
import { ResetPaymentsButton } from './reset-payments-button'

export async function AcademicYearTab() {
  const supabase = await createClient()
  const [{ data: years }, { data: roleData }] = await Promise.all([
    supabase
      .from('academic_years')
      .select('id, label, is_active')
      .order('created_at', { ascending: false }),
    supabase.rpc('get_user_role'),
  ])

  const isAdmin = roleData === 'admin'
  const activeYear = (years ?? []).find(y => y.is_active) ?? null

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

      {isAdmin && activeYear && (
        <div className="rounded-lg border border-red-200 bg-red-50 p-4">
          <h3 className="mb-1 font-medium text-red-700">Danger Zone</h3>
          <p className="mb-4 text-sm text-red-600">
            Permanently deletes all payments, deposits, and bridge course records for the active
            year. Student and enrollment records are preserved.
          </p>
          <ResetPaymentsButton
            activeYearId={activeYear.id}
            activeYearLabel={activeYear.label}
          />
        </div>
      )}
    </div>
  )
}

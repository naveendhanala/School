import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import { Sidebar } from '@/components/layout/sidebar'
import { UserProvider } from '@/lib/user-context'
import type { Role } from '@/lib/types'

function isRole(r: string): r is Role {
  return r === 'admin' || r === 'accountant' || r === 'cashier'
}

export default async function DashboardLayout({ children }: { children: React.ReactNode }) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) redirect('/login')

  const { data: profileData } = await supabase
    .from('profiles')
    .select('name, role')
    .eq('id', user.id)
    .single()

  const profile = profileData as { name: string; role: string } | null

  if (!profile) return redirect('/login')
  if (!isRole(profile.role)) return redirect('/login')

  return (
    <UserProvider name={profile.name} role={profile.role}>
      <div className="flex min-h-screen bg-gray-50">
        <Sidebar />
        <main className="flex-1 overflow-y-auto">
          {children}
        </main>
      </div>
    </UserProvider>
  )
}

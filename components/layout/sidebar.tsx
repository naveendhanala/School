'use client'
import Link from 'next/link'
import { usePathname, useRouter } from 'next/navigation'
import { cn } from '@/lib/utils'
import {
  LayoutDashboard,
  Users,
  CreditCard,
  Clock,
  Landmark,
  GraduationCap,
  BarChart3,
  Settings,
  LogOut,
} from 'lucide-react'
import { createClient } from '@/lib/supabase/client'
import type { Role } from '@/lib/types'

const NAV_ITEMS = [
  { href: '/',              label: 'Dashboard',     icon: LayoutDashboard, roles: ['admin', 'accountant', 'cashier'] },
  { href: '/students',     label: 'Students',      icon: Users,           roles: ['admin', 'accountant', 'cashier'] },
  { href: '/collect-fee',  label: 'Collect Fee',   icon: CreditCard,      roles: ['admin', 'accountant', 'cashier'] },
  { href: '/pending-fees', label: 'Pending Fees',  icon: Clock,           roles: ['admin', 'accountant'] },
  { href: '/bank-deposits',label: 'Bank Deposits', icon: Landmark,        roles: ['admin', 'accountant'] },
  { href: '/bridge-course',label: 'Bridge Course', icon: GraduationCap,   roles: ['admin', 'accountant', 'cashier'] },
  { href: '/reports',      label: 'Reports',       icon: BarChart3,       roles: ['admin', 'accountant'] },
  { href: '/fee-setup',    label: 'Fee Setup',     icon: Settings,        roles: ['admin'] },
] as const

interface SidebarProps {
  role: Role
  userName: string
}

export function Sidebar({ role, userName }: SidebarProps) {
  const pathname = usePathname()
  const router = useRouter()
  const supabase = createClient()

  async function handleSignOut() {
    await supabase.auth.signOut()
    router.push('/login')
    router.refresh()
  }

  const visibleItems = NAV_ITEMS.filter(item =>
    (item.roles as readonly string[]).includes(role)
  )

  return (
    <aside className="w-60 shrink-0 bg-white border-r border-gray-200 flex flex-col h-screen sticky top-0">
      <div className="p-4 border-b border-gray-200">
        <h1 className="text-sm font-semibold text-gray-900 leading-snug">
          Rama School of Excellence
        </h1>
        <p className="text-xs text-gray-500 mt-0.5 capitalize">{role}</p>
      </div>

      <nav className="flex-1 overflow-y-auto p-2 space-y-0.5">
        {visibleItems.map(item => {
          const isActive = item.href === '/'
            ? pathname === '/'
            : pathname.startsWith(item.href)
          return (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                'flex items-center gap-3 px-3 py-2 rounded-md text-sm font-medium transition-colors',
                isActive
                  ? 'bg-blue-50 text-blue-700'
                  : 'text-gray-600 hover:bg-gray-100 hover:text-gray-900'
              )}
            >
              <item.icon className="h-4 w-4 shrink-0" />
              {item.label}
            </Link>
          )
        })}
      </nav>

      <div className="p-4 border-t border-gray-200">
        <p className="text-sm font-medium text-gray-900 truncate">{userName}</p>
        <button
          onClick={handleSignOut}
          className="mt-2 flex items-center gap-2 text-sm text-gray-500 hover:text-gray-900 transition-colors"
        >
          <LogOut className="h-4 w-4" />
          Sign out
        </button>
      </div>
    </aside>
  )
}

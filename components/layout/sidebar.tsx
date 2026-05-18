'use client'
import Link from 'next/link'
import Image from 'next/image'
import { usePathname, useRouter } from 'next/navigation'
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
import { useUser } from '@/lib/user-context'
import type { Role } from '@/lib/types'

const NAV_GROUPS = [
  {
    label: 'Overview',
    items: [
      { href: '/', label: 'Dashboard', icon: LayoutDashboard, roles: ['admin', 'accountant', 'cashier'] },
    ],
  },
  {
    label: 'Fee Management',
    items: [
      { href: '/students',     label: 'Students',     icon: Users,        roles: ['admin', 'accountant', 'cashier'] },
      { href: '/collect-fee',  label: 'Collect Fee',  icon: CreditCard,   roles: ['admin', 'accountant', 'cashier'] },
      { href: '/pending-fees', label: 'Pending Fees', icon: Clock,        roles: ['admin', 'accountant'] },
    ],
  },
  {
    label: 'Banking',
    items: [
      { href: '/bank-deposits', label: 'Bank Deposits', icon: Landmark, roles: ['admin', 'accountant'] },
    ],
  },
  {
    label: 'Bridge Course',
    items: [
      { href: '/bridge-course', label: 'Summer Camp 2026', icon: GraduationCap, roles: ['admin', 'accountant', 'cashier'] },
    ],
  },
  {
    label: 'Administration',
    items: [
      { href: '/reports',   label: 'Reports',       icon: BarChart3, roles: ['admin', 'accountant'] },
      { href: '/fee-setup', label: 'Fee Structure', icon: Settings,  roles: ['admin'] },
    ],
  },
] as const

const ROLE_COLORS: Record<Role, string> = {
  admin:      '#1A4FA0',
  accountant: '#1A7A4A',
  cashier:    '#475569',
}

export function Sidebar() {
  const { name, role } = useUser()
  const pathname = usePathname()
  const router = useRouter()
  const supabase = createClient()

  async function handleSignOut() {
    await supabase.auth.signOut()
    router.push('/login')
    router.refresh()
  }

  const initial = name ? name.charAt(0).toUpperCase() : '?'

  return (
    <aside
      style={{
        width: '252px',
        background: '#0F172A',
        color: '#fff',
        display: 'flex',
        flexDirection: 'column',
        height: '100vh',
        position: 'sticky',
        top: 0,
        zIndex: 200,
        overflowY: 'auto',
        flexShrink: 0,
      }}
    >
      {/* Header */}
      <div
        style={{
          padding: '10px 12px',
          borderBottom: '1px solid rgba(255,255,255,.07)',
        }}
      >
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
          <Image
            src="/school-logo.jpeg"
            alt="Rama School"
            width={38}
            height={38}
            style={{ borderRadius: '50%', border: '2px solid rgba(255,255,255,.3)', flexShrink: 0 }}
          />
          <div>
            <div
              style={{
                fontFamily: 'var(--font-poppins)',
                fontSize: '11px',
                fontWeight: 800,
                color: '#E8581A',
                lineHeight: 1.3,
              }}
            >
              RAMA SCHOOL OF EXCELLENCE
            </div>
            <div style={{ fontSize: '9px', color: 'rgba(255,255,255,.3)', textTransform: 'uppercase', letterSpacing: '1px', marginTop: '1px' }}>
              Fee Tracker · 2025–26
            </div>
            <div style={{ fontSize: '9px', color: 'rgba(255,255,255,.4)', marginTop: '1px' }}>
              📞 9603278460
            </div>
          </div>
        </div>
      </div>

      {/* Nav */}
      <nav style={{ flex: 1, padding: '8px 0' }}>
        {NAV_GROUPS.map(group => {
          const visible = group.items.filter(item =>
            (item.roles as readonly string[]).includes(role)
          )
          if (visible.length === 0) return null
          return (
            <div key={group.label}>
              <div
                style={{
                  padding: '12px 16px 3px',
                  fontSize: '9px',
                  color: 'rgba(255,255,255,.25)',
                  textTransform: 'uppercase',
                  letterSpacing: '1.2px',
                  fontWeight: 600,
                }}
              >
                {group.label}
              </div>
              {visible.map(item => {
                const isActive = item.href === '/'
                  ? pathname === '/'
                  : pathname.startsWith(item.href)
                return (
                  <Link
                    key={item.href}
                    href={item.href}
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: '9px',
                      padding: '9px 13px',
                      borderRadius: '9px',
                      margin: '1px 7px',
                      fontSize: '12.5px',
                      fontWeight: 500,
                      textDecoration: 'none',
                      color: isActive ? '#fff' : 'rgba(255,255,255,.6)',
                      background: isActive
                        ? 'linear-gradient(135deg,#E8581A,#FF7A3C)'
                        : 'transparent',
                      boxShadow: isActive ? '0 4px 12px rgba(232,88,26,.4)' : 'none',
                      transition: 'all .2s',
                    }}
                  >
                    <item.icon size={15} style={{ flexShrink: 0, opacity: isActive ? 1 : 0.7 }} />
                    {item.label}
                  </Link>
                )
              })}
            </div>
          )
        })}
      </nav>

      {/* Footer */}
      <div
        style={{
          padding: '12px',
          borderTop: '1px solid rgba(255,255,255,.07)',
          display: 'flex',
          alignItems: 'center',
          gap: '9px',
        }}
      >
        <div
          style={{
            width: '32px',
            height: '32px',
            borderRadius: '50%',
            background: `linear-gradient(135deg, ${ROLE_COLORS[role]}, #2A6DD9)`,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            fontFamily: 'var(--font-poppins)',
            fontWeight: 800,
            fontSize: '13px',
            flexShrink: 0,
          }}
        >
          {initial}
        </div>
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ fontSize: '12px', fontWeight: 600, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
            {name}
          </div>
          <div style={{ fontSize: '10px', color: 'rgba(255,255,255,.4)', textTransform: 'capitalize' }}>
            {role}
          </div>
        </div>
        <button
          onClick={handleSignOut}
          title="Sign out"
          style={{
            background: 'none',
            border: 'none',
            color: 'rgba(255,255,255,.4)',
            cursor: 'pointer',
            padding: '4px',
            borderRadius: '6px',
            display: 'flex',
            alignItems: 'center',
          }}
          onMouseOver={e => (e.currentTarget.style.color = '#fff')}
          onMouseOut={e => (e.currentTarget.style.color = 'rgba(255,255,255,.4)')}
        >
          <LogOut size={16} />
        </button>
      </div>
    </aside>
  )
}

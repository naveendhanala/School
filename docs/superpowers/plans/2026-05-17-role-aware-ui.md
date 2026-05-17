# Role-Aware UI Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Surface the existing role-based access control (already in DB/RLS) in the UI so that cashiers cannot see write actions, admins see a role badge, and role is accessible to all client components via React Context.

**Architecture:** A new `UserContext` (React context + provider + hook) is created in `lib/user-context.tsx`. The dashboard layout wraps its children in `UserProvider` using the profile it already fetches. Client components call `useUser()` to get the role and conditionally render write-action buttons. No new DB migrations or server-action changes are needed — RLS already enforces permissions at the DB level.

**Tech Stack:** React 19 context API, Next.js 16 app router, Vitest + @testing-library/react for unit tests, TypeScript.

---

## File Map

| File | Action | Responsibility |
|---|---|---|
| `lib/user-context.tsx` | **Create** | Context definition, UserProvider, useUser() hook |
| `lib/__tests__/user-context.test.tsx` | **Create** | Unit tests for context and hook |
| `app/(dashboard)/layout.tsx` | **Modify** | Wrap children in UserProvider |
| `components/layout/sidebar.tsx` | **Modify** | Use useUser(), show "name · Role" badge |
| `app/(dashboard)/students/students-client.tsx` | **Modify** | Hide Add/Edit/Deactivate from cashier |
| `app/(dashboard)/bank-deposits/bank-deposits-client.tsx` | **Modify** | Hide Add/Delete from cashier |
| `app/(dashboard)/bridge-course/bridge-course-client.tsx` | **Modify** | Hide Add Student/Pay/Delete/Add Deposit from cashier |

---

## Task 1: Create UserContext

**Files:**
- Create: `lib/user-context.tsx`

- [ ] **Step 1: Write the failing test**

Create `lib/__tests__/user-context.test.tsx`:

```tsx
// @vitest-environment jsdom
import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/react'
import { UserProvider, useUser } from '../user-context'
import type { Role } from '../types'

function DisplayUser() {
  const { name, role } = useUser()
  return <div data-testid="out">{name}:{role}</div>
}

function ThrowingConsumer() {
  useUser()
  return null
}

describe('UserContext', () => {
  it('provides name and role to consumers', () => {
    render(
      <UserProvider name="Ravi" role="admin">
        <DisplayUser />
      </UserProvider>
    )
    expect(screen.getByTestId('out').textContent).toBe('Ravi:admin')
  })

  it('provides correct role for each role type', () => {
    const roles: Role[] = ['admin', 'accountant', 'cashier']
    for (const role of roles) {
      const { unmount } = render(
        <UserProvider name="Test" role={role}>
          <DisplayUser />
        </UserProvider>
      )
      expect(screen.getByTestId('out').textContent).toBe(`Test:${role}`)
      unmount()
    }
  })

  it('throws when useUser is called outside UserProvider', () => {
    const originalError = console.error
    console.error = () => {}
    expect(() => render(<ThrowingConsumer />)).toThrow(
      'useUser must be used within a UserProvider'
    )
    console.error = originalError
  })
})
```

- [ ] **Step 2: Run test to confirm it fails**

```
npm test -- lib/__tests__/user-context.test.tsx
```

Expected: FAIL — `Cannot find module '../user-context'`

- [ ] **Step 3: Create `lib/user-context.tsx`**

```tsx
'use client'

import { createContext, useContext } from 'react'
import type { Role } from './types'

type UserContextValue = {
  name: string
  role: Role
}

const UserContext = createContext<UserContextValue | null>(null)

export function UserProvider({
  name,
  role,
  children,
}: {
  name: string
  role: Role
  children: React.ReactNode
}) {
  return (
    <UserContext.Provider value={{ name, role }}>
      {children}
    </UserContext.Provider>
  )
}

export function useUser(): UserContextValue {
  const ctx = useContext(UserContext)
  if (!ctx) throw new Error('useUser must be used within a UserProvider')
  return ctx
}
```

- [ ] **Step 4: Run test to confirm it passes**

```
npm test -- lib/__tests__/user-context.test.tsx
```

Expected: PASS — 3 tests passing

- [ ] **Step 5: Commit**

```
git add lib/user-context.tsx lib/__tests__/user-context.test.tsx
git commit -m "feat: add UserContext with provider and useUser hook"
```

---

## Task 2: Wire UserProvider into the dashboard layout

**Files:**
- Modify: `app/(dashboard)/layout.tsx`

- [ ] **Step 1: Replace the file content**

```tsx
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
```

- [ ] **Step 2: Verify TypeScript compiles**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 3: Commit**

```
git add app/(dashboard)/layout.tsx
git commit -m "feat: wrap dashboard layout children in UserProvider"
```

---

## Task 3: Update Sidebar to use useUser and show name·role badge

**Files:**
- Modify: `components/layout/sidebar.tsx`

- [ ] **Step 1: Replace the file content**

```tsx
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
import { useUser } from '@/lib/user-context'
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

const ROLE_BADGE: Record<Role, string> = {
  admin:      'bg-blue-100 text-blue-700',
  accountant: 'bg-green-100 text-green-700',
  cashier:    'bg-gray-100 text-gray-600',
}

export function Sidebar() {
  const { name, role } = useUser()
  const pathname = usePathname()
  const router = useRouter()
  const supabase = createClient()

  async function handleSignOut() {
    const { error } = await supabase.auth.signOut()
    if (error) {
      console.error('Sign out failed:', error.message)
    }
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
        <div className="flex items-center gap-2 min-w-0">
          <p className="text-sm font-medium text-gray-900 truncate">{name}</p>
          <span className={cn(
            'shrink-0 rounded-full px-2 py-0.5 text-xs font-medium capitalize',
            ROLE_BADGE[role]
          )}>
            {role}
          </span>
        </div>
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
```

- [ ] **Step 2: Verify TypeScript compiles**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 3: Visually verify in browser**

Open http://localhost:3000 while logged in. The sidebar footer should show:
- Admin user → name + blue "admin" pill
- Accountant user → name + green "accountant" pill
- Cashier user → name + grey "cashier" pill
- The school name no longer shows the role as a subtitle

- [ ] **Step 4: Commit**

```
git add components/layout/sidebar.tsx
git commit -m "feat: sidebar uses useUser hook and shows name·role badge"
```

---

## Task 4: Gate write buttons in Students page

**Files:**
- Modify: `app/(dashboard)/students/students-client.tsx`

- [ ] **Step 1: Add useUser import and gate the three write actions**

Apply these changes to `app/(dashboard)/students/students-client.tsx`:

Add `useUser` to the imports at the top:

```tsx
import { useUser } from '@/lib/user-context'
```

Inside `StudentsClient`, add this line right after the existing `useState`/`useTransition` calls:

```tsx
const { role } = useUser()
const canWrite = role !== 'cashier'
```

In the header `<div className="flex gap-2">`, change the Add Student button to be conditional:

```tsx
<div className="flex gap-2">
  <Button variant="outline" size="sm" onClick={handleExportCsv}>
    Export CSV
  </Button>
  {canWrite && (
    <Button size="sm" onClick={openAdd}>+ Add Student</Button>
  )}
</div>
```

In the per-row actions cell, gate the Edit and Deactivate buttons:

```tsx
<td className="px-3 py-2">
  {canWrite && (
    <div className="flex gap-1">
      <Button
        size="sm"
        variant="ghost"
        className="h-7 px-2 text-xs"
        onClick={() => openEdit(row)}
      >
        Edit
      </Button>
      {row.isActive && (
        <Button
          size="sm"
          variant="ghost"
          className="h-7 px-2 text-xs text-red-600 hover:text-red-700 hover:bg-red-50"
          onClick={() => handleDeactivate(row)}
        >
          Deactivate
        </Button>
      )}
    </div>
  )}
</td>
```

- [ ] **Step 2: Verify TypeScript compiles**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 3: Visually verify in browser**

Log in as a cashier. Go to /students:
- "Add Student" button should NOT appear in the header
- No Edit or Deactivate buttons should appear in any row

Log in as an admin or accountant. Go to /students:
- "Add Student" button should appear
- Edit and Deactivate buttons should appear per row

- [ ] **Step 4: Commit**

```
git add "app/(dashboard)/students/students-client.tsx"
git commit -m "feat: hide student write actions from cashier role"
```

---

## Task 5: Gate write buttons in Bank Deposits page

**Files:**
- Modify: `app/(dashboard)/bank-deposits/bank-deposits-client.tsx`

- [ ] **Step 1: Add useUser import and gate the two write actions**

Add `useUser` to the imports at the top of `app/(dashboard)/bank-deposits/bank-deposits-client.tsx`:

```tsx
import { useUser } from '@/lib/user-context'
```

Inside `BankDepositsClient`, add after the existing `useState` calls:

```tsx
const { role } = useUser()
const canWrite = role !== 'cashier'
```

Gate the Add Deposit button (replace the existing button in the header):

```tsx
{canWrite && (
  <Button onClick={() => setDialogOpen(true)} className="gap-2">
    <Plus className="h-4 w-4" />
    Add Deposit
  </Button>
)}
```

Gate the Delete button in the table rows (wrap the existing `<button>` in a conditional):

```tsx
<td className="px-4 py-3 text-right">
  {canWrite && (
    <button
      onClick={() => handleDelete(d.id, d.bankName)}
      disabled={isPending && deletingId === d.id}
      className="rounded p-1 text-gray-400 hover:bg-red-50 hover:text-red-600 disabled:opacity-40"
      aria-label="Delete deposit"
    >
      <Trash2 className="h-4 w-4" />
    </button>
  )}
</td>
```

- [ ] **Step 2: Verify TypeScript compiles**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 3: Visually verify in browser**

Note: Cashier cannot reach /bank-deposits (sidebar hides it), so this is defence-in-depth. Verify with an admin/accountant that Add Deposit and delete icons still appear normally.

- [ ] **Step 4: Commit**

```
git add "app/(dashboard)/bank-deposits/bank-deposits-client.tsx"
git commit -m "feat: hide bank deposit write actions from cashier role"
```

---

## Task 6: Gate write buttons in Bridge Course page

**Files:**
- Modify: `app/(dashboard)/bridge-course/bridge-course-client.tsx`

- [ ] **Step 1: Add useUser import and gate all write actions**

Add `useUser` to the imports at the top of `app/(dashboard)/bridge-course/bridge-course-client.tsx`:

```tsx
import { useUser } from '@/lib/user-context'
```

Inside `BridgeCourseClient`, add after the existing `useState` calls:

```tsx
const { role } = useUser()
const canWrite = role !== 'cashier'
```

Gate the "Add Student" header button:

```tsx
<div className="flex items-center justify-between">
  <div>
    <h1 className="text-2xl font-bold text-gray-900">Bridge Course</h1>
    <p className="mt-1 text-sm text-gray-500">Academic Year: {activeYearLabel}</p>
  </div>
  {canWrite && (
    <Button onClick={() => setAddStudentOpen(true)} className="gap-2">
      <Plus className="h-4 w-4" />
      Add Student
    </Button>
  )}
</div>
```

Gate the per-row Pay button and Delete button:

```tsx
<td className="px-3 py-3 text-right">
  <div className="flex items-center justify-end gap-1">
    {canWrite && s.status !== 'paid' && (
      <Button
        variant="outline"
        size="sm"
        onClick={() => setPaymentTarget({ id: s.id, name: s.name })}
        className="h-7 text-xs"
      >
        Pay
      </Button>
    )}
    {canWrite && (
      <button
        onClick={() => handleDeleteStudent(s.id, s.name)}
        disabled={isPending && deletingId === s.id}
        className="rounded p-1 text-gray-400 hover:bg-red-50 hover:text-red-600 disabled:opacity-40"
        aria-label="Delete student"
      >
        <Trash2 className="h-4 w-4" />
      </button>
    )}
  </div>
</td>
```

Gate the "Add Deposit" button in the Bank Deposits section:

```tsx
<div className="flex items-center justify-between">
  <div>
    <h2 className="font-semibold text-gray-900">Bank Deposits</h2>
    <p className="text-sm text-gray-500">
      Total deposited:{' '}
      <span className="font-medium text-blue-600">{formatCurrency(totalDeposited)}</span>
    </p>
  </div>
  {canWrite && (
    <Button
      variant="outline"
      size="sm"
      onClick={() => setDepositDialogOpen(true)}
      className="gap-2"
    >
      <Plus className="h-4 w-4" />
      Add Deposit
    </Button>
  )}
</div>
```

Gate the deposit Delete button in the deposits table:

```tsx
<td className="px-4 py-3 text-right">
  {canWrite && (
    <button
      onClick={() => handleDeleteDeposit(d.id)}
      disabled={isPending && deletingDepositId === d.id}
      className="rounded p-1 text-gray-400 hover:bg-red-50 hover:text-red-600 disabled:opacity-40"
      aria-label="Delete deposit"
    >
      <Trash2 className="h-4 w-4" />
    </button>
  )}
</td>
```

- [ ] **Step 2: Verify TypeScript compiles**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 3: Visually verify in browser**

Log in as cashier. Go to /bridge-course:
- No "Add Student" button in header
- No Pay or Delete buttons on student rows
- No "Add Deposit" button in the deposits section
- No Delete icon on deposit rows

Log in as admin. Go to /bridge-course: all buttons present.

- [ ] **Step 4: Commit**

```
git add "app/(dashboard)/bridge-course/bridge-course-client.tsx"
git commit -m "feat: hide bridge course write actions from cashier role"
```

---

## Task 7: Final verification

- [ ] **Step 1: Run all tests**

```
npm test
```

Expected: All tests pass, including the 3 user-context tests.

- [ ] **Step 2: Run a full TypeScript check**

```
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 3: Verify role matrix in browser**

Test each role by logging in with the corresponding account:

| Role | Can reach /fee-setup? | Add Student button? | Delete deposit? |
|---|---|---|---|
| admin | ✅ | ✅ | ✅ |
| accountant | ❌ (not in sidebar) | ✅ | ✅ |
| cashier | ❌ | ❌ | ❌ |

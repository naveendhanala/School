# Role-Aware UI — Design Spec

**Date:** 2026-05-17
**Scope:** Group A of missing HTML v2 features — surfacing role-based access control in the UI

---

## Background

The database schema already has full role-based infrastructure:
- `profiles` table with `role IN ('admin', 'accountant', 'cashier')`
- `get_user_role()` SQL function
- RLS policies enforcing admin/accountant/cashier boundaries on every table
- `app/(dashboard)/layout.tsx` already fetches the profile and passes `role` + `userName` to the Sidebar
- `components/layout/sidebar.tsx` already filters nav items by role

The gap is that client components inside pages cannot see the current user's role, so action buttons (Add Student, Edit, Delete, etc.) are shown to all roles regardless of permission.

---

## Role Access Matrix

| Feature | Admin | Accountant | Cashier |
|---|---|---|---|
| Dashboard | ✅ | ✅ | ✅ |
| Students (view) | ✅ | ✅ | ✅ |
| Students (add/edit/deactivate) | ✅ | ✅ | ❌ |
| Collect Fee | ✅ | ✅ | ✅ |
| Pending Fees | ✅ | ✅ | ❌ (tab hidden) |
| Bank Deposits (view) | ✅ | ✅ | ❌ (tab hidden) |
| Bank Deposits (add/delete) | ✅ | ✅ | ❌ (tab hidden) |
| Bridge Course (view) | ✅ | ✅ | ✅ |
| Bridge Course (add/delete) | ✅ | ✅ | ❌ |
| Reports | ✅ | ✅ | ❌ (tab hidden) |
| Fee Setup | ✅ | ❌ (tab hidden) | ❌ (tab hidden) |
| Edit/Delete payments | ✅ | ❌ | ❌ |

Tabs already hidden via sidebar nav filter: Pending Fees (cashier), Reports (cashier), Fee Setup (accountant + cashier). No change needed there.

---

## Architecture

### New file: `lib/user-context.tsx`

A React client context that holds `{ name: string, role: Role }`.

- `UserProvider` — `'use client'` component; accepts `name` and `role` as props; wraps children in context
- `useUser()` — hook that reads the context; throws if called outside provider

### `app/(dashboard)/layout.tsx` (2-line change)

Import `UserProvider` and wrap `children`:

```tsx
return (
  <UserProvider name={profile.name} role={profile.role}>
    <div className="flex min-h-screen bg-gray-50">
      <Sidebar />  {/* no longer takes role/userName props */}
      <main className="flex-1 overflow-y-auto">
        {children}
      </main>
    </div>
  </UserProvider>
)
```

The Sidebar reads from `useUser()` instead of props, so the layout no longer passes `role` or `userName` to it.

### `components/layout/sidebar.tsx`

- Remove `role` and `userName` props (now reads from `useUser()`)
- Update bottom section to display: `{name} · <role badge>`
  - Role badge: small pill with capitalize role text (e.g. "Admin", "Accountant", "Cashier")

### Client pages — role-gated buttons

Each affected client component calls `useUser()` and conditionally renders:

**`app/(dashboard)/students/students-client.tsx`**
- Hide "Add Student" button when `role === 'cashier'`
- Hide per-row "Edit" and "Deactivate" buttons when `role === 'cashier'`

**`app/(dashboard)/bank-deposits/bank-deposits-client.tsx`**
- Hide "Add Deposit" button when `role === 'cashier'`
- Hide per-row "Delete" button when `role === 'cashier'`

**`app/(dashboard)/bridge-course/bridge-course-client.tsx`**
- Hide "Add Student" button when `role === 'cashier'`
- Hide "Add Deposit" button when `role === 'cashier'`
- Hide per-row "Record Payment" and "Delete" buttons when `role === 'cashier'`

---

## Sidebar User Display

Current bottom section:
```
Ravi Kiran          ← plain text name
[Sign out]
```

New bottom section:
```
Ravi Kiran · [Admin]   ← name + role pill
[Sign out]
```

Role pill: `bg-blue-100 text-blue-700` for admin, `bg-green-100 text-green-700` for accountant, `bg-gray-100 text-gray-600` for cashier.

---

## What Does NOT Change

- No new DB migration — all RLS policies are already in `001_initial_schema.sql`
- No changes to server actions — RLS enforces at DB level regardless of UI
- No changes to page.tsx server components — role context is read only in client components
- The layout profile fetch is unchanged — `UserProvider` just consumes what's already fetched

---

## Files Changed

| File | Change type |
|---|---|
| `lib/user-context.tsx` | New |
| `app/(dashboard)/layout.tsx` | Wrap children in UserProvider, remove Sidebar props |
| `components/layout/sidebar.tsx` | Use useUser(), add name·role badge |
| `app/(dashboard)/students/students-client.tsx` | Hide write buttons from cashier |
| `app/(dashboard)/bank-deposits/bank-deposits-client.tsx` | Hide write buttons from cashier |
| `app/(dashboard)/bridge-course/bridge-course-client.tsx` | Hide write buttons from cashier |

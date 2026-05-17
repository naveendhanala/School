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

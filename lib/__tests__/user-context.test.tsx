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

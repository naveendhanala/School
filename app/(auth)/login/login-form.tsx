'use client'
import { useState } from 'react'
import Image from 'next/image'
import { login } from './actions'

export function LoginForm() {
  const [error, setError] = useState<string | null>(null)
  const [pending, setPending] = useState(false)

  async function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
    setPending(true)
    setError(null)
    const formData = new FormData(e.currentTarget)
    const result = await login(formData)
    if (result?.error) {
      setError(result.error)
      setPending(false)
    }
  }

  return (
    <div
      style={{
        background: '#fff',
        borderRadius: '24px',
        padding: '48px 40px',
        width: '100%',
        boxShadow: '0 24px 64px rgba(0,0,0,.25)',
        textAlign: 'center',
      }}
    >
      {/* Card header – school branding */}
      <div
        style={{
          display: 'flex',
          alignItems: 'center',
          gap: '10px',
          background: 'linear-gradient(135deg,#0F172A,#1A4FA0 50%,#E8581A)',
          padding: '16px 20px',
          borderRadius: '16px 16px 0 0',
          margin: '-48px -40px 20px',
        }}
      >
        <Image
          src="/school-logo.jpeg"
          alt="Rama School of Excellence"
          width={56}
          height={56}
          style={{
            borderRadius: '50%',
            objectFit: 'cover',
            border: '2px solid rgba(255,255,255,.4)',
            flexShrink: 0,
          }}
        />
        <div style={{ flex: 1, textAlign: 'center', color: '#fff' }}>
          <div
            style={{
              fontFamily: 'var(--font-poppins)',
              fontSize: '13.5px',
              fontWeight: 800,
              letterSpacing: '.3px',
              lineHeight: 1.2,
            }}
          >
            RAMA SCHOOL OF EXCELLENCE
          </div>
          <div style={{ fontSize: '10.5px', opacity: 0.85, marginTop: '2px', fontWeight: 600 }}>
            📞 9603278460
          </div>
          <div style={{ fontSize: '9.5px', opacity: 0.6, marginTop: '1px' }}>
            Vizinigiri · Andhra Pradesh · 2025–26
          </div>
        </div>
        <Image
          src="/school-guru.jpeg"
          alt="Ramaiah Prabhuji"
          width={44}
          height={50}
          style={{
            objectFit: 'cover',
            objectPosition: 'top',
            borderRadius: '5px',
            border: '1.5px solid rgba(255,255,255,.3)',
            flexShrink: 0,
          }}
        />
      </div>

      {/* Title */}
      <div
        style={{
          fontFamily: 'var(--font-poppins)',
          fontSize: '17px',
          fontWeight: 700,
          marginBottom: '4px',
          marginTop: '4px',
          color: '#1A202C',
        }}
      >
        Fee Collection Tracker
      </div>
      <div style={{ fontSize: '12px', color: '#64748B', marginBottom: '24px' }}>
        Academic Year 2025–26 · 2025-26 Students
      </div>

      {/* Form */}
      <form onSubmit={handleSubmit}>
        {/* Email field */}
        <div style={{ textAlign: 'left', marginBottom: '13px' }}>
          <label
            htmlFor="email"
            style={{
              display: 'block',
              fontSize: '10px',
              fontWeight: 600,
              color: '#64748B',
              textTransform: 'uppercase',
              letterSpacing: '.7px',
              marginBottom: '4px',
            }}
          >
            Email
          </label>
          <input
            id="email"
            name="email"
            type="email"
            autoComplete="email"
            required
            style={{
              width: '100%',
              padding: '10px 13px',
              border: '2px solid #E2E8F0',
              borderRadius: '9px',
              fontSize: '14px',
              fontFamily: 'inherit',
              outline: 'none',
              background: '#FAFBFC',
              transition: 'border-color .2s',
            }}
            onFocus={e => (e.currentTarget.style.borderColor = '#E8581A')}
            onBlur={e => (e.currentTarget.style.borderColor = '#E2E8F0')}
          />
        </div>

        {/* Password field */}
        <div style={{ textAlign: 'left', marginBottom: '13px' }}>
          <label
            htmlFor="password"
            style={{
              display: 'block',
              fontSize: '10px',
              fontWeight: 600,
              color: '#64748B',
              textTransform: 'uppercase',
              letterSpacing: '.7px',
              marginBottom: '4px',
            }}
          >
            Password
          </label>
          <input
            id="password"
            name="password"
            type="password"
            autoComplete="current-password"
            required
            style={{
              width: '100%',
              padding: '10px 13px',
              border: '2px solid #E2E8F0',
              borderRadius: '9px',
              fontSize: '14px',
              fontFamily: 'inherit',
              outline: 'none',
              background: '#FAFBFC',
              transition: 'border-color .2s',
            }}
            onFocus={e => (e.currentTarget.style.borderColor = '#E8581A')}
            onBlur={e => (e.currentTarget.style.borderColor = '#E2E8F0')}
          />
        </div>

        {error && (
          <p style={{ color: '#C0392B', fontSize: '13px', marginBottom: '12px' }} role="alert">
            {error}
          </p>
        )}

        {/* Sign In button */}
        <button
          type="submit"
          disabled={pending}
          style={{
            width: '100%',
            padding: '13px',
            background: pending
              ? '#ccc'
              : 'linear-gradient(135deg, #E8581A, #FF7A3C)',
            color: '#fff',
            border: 'none',
            borderRadius: '12px',
            fontFamily: 'var(--font-poppins)',
            fontSize: '16px',
            fontWeight: 700,
            cursor: pending ? 'not-allowed' : 'pointer',
            opacity: pending ? 0.8 : 1,
            transition: 'opacity .2s',
          }}
          onMouseOver={e => { if (!pending) e.currentTarget.style.opacity = '0.9' }}
          onMouseOut={e => { if (!pending) e.currentTarget.style.opacity = '1' }}
        >
          {pending ? 'Signing in…' : 'Sign In →'}
        </button>
      </form>
    </div>
  )
}

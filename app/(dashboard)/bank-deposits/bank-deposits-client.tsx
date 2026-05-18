'use client'

import { useMemo, useState, useTransition } from 'react'
import { useUser } from '@/lib/user-context'
import { useRouter } from 'next/navigation'
import { toCsv } from '@/lib/utils/csv'
import { Trash2 } from 'lucide-react'
import { toast } from 'sonner'
import { createDeposit, deleteDeposit } from './actions'
import type { DepositRow } from './page'

const BANKS = [
  'State Bank of India',
  'Andhra Bank',
  'HDFC Bank',
  'ICICI Bank',
  'Axis Bank',
  'Canara Bank',
  'Union Bank of India',
  'Indian Bank',
  'Other',
]

function todayIso() {
  return new Date().toISOString().slice(0, 10)
}

const EMPTY = {
  bankName: BANKS[0],
  accountNo: '',
  amount: '',
  depositDate: todayIso(),
  reference: '',
  remarks: '',
}

interface Props {
  deposits: DepositRow[]
  activeYearLabel: string
  totalCollected: number
  paymentCount: number
}

function fmt(n: number) {
  return '₹' + n.toLocaleString('en-IN')
}

function StatCard({
  label, value, sub, accent,
}: { label: string; value: string; sub: string; accent: string }) {
  return (
    <div style={{
      background: '#fff',
      borderRadius: '14px',
      padding: '16px 18px',
      border: '1px solid #E2E8F0',
      boxShadow: '0 1px 3px rgba(0,0,0,.08)',
      display: 'flex',
      flexDirection: 'column',
      gap: '5px',
      position: 'relative',
      overflow: 'hidden',
      flex: 1,
    }}>
      <div style={{
        position: 'absolute', top: 0, left: 0,
        width: '4px', height: '100%',
        borderRadius: '4px 0 0 4px',
        background: accent,
      }} />
      <div style={{ fontSize: '10px', fontWeight: 600, textTransform: 'uppercase', letterSpacing: '.7px', color: '#64748B' }}>
        {label}
      </div>
      <div style={{
        fontFamily: 'var(--font-poppins)',
        fontSize: '24px',
        fontWeight: 800,
        lineHeight: 1,
        color: accent.includes('1A7A') ? '#1A7A4A' : accent.includes('1A4F') ? '#1A4FA0' : '#C0392B',
      }}>
        {value}
      </div>
      <div style={{ fontSize: '11px', color: '#64748B' }}>{sub}</div>
    </div>
  )
}

function inputStyle(focused: boolean) {
  return {
    width: '100%',
    padding: '10px 13px',
    border: `2px solid ${focused ? '#E8581A' : '#E2E8F0'}`,
    borderRadius: '9px',
    fontSize: '14px',
    fontFamily: 'inherit',
    outline: 'none',
    background: '#FAFBFC',
    transition: 'border-color .2s',
  } as React.CSSProperties
}

function labelStyle() {
  return {
    display: 'block',
    fontSize: '10px',
    fontWeight: 600,
    color: '#64748B',
    textTransform: 'uppercase' as const,
    letterSpacing: '.7px',
    marginBottom: '4px',
  }
}

export function BankDepositsClient({ deposits, activeYearLabel, totalCollected, paymentCount }: Props) {
  const router = useRouter()
  const [isPending, startTransition] = useTransition()
  const [deletingId, setDeletingId] = useState<string | null>(null)
  const [form, setForm] = useState(EMPTY)
  const [formError, setFormError] = useState<string | null>(null)
  const [focused, setFocused] = useState<string | null>(null)
  const { role } = useUser()
  const canWrite = role !== 'cashier'

  const totalDeposited = deposits.reduce((s, d) => s + d.amount, 0)
  const cashInHand     = Math.max(0, totalCollected - totalDeposited)

  const bankSummary = useMemo(() => {
    const map = new Map<string, { total: number; count: number }>()
    for (const d of deposits) {
      const prev = map.get(d.bankName) ?? { total: 0, count: 0 }
      map.set(d.bankName, { total: prev.total + d.amount, count: prev.count + 1 })
    }
    return Array.from(map.entries())
      .sort((a, b) => b[1].total - a[1].total)
      .map(([name, v]) => ({ name, ...v }))
  }, [deposits])

  function set(field: keyof typeof EMPTY, value: string) {
    setForm(prev => ({ ...prev, [field]: value }))
  }

  function resetForm() {
    setForm({ ...EMPTY, depositDate: todayIso() })
    setFormError(null)
  }

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    const amount = parseFloat(form.amount)
    if (!Number.isFinite(amount) || amount <= 0) {
      setFormError('Amount must be greater than 0')
      return
    }
    setFormError(null)
    startTransition(async () => {
      const result = await createDeposit({
        bankName:    form.bankName.trim(),
        accountNo:   form.accountNo.trim(),
        amount,
        depositDate: form.depositDate,
        reference:   form.reference.trim() || null,
        remarks:     form.remarks.trim() || null,
      })
      if (result.error) { setFormError(result.error); return }
      toast.success('Deposit recorded')
      resetForm()
      router.refresh()
    })
  }

  function handleDelete(id: string, bankName: string) {
    if (!canWrite) return
    if (!window.confirm(`Delete deposit from ${bankName}? This cannot be undone.`)) return
    setDeletingId(id)
    startTransition(async () => {
      const result = await deleteDeposit(id)
      setDeletingId(null)
      if (result.error) { toast.error(`Delete failed: ${result.error}`); return }
      toast.success('Deposit deleted')
      router.refresh()
    })
  }

  function handleExport() {
    const csv = toCsv(
      ['Date', 'Bank', 'Account No', 'Amount', 'Reference', 'Remarks'],
      deposits.map(d => [d.depositDate, d.bankName, d.accountNo, d.amount, d.reference ?? '', d.remarks ?? ''])
    )
    const blob = new Blob([csv], { type: 'text/csv' })
    const url  = URL.createObjectURL(blob)
    const a    = document.createElement('a')
    a.href     = url
    a.download = `bank-deposits-${activeYearLabel}.csv`
    a.click()
    URL.revokeObjectURL(url)
  }

  const now = new Date()
  const dateStr = now.toLocaleDateString('en-IN', { weekday: 'short', day: 'numeric', month: 'short', year: 'numeric' })

  return (
    <div style={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>

      {/* ── Topbar ── */}
      <div style={{
        height: '62px',
        background: '#fff',
        borderBottom: '1px solid #E2E8F0',
        display: 'flex',
        alignItems: 'center',
        padding: '0 22px',
        gap: '12px',
        position: 'sticky',
        top: 0,
        zIndex: 100,
        boxShadow: '0 1px 3px rgba(0,0,0,.05)',
      }}>
        <div style={{ fontFamily: 'var(--font-poppins)', fontSize: '18px', fontWeight: 700, flex: 1, color: '#1A202C' }}>
          Bank Deposits
        </div>
        <div style={{ fontSize: '11px', color: '#64748B', whiteSpace: 'nowrap' }}>{dateStr}</div>
        <button
          onClick={handleExport}
          disabled={deposits.length === 0}
          style={{
            padding: '5px 12px',
            border: '1.5px solid #E2E8F0',
            borderRadius: '8px',
            fontSize: '12px',
            cursor: deposits.length === 0 ? 'not-allowed' : 'pointer',
            color: '#64748B',
            background: 'none',
            fontFamily: 'inherit',
            fontWeight: 500,
            opacity: deposits.length === 0 ? 0.5 : 1,
          }}
          onMouseOver={e => { if (deposits.length > 0) { e.currentTarget.style.borderColor = '#E8581A'; e.currentTarget.style.color = '#E8581A' }}}
          onMouseOut={e => { e.currentTarget.style.borderColor = '#E2E8F0'; e.currentTarget.style.color = '#64748B' }}
        >
          ↓ Export CSV
        </button>
      </div>

      {/* ── Content ── */}
      <div style={{ flex: 1, padding: '20px' }}>

        {/* ── Stat cards ── */}
        <div style={{ display: 'flex', gap: '12px', marginBottom: '18px', flexWrap: 'wrap' }}>
          <StatCard
            label="Total Collected"
            value={fmt(totalCollected)}
            sub={`${paymentCount} receipt${paymentCount !== 1 ? 's' : ''}`}
            accent="linear-gradient(#1A7A4A,#22A362)"
          />
          <StatCard
            label="Total Deposited"
            value={fmt(totalDeposited)}
            sub={`${deposits.length} deposit${deposits.length !== 1 ? 's' : ''}`}
            accent="linear-gradient(#1A4FA0,#2A6DD9)"
          />
          <StatCard
            label="Cash in Hand"
            value={fmt(cashInHand)}
            sub="Pending deposit"
            accent="linear-gradient(#C0392B,#E74C3C)"
          />
        </div>

        {/* ── 2-col: form + bank summary ── */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px', marginBottom: '16px' }}>

          {/* Record deposit form */}
          <div style={{
            background: '#fff',
            borderRadius: '14px',
            border: '1px solid #E2E8F0',
            boxShadow: '0 1px 3px rgba(0,0,0,.08),0 4px 16px rgba(0,0,0,.06)',
          }}>
            <div style={{
              padding: '13px 16px',
              borderBottom: '1px solid #E2E8F0',
              fontFamily: 'var(--font-poppins)',
              fontSize: '13.5px',
              fontWeight: 700,
              color: '#1A202C',
            }}>
              + Record Bank Deposit
            </div>
            <div style={{ padding: '17px 21px' }}>
              {canWrite ? (
                <form onSubmit={handleSubmit}>
                  {/* Bank name */}
                  <div style={{ marginBottom: '13px' }}>
                    <label style={labelStyle()}>Bank Name</label>
                    <select
                      value={form.bankName}
                      onChange={e => set('bankName', e.target.value)}
                      style={{
                        ...inputStyle(focused === 'bankName'),
                        cursor: 'pointer',
                      }}
                      onFocus={() => setFocused('bankName')}
                      onBlur={() => setFocused(null)}
                    >
                      {BANKS.map(b => <option key={b} value={b}>{b}</option>)}
                    </select>
                  </div>

                  {/* Account number */}
                  <div style={{ marginBottom: '13px' }}>
                    <label style={labelStyle()}>Account Number</label>
                    <input
                      type="text"
                      value={form.accountNo}
                      onChange={e => set('accountNo', e.target.value)}
                      placeholder="Bank account number"
                      required
                      style={inputStyle(focused === 'accountNo')}
                      onFocus={() => setFocused('accountNo')}
                      onBlur={() => setFocused(null)}
                    />
                  </div>

                  {/* Amount + Date side by side */}
                  <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '13px', marginBottom: '13px' }}>
                    <div>
                      <label style={labelStyle()}>Deposit Amount (₹)</label>
                      <input
                        type="number"
                        min="1"
                        step="1"
                        value={form.amount}
                        onChange={e => set('amount', e.target.value)}
                        placeholder="Amount"
                        required
                        style={inputStyle(focused === 'amount')}
                        onFocus={() => setFocused('amount')}
                        onBlur={() => setFocused(null)}
                      />
                    </div>
                    <div>
                      <label style={labelStyle()}>Deposit Date</label>
                      <input
                        type="date"
                        value={form.depositDate}
                        onChange={e => set('depositDate', e.target.value)}
                        required
                        style={inputStyle(focused === 'depositDate')}
                        onFocus={() => setFocused('depositDate')}
                        onBlur={() => setFocused(null)}
                      />
                    </div>
                  </div>

                  {/* Reference */}
                  <div style={{ marginBottom: '13px' }}>
                    <label style={labelStyle()}>Transaction / Challan Ref</label>
                    <input
                      type="text"
                      value={form.reference}
                      onChange={e => set('reference', e.target.value)}
                      placeholder="Reference number"
                      style={inputStyle(focused === 'reference')}
                      onFocus={() => setFocused('reference')}
                      onBlur={() => setFocused(null)}
                    />
                  </div>

                  {/* Remarks */}
                  <div style={{ marginBottom: '16px' }}>
                    <label style={labelStyle()}>Remarks</label>
                    <input
                      type="text"
                      value={form.remarks}
                      onChange={e => set('remarks', e.target.value)}
                      placeholder="Optional"
                      style={inputStyle(focused === 'remarks')}
                      onFocus={() => setFocused('remarks')}
                      onBlur={() => setFocused(null)}
                    />
                  </div>

                  {formError && (
                    <p style={{ color: '#C0392B', fontSize: '12px', marginBottom: '12px' }}>{formError}</p>
                  )}

                  <button
                    type="submit"
                    disabled={isPending}
                    style={{
                      width: '100%',
                      padding: '13px',
                      background: isPending ? '#ccc' : 'linear-gradient(135deg,#1A7A4A,#22A362)',
                      color: '#fff',
                      border: 'none',
                      borderRadius: '12px',
                      fontFamily: 'var(--font-poppins)',
                      fontSize: '16px',
                      fontWeight: 700,
                      cursor: isPending ? 'not-allowed' : 'pointer',
                      boxShadow: '0 2px 8px rgba(26,122,74,.3)',
                    }}
                  >
                    {isPending ? 'Saving…' : '🏦 Record Deposit'}
                  </button>
                </form>
              ) : (
                <p style={{ color: '#64748B', fontSize: '13px' }}>
                  You don&apos;t have permission to record deposits.
                </p>
              )}
            </div>
          </div>

          {/* Bank-wise summary */}
          <div style={{
            background: '#fff',
            borderRadius: '14px',
            border: '1px solid #E2E8F0',
            boxShadow: '0 1px 3px rgba(0,0,0,.08),0 4px 16px rgba(0,0,0,.06)',
          }}>
            <div style={{
              padding: '13px 16px',
              borderBottom: '1px solid #E2E8F0',
              fontFamily: 'var(--font-poppins)',
              fontSize: '13.5px',
              fontWeight: 700,
              color: '#1A202C',
            }}>
              🏦 Bank-wise Summary
            </div>
            <div style={{ overflowX: 'auto' }}>
              {bankSummary.length === 0 ? (
                <p style={{ textAlign: 'center', padding: '32px', color: '#64748B', fontSize: '13px' }}>
                  No deposits yet.
                </p>
              ) : (
                <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '12.5px' }}>
                  <thead>
                    <tr>
                      {['Bank', 'Deposits', 'Total Amount'].map(h => (
                        <th key={h} style={{
                          background: '#F1F5F9',
                          color: '#64748B',
                          fontSize: '10px',
                          textTransform: 'uppercase',
                          letterSpacing: '.7px',
                          padding: '8px 13px',
                          textAlign: 'left',
                          fontWeight: 600,
                          borderBottom: '1px solid #E2E8F0',
                        }}>{h}</th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {bankSummary.map(b => (
                      <tr key={b.name} style={{ borderBottom: '1px solid #F1F5F9' }}
                        onMouseOver={e => (e.currentTarget.style.background = '#FFF8F5')}
                        onMouseOut={e => (e.currentTarget.style.background = '')}>
                        <td style={{ padding: '8px 13px', fontWeight: 600 }}>{b.name}</td>
                        <td style={{ padding: '8px 13px', color: '#64748B' }}>{b.count}</td>
                        <td style={{ padding: '8px 13px', fontWeight: 700, color: '#1A7A4A' }}>
                          {fmt(b.total)}
                        </td>
                      </tr>
                    ))}
                    <tr style={{ borderTop: '2px solid #E2E8F0' }}>
                      <td style={{ padding: '8px 13px', fontWeight: 700 }}>Total</td>
                      <td style={{ padding: '8px 13px', fontWeight: 700 }}>{deposits.length}</td>
                      <td style={{ padding: '8px 13px', fontWeight: 800, color: '#1A4FA0', fontFamily: 'var(--font-poppins)' }}>
                        {fmt(totalDeposited)}
                      </td>
                    </tr>
                  </tbody>
                </table>
              )}
            </div>
          </div>
        </div>

        {/* ── Deposit history table ── */}
        {deposits.length > 0 && (
          <div style={{
            background: '#fff',
            borderRadius: '14px',
            border: '1px solid #E2E8F0',
            boxShadow: '0 1px 3px rgba(0,0,0,.08)',
          }}>
            <div style={{
              padding: '13px 16px',
              borderBottom: '1px solid #E2E8F0',
              display: 'flex',
              alignItems: 'center',
              gap: '10px',
            }}>
              <span style={{ fontFamily: 'var(--font-poppins)', fontSize: '13.5px', fontWeight: 700, flex: 1, color: '#1A202C' }}>
                Deposit History
              </span>
              <span style={{ fontSize: '11px', color: '#64748B' }}>{deposits.length} entries</span>
            </div>
            <div style={{ overflowX: 'auto' }}>
              <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '12.5px', minWidth: '700px' }}>
                <thead>
                  <tr>
                    {['Date', 'Bank', 'Account No', 'Amount', 'Reference', 'Remarks', ''].map(h => (
                      <th key={h} style={{
                        background: '#F1F5F9',
                        color: '#64748B',
                        fontSize: '10px',
                        textTransform: 'uppercase',
                        letterSpacing: '.7px',
                        padding: '8px 13px',
                        textAlign: 'left',
                        fontWeight: 600,
                        borderBottom: '1px solid #E2E8F0',
                        whiteSpace: 'nowrap',
                        position: 'sticky',
                        top: 0,
                      }}>{h}</th>
                    ))}
                  </tr>
                </thead>
                <tbody>
                  {deposits.map(d => (
                    <tr key={d.id} style={{ borderBottom: '1px solid #F1F5F9' }}
                      onMouseOver={e => (e.currentTarget.style.background = '#FFF8F5')}
                      onMouseOut={e => (e.currentTarget.style.background = '')}>
                      <td style={{ padding: '8px 13px', fontVariantNumeric: 'tabular-nums', color: '#64748B', fontSize: '11px' }}>
                        {d.depositDate}
                      </td>
                      <td style={{ padding: '8px 13px', fontWeight: 600 }}>{d.bankName}</td>
                      <td style={{ padding: '8px 13px', fontFamily: 'monospace', fontSize: '11px', color: '#64748B' }}>
                        {d.accountNo}
                      </td>
                      <td style={{ padding: '8px 13px', fontWeight: 700, color: '#1A7A4A' }}>
                        {fmt(d.amount)}
                      </td>
                      <td style={{ padding: '8px 13px', color: '#64748B', fontSize: '11px' }}>{d.reference ?? '—'}</td>
                      <td style={{ padding: '8px 13px', color: '#64748B', fontSize: '11px' }}>{d.remarks ?? '—'}</td>
                      <td style={{ padding: '8px 13px', textAlign: 'right' }}>
                        {canWrite && (
                          <button
                            onClick={() => handleDelete(d.id, d.bankName)}
                            disabled={isPending && deletingId === d.id}
                            style={{
                              background: 'none',
                              border: 'none',
                              cursor: 'pointer',
                              padding: '4px',
                              borderRadius: '6px',
                              color: '#94A3B8',
                              display: 'inline-flex',
                              alignItems: 'center',
                              opacity: (isPending && deletingId === d.id) ? 0.4 : 1,
                            }}
                            onMouseOver={e => { e.currentTarget.style.background = '#FEECEC'; e.currentTarget.style.color = '#C0392B' }}
                            onMouseOut={e => { e.currentTarget.style.background = 'none'; e.currentTarget.style.color = '#94A3B8' }}
                          >
                            <Trash2 size={14} />
                          </button>
                        )}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}

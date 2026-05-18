'use client'

import { useState, useMemo, useTransition } from 'react'
import { useUser } from '@/lib/user-context'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { StudentDialog } from './student-dialog'
import { StudentDetailModal } from './student-detail-modal'
import { deactivateStudent } from './actions'
import { toast } from 'sonner'
import { toCsv } from '@/lib/utils/csv'
import type { Gender } from '@/lib/types'
import type { StudentRow } from './page'

interface Props {
  rows: StudentRow[]
  classes: { id: string; name: string }[]
  routes: { id: string; name: string }[]
  activeYearLabel: string
  suggestedAdmNo: string
}

const PAGE_SIZE = 20
const ALL = '_all'

function StatusBadge({ status }: { status: string }) {
  const styles: Record<string, { bg: string; color: string; label: string }> = {
    paid:    { bg: '#EDFAF4', color: '#1A7A4A', label: 'Paid' },
    partial: { bg: '#FFFBEA', color: '#B8860B', label: 'Partial' },
    unpaid:  { bg: '#FEECEC', color: '#C0392B', label: 'Pending' },
  }
  const s = styles[status] ?? styles.unpaid
  return (
    <span style={{
      display: 'inline-flex', alignItems: 'center',
      padding: '2px 8px', borderRadius: '20px',
      fontSize: '10px', fontWeight: 600, whiteSpace: 'nowrap',
      background: s.bg, color: s.color,
    }}>
      {s.label}
    </span>
  )
}

function TransportBadge({ name }: { name: string | null }) {
  if (!name) {
    return (
      <span style={{
        display: 'inline-flex', alignItems: 'center',
        padding: '2px 7px', borderRadius: '20px',
        fontSize: '10px', fontWeight: 600,
        background: '#F1F5F9', color: '#475569',
      }}>
        OWN
      </span>
    )
  }
  const upper = name.toUpperCase()
  const isHostel = upper.includes('HOSTEL')
  if (isHostel) {
    return (
      <span style={{
        display: 'inline-flex', alignItems: 'center',
        padding: '2px 7px', borderRadius: '20px',
        fontSize: '10px', fontWeight: 600,
        background: '#F3EEFF', color: '#6B3FA0',
      }}>
        HOSTEL
      </span>
    )
  }
  return (
    <span style={{
      display: 'inline-flex', alignItems: 'center',
      padding: '2px 7px', borderRadius: '20px',
      fontSize: '10px', fontWeight: 600,
      background: '#EDFAF4', color: '#1A7A4A',
    }}>
      {name}
    </span>
  )
}

function ClassBadge({ name }: { name: string }) {
  return (
    <span style={{
      display: 'inline-flex', alignItems: 'center',
      padding: '2px 7px', borderRadius: '20px',
      fontSize: '10px', fontWeight: 600,
      background: '#EAF0FF', color: '#1A4FA0',
    }}>
      {name}
    </span>
  )
}

function GenderBadge({ gender }: { gender: string }) {
  const isMale = gender.toLowerCase() === 'male'
  return (
    <span style={{
      display: 'inline-flex', alignItems: 'center',
      padding: '2px 6px', borderRadius: '20px',
      fontSize: '10px', fontWeight: 600,
      background: isMale ? '#EFF6FF' : '#FDF2F8',
      color: isMale ? '#1D4ED8' : '#9D174D',
    }}>
      {isMale ? 'M' : 'F'}
    </span>
  )
}

export function StudentsClient({ rows, classes, routes, activeYearLabel, suggestedAdmNo }: Props) {
  const [search, setSearch]           = useState('')
  const [filterClass, setFilterClass] = useState(ALL)
  const [filterRoute, setFilterRoute] = useState(ALL)
  const [filterStatus, setFilterStatus] = useState(ALL)
  const [filterGender, setFilterGender] = useState(ALL)
  const [page, setPage]               = useState(1)
  const [dialogOpen, setDialogOpen]   = useState(false)
  const [editTarget, setEditTarget]   = useState<StudentRow | null>(null)
  const [viewTarget, setViewTarget]   = useState<StudentRow | null>(null)
  const [, startTransition]           = useTransition()
  const { role }                      = useUser()
  const canWrite                      = role !== 'cashier'

  const filtered = useMemo(() => {
    const q = search.trim().toLowerCase()
    return rows.filter(r => {
      if (filterClass  !== ALL && r.classId              !== filterClass)  return false
      if (filterRoute  !== ALL && (r.routeId ?? ALL)     !== filterRoute)  return false
      if (filterStatus !== ALL && r.status               !== filterStatus) return false
      if (filterGender !== ALL && r.gender               !== filterGender) return false
      if (q && !r.name.toLowerCase().includes(q)
            && !r.admNo.toLowerCase().includes(q)
            && !(r.village ?? '').toLowerCase().includes(q)) return false
      return true
    })
  }, [rows, search, filterClass, filterRoute, filterStatus, filterGender])

  const totalPages = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE))
  const safePage   = Math.min(page, totalPages)
  const paginated  = filtered.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE)

  const openAdd    = () => { setEditTarget(null); setDialogOpen(true) }
  const openEdit   = (row: StudentRow) => { setEditTarget(row); setDialogOpen(true) }
  const closeDialog = () => setDialogOpen(false)

  const handleDeactivate = (row: StudentRow) => {
    if (!confirm(`Deactivate "${row.name}"? They will be hidden from active lists.`)) return
    startTransition(async () => {
      try {
        await deactivateStudent(row.id)
        toast.success(`${row.name} deactivated`)
      } catch (e) {
        toast.error(e instanceof Error ? e.message : 'Failed to deactivate student')
      }
    })
  }

  const handleExportCsv = () => {
    const csv = toCsv(
      ['#', 'Adm No', 'Name', 'Gender', 'Class', 'Transport', 'Village', 'Mobile',
       'Total Fee', 'Paid', 'Balance', 'Status'],
      filtered.map((r, i) => [
        i + 1, r.admNo, r.name, r.gender, r.className, r.routeName ?? 'OWN',
        r.village ?? '', r.mobile ?? '',
        r.totalFee, r.totalPaid, r.balance, r.status,
      ])
    )
    const blob = new Blob([csv], { type: 'text/csv' })
    const url  = URL.createObjectURL(blob)
    const a    = document.createElement('a')
    a.href     = url
    a.download = `students-${activeYearLabel}.csv`
    a.click()
    URL.revokeObjectURL(url)
  }

  // Build page buttons (max 10 visible)
  const pageNums: number[] = []
  const maxPages = Math.min(totalPages, 10)
  let start = Math.max(1, safePage - 4)
  const end   = Math.min(totalPages, start + maxPages - 1)
  if (end - start < maxPages - 1) start = Math.max(1, end - maxPages + 1)
  for (let p = start; p <= end; p++) pageNums.push(p)

  const now = new Date()
  const dateStr = now.toLocaleDateString('en-IN', { weekday: 'short', day: 'numeric', month: 'short', year: 'numeric' })

  return (
    <div style={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>

      {/* ── Sticky topbar ── */}
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
          Students
        </div>
        <div style={{ fontSize: '11px', color: '#64748B', whiteSpace: 'nowrap' }}>
          {dateStr}
        </div>
        <button
          onClick={handleExportCsv}
          style={{
            padding: '5px 12px',
            border: '1.5px solid #E2E8F0',
            borderRadius: '8px',
            fontSize: '12px',
            cursor: 'pointer',
            color: '#64748B',
            background: 'none',
            fontFamily: 'inherit',
            fontWeight: 500,
          }}
          onMouseOver={e => { e.currentTarget.style.borderColor = '#E8581A'; e.currentTarget.style.color = '#E8581A' }}
          onMouseOut={e => { e.currentTarget.style.borderColor = '#E2E8F0'; e.currentTarget.style.color = '#64748B' }}
        >
          ↓ Export CSV
        </button>
        {canWrite && (
          <button
            onClick={openAdd}
            style={{
              display: 'inline-flex', alignItems: 'center', gap: '5px',
              padding: '7px 14px',
              borderRadius: '9px',
              fontSize: '12px', fontWeight: 600,
              fontFamily: 'inherit',
              cursor: 'pointer',
              border: 'none',
              background: 'linear-gradient(135deg,#E8581A,#FF7A3C)',
              color: '#fff',
              boxShadow: '0 2px 8px rgba(232,88,26,.3)',
            }}
          >
            + Add
          </button>
        )}
      </div>

      {/* ── Content ── */}
      <div style={{ flex: 1, padding: '20px' }}>

        {/* Card */}
        <div style={{
          background: '#fff',
          borderRadius: '14px',
          border: '1px solid #E2E8F0',
          boxShadow: '0 1px 3px rgba(0,0,0,.08),0 4px 16px rgba(0,0,0,.06)',
          marginBottom: '16px',
        }}>

          {/* Card header */}
          <div style={{
            padding: '13px 16px',
            borderBottom: '1px solid #E2E8F0',
            display: 'flex',
            alignItems: 'center',
            gap: '10px',
          }}>
            <span style={{ fontFamily: 'var(--font-poppins)', fontSize: '13.5px', fontWeight: 700, flex: 1, color: '#1A202C' }}>
              🎓 Student Directory — {rows.length} Students ({activeYearLabel})
            </span>
            <span style={{ fontSize: '11px', color: '#64748B' }}>
              Showing {filtered.length} of {rows.length}
            </span>
          </div>

          {/* Filter bar */}
          <div style={{
            display: 'flex',
            gap: '7px',
            alignItems: 'center',
            flexWrap: 'wrap',
            padding: '9px 14px',
            borderBottom: '1px solid #E2E8F0',
            background: '#FAFBFC',
          }}>
            {/* Search */}
            <div style={{ position: 'relative', flex: 1, minWidth: '150px' }}>
              <span style={{
                position: 'absolute', left: '8px', top: '50%', transform: 'translateY(-50%)',
                fontSize: '12px', color: '#64748B',
              }}>🔍</span>
              <input
                value={search}
                onChange={e => { setSearch(e.target.value); setPage(1) }}
                placeholder="Name / Adm No / Village…"
                style={{
                  width: '100%',
                  padding: '7px 10px 7px 28px',
                  border: '1.5px solid #E2E8F0',
                  borderRadius: '8px',
                  fontSize: '12px',
                  fontFamily: 'inherit',
                  outline: 'none',
                  background: '#fff',
                  transition: 'border-color .2s',
                }}
                onFocus={e => (e.currentTarget.style.borderColor = '#E8581A')}
                onBlur={e => (e.currentTarget.style.borderColor = '#E2E8F0')}
              />
            </div>

            <Select value={filterClass} onValueChange={v => { setFilterClass(v); setPage(1) }}>
              <SelectTrigger className="w-36 h-8 text-xs border-[#E2E8F0] bg-white">
                <SelectValue placeholder="All Classes" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value={ALL}>All Classes</SelectItem>
                {classes.map(c => <SelectItem key={c.id} value={c.id}>{c.name}</SelectItem>)}
              </SelectContent>
            </Select>

            <Select value={filterRoute} onValueChange={v => { setFilterRoute(v); setPage(1) }}>
              <SelectTrigger className="w-40 h-8 text-xs border-[#E2E8F0] bg-white">
                <SelectValue placeholder="All Transport" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value={ALL}>All Transport</SelectItem>
                {routes.map(r => <SelectItem key={r.id} value={r.id}>{r.name}</SelectItem>)}
              </SelectContent>
            </Select>

            <Select value={filterStatus} onValueChange={v => { setFilterStatus(v); setPage(1) }}>
              <SelectTrigger className="w-32 h-8 text-xs border-[#E2E8F0] bg-white">
                <SelectValue placeholder="All Status" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value={ALL}>All Status</SelectItem>
                <SelectItem value="paid">Paid</SelectItem>
                <SelectItem value="partial">Partial</SelectItem>
                <SelectItem value="unpaid">Pending</SelectItem>
              </SelectContent>
            </Select>

            <Select value={filterGender} onValueChange={v => { setFilterGender(v); setPage(1) }}>
              <SelectTrigger className="w-32 h-8 text-xs border-[#E2E8F0] bg-white">
                <SelectValue placeholder="All Gender" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value={ALL}>All Gender</SelectItem>
                <SelectItem value="male">Male</SelectItem>
                <SelectItem value="female">Female</SelectItem>
              </SelectContent>
            </Select>
          </div>

          {/* Table */}
          <div style={{ overflowX: 'auto', maxHeight: '560px', overflowY: 'auto' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '12.5px', minWidth: '900px' }}>
              <thead>
                <tr>
                  {['#', 'NAME', 'CLASS', 'TRANSPORT', 'VILLAGE', 'MOBILE', 'TOTAL FEE', 'BALANCE', 'STATUS', ''].map(h => (
                    <th
                      key={h}
                      style={{
                        background: '#F1F5F9',
                        color: '#64748B',
                        fontSize: '10px',
                        textTransform: 'uppercase',
                        letterSpacing: '.7px',
                        padding: '8px 13px',
                        textAlign: 'left',
                        position: 'sticky',
                        top: 0,
                        zIndex: 1,
                        whiteSpace: 'nowrap',
                        fontWeight: 600,
                        borderBottom: '1px solid #E2E8F0',
                      }}
                    >
                      {h}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {paginated.length === 0 ? (
                  <tr>
                    <td colSpan={10} style={{ textAlign: 'center', padding: '28px', color: '#64748B', fontSize: '13px' }}>
                      No students match the selected filters.
                    </td>
                  </tr>
                ) : paginated.map((row, idx) => (
                  <tr
                    key={row.id}
                    style={{ borderBottom: '1px solid #F1F5F9', transition: 'background .15s' }}
                    onMouseOver={e => (e.currentTarget.style.background = '#FFF8F5')}
                    onMouseOut={e => (e.currentTarget.style.background = '')}
                  >
                    {/* # */}
                    <td style={{ padding: '8px 13px', color: '#94A3B8', fontSize: '11px' }}>
                      {(safePage - 1) * PAGE_SIZE + idx + 1}
                    </td>
                    {/* NAME */}
                    <td style={{ padding: '8px 13px' }}>
                      <button
                        onClick={() => setViewTarget(row)}
                        style={{
                          background: 'none', border: 'none', cursor: 'pointer',
                          textAlign: 'left', padding: 0,
                          fontWeight: 600, color: '#1A202C', fontSize: '12.5px',
                        }}
                        onMouseOver={e => (e.currentTarget.style.color = '#1A4FA0')}
                        onMouseOut={e => (e.currentTarget.style.color = '#1A202C')}
                      >
                        {row.name}
                      </button>
                      <div style={{ fontSize: '10px', color: '#94A3B8', marginTop: '1px', fontFamily: 'monospace' }}>
                        {row.admNo} · <GenderBadge gender={row.gender} />
                      </div>
                    </td>
                    {/* CLASS */}
                    <td style={{ padding: '8px 13px' }}>
                      <ClassBadge name={row.className} />
                    </td>
                    {/* TRANSPORT */}
                    <td style={{ padding: '8px 13px' }}>
                      <TransportBadge name={row.routeName} />
                    </td>
                    {/* VILLAGE */}
                    <td style={{ padding: '8px 13px', fontSize: '11px', color: '#64748B' }}>
                      {row.village ?? '—'}
                    </td>
                    {/* MOBILE */}
                    <td style={{ padding: '8px 13px', fontSize: '11px', color: '#64748B' }}>
                      {row.mobile ?? '—'}
                    </td>
                    {/* TOTAL FEE */}
                    <td style={{ padding: '8px 13px', fontWeight: 600, color: '#1A202C', fontVariantNumeric: 'tabular-nums' }}>
                      ₹{row.totalFee.toLocaleString('en-IN')}
                    </td>
                    {/* BALANCE */}
                    <td style={{
                      padding: '8px 13px',
                      fontWeight: 700,
                      fontVariantNumeric: 'tabular-nums',
                      fontSize: '13.5px',
                      color: row.balance === 0 ? '#1A7A4A' : '#C0392B',
                    }}>
                      ₹{row.balance.toLocaleString('en-IN')}
                    </td>
                    {/* STATUS */}
                    <td style={{ padding: '8px 13px' }}>
                      <StatusBadge status={row.status} />
                    </td>
                    {/* ACTION */}
                    <td style={{ padding: '8px 13px', whiteSpace: 'nowrap' }}>
                      {canWrite && (
                        <div style={{ display: 'flex', gap: '4px' }}>
                          <button
                            onClick={() => openEdit(row)}
                            style={{
                              display: 'inline-flex', alignItems: 'center', gap: '3px',
                              padding: '3px 8px',
                              borderRadius: '7px',
                              fontSize: '10px', fontWeight: 600,
                              fontFamily: 'inherit',
                              cursor: 'pointer',
                              border: 'none',
                              background: 'linear-gradient(135deg,#E8581A,#FF7A3C)',
                              color: '#fff',
                            }}
                          >
                            ✏️ Edit
                          </button>
                          {row.isActive && (
                            <button
                              onClick={() => handleDeactivate(row)}
                              style={{
                                display: 'inline-flex', alignItems: 'center',
                                padding: '3px 7px',
                                borderRadius: '7px',
                                fontSize: '10px', fontWeight: 600,
                                fontFamily: 'inherit',
                                cursor: 'pointer',
                                background: '#fff',
                                color: '#C0392B',
                                border: '1.5px solid #E2E8F0',
                              }}
                            >
                              ✕
                            </button>
                          )}
                        </div>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* Pagination */}
          {totalPages > 1 && (
            <div style={{
              display: 'flex',
              gap: '4px',
              alignItems: 'center',
              padding: '9px 14px',
              borderTop: '1px solid #E2E8F0',
              flexWrap: 'wrap',
            }}>
              {pageNums.map(p => (
                <button
                  key={p}
                  onClick={() => setPage(p)}
                  style={{
                    padding: '4px 9px',
                    border: '1.5px solid',
                    borderColor: p === safePage ? '#E8581A' : '#E2E8F0',
                    borderRadius: '7px',
                    fontSize: '11px',
                    cursor: 'pointer',
                    fontFamily: 'inherit',
                    background: p === safePage ? '#E8581A' : '#fff',
                    color: p === safePage ? '#fff' : '#1A202C',
                    transition: 'all .2s',
                  }}
                >
                  {p}
                </button>
              ))}
              <div style={{ fontSize: '11px', color: '#64748B', flex: 1, textAlign: 'right' }}>
                {(safePage - 1) * PAGE_SIZE + 1}–{Math.min(safePage * PAGE_SIZE, filtered.length)} of {filtered.length}
              </div>
            </div>
          )}
        </div>
      </div>

      <StudentDialog
        open={dialogOpen}
        onClose={closeDialog}
        classes={classes}
        routes={routes}
        suggestedAdmNo={suggestedAdmNo}
        editData={editTarget ? {
          studentId:    editTarget.id,
          enrollmentId: editTarget.enrollmentId,
          name:         editTarget.name,
          gender:       editTarget.gender,
          village:      editTarget.village,
          mobile:       editTarget.mobile,
          classId:      editTarget.classId,
          routeId:      editTarget.routeId,
          admNo:        editTarget.admNo,
        } : undefined}
      />
      <StudentDetailModal
        student={viewTarget}
        onClose={() => setViewTarget(null)}
      />
    </div>
  )
}

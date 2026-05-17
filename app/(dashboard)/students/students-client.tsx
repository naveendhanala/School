'use client'

import { useState, useMemo, useTransition } from 'react'
import { useUser } from '@/lib/user-context'
import { Button } from '@/components/ui/button'
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

const STATUS_BADGE: Record<string, string> = {
  paid: 'bg-green-100 text-green-800',
  partial: 'bg-yellow-100 text-yellow-800',
  unpaid: 'bg-red-100 text-red-800',
}

export function StudentsClient({ rows, classes, routes, activeYearLabel, suggestedAdmNo }: Props) {
  const [filterClass, setFilterClass] = useState('')
  const [filterRoute, setFilterRoute] = useState('')
  const [filterStatus, setFilterStatus] = useState('')
  const [filterGender, setFilterGender] = useState('')
  const [page, setPage] = useState(1)
  const [dialogOpen, setDialogOpen] = useState(false)
  const [editTarget, setEditTarget] = useState<StudentRow | null>(null)
  const [viewTarget, setViewTarget] = useState<StudentRow | null>(null)
  const [, startTransition] = useTransition()
  const { role } = useUser()
  const canWrite = role !== 'cashier'

  const filtered = useMemo(() => rows.filter(r => {
    if (filterClass && r.classId !== filterClass) return false
    if (filterRoute && (r.routeId ?? '') !== filterRoute) return false
    if (filterStatus && r.status !== filterStatus) return false
    if (filterGender && r.gender !== filterGender) return false
    return true
  }), [rows, filterClass, filterRoute, filterStatus, filterGender])

  const totalPages = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE))
  const safePage = Math.min(page, totalPages)
  const paginated = filtered.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE)

  const openAdd = () => { setEditTarget(null); setDialogOpen(true) }
  const openEdit = (row: StudentRow) => { setEditTarget(row); setDialogOpen(true) }
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
      ['Adm No', 'Name', 'Gender', 'Class', 'Route', 'Village', 'Mobile',
       'Total Fee', 'Paid', 'Balance', 'Status'],
      filtered.map(r => [
        r.admNo, r.name, r.gender, r.className, r.routeName ?? '',
        r.village ?? '', r.mobile ?? '',
        r.totalFee, r.totalPaid, r.balance, r.status,
      ])
    )
    const blob = new Blob([csv], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `students-${activeYearLabel}.csv`
    a.click()
    URL.revokeObjectURL(url)
  }

  return (
    <div className="p-6">
      {/* Header */}
      <div className="flex items-start justify-between mb-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Students</h1>
          <p className="text-gray-500 text-sm mt-0.5">
            {activeYearLabel} · {filtered.length} of {rows.length} students
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" size="sm" onClick={handleExportCsv}>
            Export CSV
          </Button>
          {canWrite && (
            <Button size="sm" onClick={openAdd}>+ Add Student</Button>
          )}
        </div>
      </div>

      {/* Filters */}
      <div className="flex gap-3 mb-4 flex-wrap">
        <Select value={filterClass} onValueChange={v => { setFilterClass(v); setPage(1) }}>
          <SelectTrigger className="w-36">
            <SelectValue placeholder="All Classes" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="">All Classes</SelectItem>
            {classes.map(c => <SelectItem key={c.id} value={c.id}>{c.name}</SelectItem>)}
          </SelectContent>
        </Select>

        <Select value={filterRoute} onValueChange={v => { setFilterRoute(v); setPage(1) }}>
          <SelectTrigger className="w-44">
            <SelectValue placeholder="All Routes" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="">All Routes</SelectItem>
            {routes.map(r => <SelectItem key={r.id} value={r.id}>{r.name}</SelectItem>)}
          </SelectContent>
        </Select>

        <Select value={filterStatus} onValueChange={v => { setFilterStatus(v); setPage(1) }}>
          <SelectTrigger className="w-36">
            <SelectValue placeholder="All Statuses" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="">All Statuses</SelectItem>
            <SelectItem value="paid">Paid</SelectItem>
            <SelectItem value="partial">Partial</SelectItem>
            <SelectItem value="unpaid">Unpaid</SelectItem>
          </SelectContent>
        </Select>

        <Select value={filterGender} onValueChange={v => { setFilterGender(v); setPage(1) }}>
          <SelectTrigger className="w-36">
            <SelectValue placeholder="All Genders" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="">All Genders</SelectItem>
            <SelectItem value="male">Male</SelectItem>
            <SelectItem value="female">Female</SelectItem>
          </SelectContent>
        </Select>
      </div>

      {/* Table */}
      <div className="overflow-x-auto rounded border">
        <table className="w-full text-sm min-w-[900px]">
          <thead className="bg-gray-50">
            <tr>
              {['Adm No', 'Name', 'Class', 'Route', 'Village', 'Mobile',
                'Total', 'Paid', 'Balance', 'Status', ''].map(h => (
                <th key={h} scope="col" className="text-left px-3 py-2 font-medium text-gray-600 whitespace-nowrap">
                  {h}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {paginated.length === 0 ? (
              <tr>
                <td colSpan={11} className="text-center py-10 text-gray-400">
                  No students match the selected filters.
                </td>
              </tr>
            ) : paginated.map(row => (
              <tr key={row.id} className="border-t hover:bg-gray-50">
                <td className="px-3 py-2 text-gray-500">{row.admNo}</td>
                <td className="px-3 py-2 font-medium">
                  <button
                    onClick={() => setViewTarget(row)}
                    className="hover:underline text-left"
                  >
                    {row.name}
                  </button>
                </td>
                <td className="px-3 py-2">{row.className}</td>
                <td className="px-3 py-2">{row.routeName ?? '—'}</td>
                <td className="px-3 py-2">{row.village ?? '—'}</td>
                <td className="px-3 py-2">{row.mobile ?? '—'}</td>
                <td className="px-3 py-2 tabular-nums">₹{row.totalFee.toLocaleString('en-IN')}</td>
                <td className="px-3 py-2 tabular-nums">₹{row.totalPaid.toLocaleString('en-IN')}</td>
                <td className="px-3 py-2 tabular-nums">₹{row.balance.toLocaleString('en-IN')}</td>
                <td className="px-3 py-2">
                  <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${STATUS_BADGE[row.status]}`}>
                    {row.status}
                  </span>
                </td>
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
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="flex items-center gap-2 mt-4 justify-end text-sm">
          <Button
            variant="outline"
            size="sm"
            disabled={safePage === 1}
            onClick={() => setPage(p => p - 1)}
          >
            Previous
          </Button>
          <span className="text-gray-600">Page {safePage} of {totalPages}</span>
          <Button
            variant="outline"
            size="sm"
            disabled={safePage === totalPages}
            onClick={() => setPage(p => p + 1)}
          >
            Next
          </Button>
        </div>
      )}

      <StudentDialog
        open={dialogOpen}
        onClose={closeDialog}
        classes={classes}
        routes={routes}
        suggestedAdmNo={suggestedAdmNo}
        editData={editTarget ? {
          studentId: editTarget.id,
          enrollmentId: editTarget.enrollmentId,
          name: editTarget.name,
          gender: editTarget.gender,
          village: editTarget.village,
          mobile: editTarget.mobile,
          classId: editTarget.classId,
          routeId: editTarget.routeId,
          admNo: editTarget.admNo,
        } : undefined}
      />
      <StudentDetailModal
        student={viewTarget}
        onClose={() => setViewTarget(null)}
      />
    </div>
  )
}

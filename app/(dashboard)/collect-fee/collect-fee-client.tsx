'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { StudentSearch } from './student-search'
import { FeeBreakdown } from './fee-breakdown'
import { PaymentHistory } from './payment-history'
import { PaymentForm } from './payment-form'
import type { CollectFeeStudent } from './page'

interface CollectFeeClientProps {
  students: CollectFeeStudent[]
}

export function CollectFeeClient({ students }: CollectFeeClientProps) {
  const [selected, setSelected] = useState<CollectFeeStudent | null>(null)
  const router = useRouter()

  // Sync selected student with refreshed server data after router.refresh()
  useEffect(() => {
    if (!selected) return
    const updated = students.find(s => s.id === selected.id)
    if (updated) setSelected(updated)
  }, [students]) // eslint-disable-line react-hooks/exhaustive-deps

  function handleSuccess(paymentId: string) {
    window.open(`/receipt/${paymentId}`, '_blank')
    router.refresh()
  }

  return (
    <div className="space-y-6 p-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Collect Fee</h1>
        <p className="mt-1 text-gray-500">Search for a student to record a payment</p>
      </div>

      <StudentSearch students={students} selected={selected} onSelect={setSelected} />

      {selected && (
        <div className="grid grid-cols-1 gap-6 lg:grid-cols-3">
          {/* Left: student card + breakdown + payment form */}
          <div className="space-y-6 lg:col-span-2">
            <div className="rounded-lg border bg-white p-4">
              <p className="font-semibold text-gray-900">{selected.name}</p>
              <p className="text-sm text-gray-500">
                {selected.admNo} · {selected.className}
                {selected.routeName ? ` · ${selected.routeName}` : ''}
              </p>
              <div className="mt-4">
                <FeeBreakdown student={selected} />
              </div>
            </div>

            <div className="rounded-lg border bg-white p-4">
              <h2 className="mb-4 font-semibold text-gray-900">Record Payment</h2>
              <PaymentForm student={selected} onSuccess={handleSuccess} />
            </div>
          </div>

          {/* Right: payment history */}
          <div className="rounded-lg border bg-white p-4">
            <h2 className="mb-4 font-semibold text-gray-900">Payment History</h2>
            <PaymentHistory payments={selected.payments} />
          </div>
        </div>
      )}
    </div>
  )
}

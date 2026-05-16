'use client'

import { useEffect } from 'react'

export function ReceiptActions() {
  useEffect(() => {
    window.print()
  }, [])

  return (
    <div className="no-print mt-6 flex justify-center gap-3">
      <button
        onClick={() => window.print()}
        className="rounded bg-blue-600 px-4 py-2 text-sm text-white hover:bg-blue-700"
      >
        Print
      </button>
      <button
        onClick={() => window.close()}
        className="rounded border px-4 py-2 text-sm hover:bg-gray-50"
      >
        Close
      </button>
    </div>
  )
}

'use client'

import { useState, useRef, useEffect } from 'react'
import { Input } from '@/components/ui/input'
import { Search, X } from 'lucide-react'
import type { CollectFeeStudent } from './page'

interface StudentSearchProps {
  students: CollectFeeStudent[]
  selected: CollectFeeStudent | null
  onSelect: (s: CollectFeeStudent | null) => void
}

export function StudentSearch({ students, selected, onSelect }: StudentSearchProps) {
  const [query, setQuery] = useState('')
  const [open, setOpen] = useState(false)
  const containerRef = useRef<HTMLDivElement>(null)

  const filtered =
    query.trim().length < 1
      ? []
      : students
          .filter(
            s =>
              s.name.toLowerCase().includes(query.toLowerCase()) ||
              s.admNo.toLowerCase().includes(query.toLowerCase())
          )
          .slice(0, 10)

  useEffect(() => {
    function handleClick(e: MouseEvent) {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setOpen(false)
      }
    }
    document.addEventListener('mousedown', handleClick)
    return () => document.removeEventListener('mousedown', handleClick)
  }, [])

  function handleSelect(s: CollectFeeStudent) {
    onSelect(s)
    setQuery('')
    setOpen(false)
  }

  function handleClear() {
    onSelect(null)
    setQuery('')
  }

  return (
    <div ref={containerRef} className="relative w-full max-w-md">
      {selected ? (
        <div className="flex items-center gap-2 rounded-md border border-blue-200 bg-blue-50 px-3 py-2">
          <span className="flex-1 text-sm font-medium text-blue-900">
            {selected.name}{' '}
            <span className="font-normal text-blue-500">({selected.admNo})</span>
          </span>
          <button
            type="button"
            onClick={handleClear}
            className="text-blue-400 hover:text-blue-700"
            aria-label="Clear selection"
          >
            <X className="h-4 w-4" />
          </button>
        </div>
      ) : (
        <>
          <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400" />
          <Input
            className="pl-9"
            placeholder="Search by name or admission no…"
            value={query}
            onChange={e => {
              setQuery(e.target.value)
              setOpen(true)
            }}
            onFocus={() => setOpen(true)}
            aria-label="Search student"
          />
          {open && filtered.length > 0 && (
            <div className="absolute z-10 mt-1 max-h-60 w-full overflow-auto rounded-md border border-gray-200 bg-white shadow-lg">
              {filtered.map(s => (
                <button
                  key={s.id}
                  type="button"
                  className="flex w-full items-center justify-between px-3 py-2 text-left text-sm hover:bg-gray-50"
                  onClick={() => handleSelect(s)}
                >
                  <span className="font-medium">{s.name}</span>
                  <span className="text-xs text-gray-500">
                    {s.admNo} · {s.className}
                  </span>
                </button>
              ))}
            </div>
          )}
        </>
      )}
    </div>
  )
}

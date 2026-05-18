export default function ReportsLoading() {
  return (
    <div className="space-y-4 p-6 animate-pulse">
      <div className="h-8 w-24 rounded bg-gray-200" />
      <div className="flex gap-2">
        {Array.from({ length: 5 }).map((_, i) => (
          <div key={i} className="h-9 w-28 rounded bg-gray-200" />
        ))}
      </div>
      <div className="rounded-lg border bg-white">
        <div className="divide-y">
          {Array.from({ length: 10 }).map((_, i) => (
            <div key={i} className="flex items-center gap-4 px-4 py-3">
              <div className="h-4 w-20 rounded bg-gray-200" />
              <div className="h-4 w-36 rounded bg-gray-200" />
              <div className="ml-auto h-4 w-20 rounded bg-gray-200" />
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}

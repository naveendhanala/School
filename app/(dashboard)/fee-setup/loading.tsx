export default function FeeSetupLoading() {
  return (
    <div className="space-y-6 p-6 animate-pulse">
      <div className="h-8 w-28 rounded bg-gray-200" />
      <div className="grid gap-4">
        {Array.from({ length: 4 }).map((_, i) => (
          <div key={i} className="rounded-lg border bg-white p-4">
            <div className="h-5 w-32 rounded bg-gray-200" />
            <div className="mt-3 h-4 w-full rounded bg-gray-100" />
          </div>
        ))}
      </div>
    </div>
  )
}

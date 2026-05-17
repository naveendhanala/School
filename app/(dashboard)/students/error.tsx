'use client'

export default function StudentsError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <div className="p-6">
      <h2 className="text-lg font-semibold text-red-600 mb-2">Students page error</h2>
      <pre className="text-sm bg-red-50 border border-red-200 rounded p-3 whitespace-pre-wrap break-all">
        {error.message}
        {error.digest ? `\nDigest: ${error.digest}` : ''}
        {'\n\nStack:\n'}
        {error.stack}
      </pre>
      <button
        onClick={reset}
        className="mt-4 rounded bg-blue-600 px-4 py-2 text-sm text-white hover:bg-blue-700"
      >
        Try again
      </button>
    </div>
  )
}

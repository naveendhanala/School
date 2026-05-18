interface NoActiveYearProps {
  title: string
}

export function NoActiveYear({ title }: NoActiveYearProps) {
  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold text-gray-900">{title}</h1>
      <p className="mt-2 text-gray-500">No active academic year. Set one up in Fee Setup.</p>
    </div>
  )
}

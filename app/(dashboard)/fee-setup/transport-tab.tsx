import { createClient } from '@/lib/supabase/server'
import { TransportRouteRow } from './transport-route-row'
import { AddRouteForm } from './add-route-form'

export async function TransportTab() {
  const supabase = await createClient()
  const { data: routes } = await supabase
    .from('transport_routes')
    .select('id, name, fee_amount')
    .order('name')

  return (
    <div className="mt-4 space-y-6">
      <div>
        <h3 className="font-medium mb-3">Add New Route</h3>
        <AddRouteForm />
      </div>
      <div>
        <h3 className="font-medium mb-3">Existing Routes</h3>
        {(routes ?? []).length === 0 ? (
          <p className="text-gray-500 text-sm">No transport routes configured.</p>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b bg-gray-50">
                  <th scope="col" className="text-left px-3 py-2 font-medium text-gray-600">Route Name</th>
                  <th scope="col" className="text-left px-3 py-2 font-medium text-gray-600">Annual Fee (₹)</th>
                  <th scope="col" className="px-3 py-2"></th>
                </tr>
              </thead>
              <tbody>
                {routes!.map(route => (
                  <TransportRouteRow
                    key={route.id}
                    id={route.id}
                    name={route.name}
                    feeAmount={Number(route.fee_amount)}
                  />
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  )
}

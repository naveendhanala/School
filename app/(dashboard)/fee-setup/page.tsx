import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { ClassFeesTab } from './class-fees-tab'
import { TransportTab } from './transport-tab'

export default function FeeSetupPage() {
  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold text-gray-900">Fee Setup</h1>
      <p className="text-gray-500 mt-1 mb-6">Configure fees for the active academic year</p>
      <Tabs defaultValue="class-fees">
        <TabsList>
          <TabsTrigger value="class-fees">Class Fees</TabsTrigger>
          <TabsTrigger value="transport">Transport Routes</TabsTrigger>
          <TabsTrigger value="academic-year">Academic Year</TabsTrigger>
        </TabsList>
        <TabsContent value="class-fees">
          <ClassFeesTab />
        </TabsContent>
        <TabsContent value="transport">
          <TransportTab />
        </TabsContent>
        <TabsContent value="academic-year">
          <div className="mt-4 p-4 bg-gray-50 rounded border text-gray-500 text-sm">
            Academic year management coming in a future update.
          </div>
        </TabsContent>
      </Tabs>
    </div>
  )
}

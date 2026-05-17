import { Suspense } from 'react'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { ClassFeesTab } from './class-fees-tab'
import { TransportTab } from './transport-tab'
import { AcademicYearTab } from './academic-year-tab'
import { FeeReferenceTab } from './fee-reference-tab'

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
          <TabsTrigger value="fee-reference">Fee Reference</TabsTrigger>
        </TabsList>
        <TabsContent value="class-fees">
          <Suspense fallback={<div className="mt-4 p-4 text-sm text-gray-400">Loading class fees…</div>}>
            <ClassFeesTab />
          </Suspense>
        </TabsContent>
        <TabsContent value="transport">
          <Suspense fallback={<div className="mt-4 p-4 text-sm text-gray-400">Loading transport routes…</div>}>
            <TransportTab />
          </Suspense>
        </TabsContent>
        <TabsContent value="academic-year">
          <Suspense fallback={<div className="mt-4 p-4 text-sm text-gray-400">Loading…</div>}>
            <AcademicYearTab />
          </Suspense>
        </TabsContent>
        <TabsContent value="fee-reference">
          <Suspense fallback={<div className="mt-4 p-4 text-sm text-gray-400">Loading fee reference…</div>}>
            <FeeReferenceTab />
          </Suspense>
        </TabsContent>
      </Tabs>
    </div>
  )
}

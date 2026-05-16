export type Role = 'admin' | 'accountant' | 'cashier'
export type FeeHead = 'tuition' | 'book' | 'transport' | 'hostel' | 'admission' | 'uniform' | 'exam' | 'other'
export type ClassFeeHead = 'tuition' | 'book'
export type StudentFeeHead = 'hostel' | 'admission' | 'uniform' | 'exam' | 'other'
export type PaymentMode = 'cash' | 'upi' | 'cheque' | 'neft_rtgs' | 'demand_draft'
export type Course = 'IIT' | 'NON-IIT'
export type Gender = 'male' | 'female'
export type BridgePaymentMode = 'cash' | 'phonepe' | 'hdfc'

export interface AcademicYear {
  id: string
  label: string
  is_active: boolean
  created_at: string
}

export interface Class {
  id: string
  name: string
  sort_order: number
}

export interface TransportRoute {
  id: string
  name: string
  fee_amount: number
}

export interface Student {
  id: string
  adm_no: string
  name: string
  gender: Gender
  village: string | null
  mobile: string | null
  is_active: boolean
  created_at: string
}

export interface Enrollment {
  id: string
  student_id: string
  academic_year_id: string
  class_id: string
  route_id: string | null
}

export interface FeeStructure {
  id: string
  academic_year_id: string
  class_id: string
  fee_head: ClassFeeHead
  amount: number
}

export interface StudentFee {
  id: string
  enrollment_id: string
  fee_head: StudentFeeHead
  amount: number
}

export interface Payment {
  id: string
  enrollment_id: string
  fee_head: FeeHead
  amount: number
  mode: PaymentMode
  payment_date: string
  reference: string | null
  receipt_no: string
  remarks: string | null
  created_at: string
  created_by: string | null
}

export interface BankDeposit {
  id: string
  academic_year_id: string
  bank_name: string
  account_no: string
  amount: number
  deposit_date: string
  reference: string | null
  remarks: string | null
  created_at: string
}

export interface BridgeStudent {
  id: string
  academic_year_id: string
  voucher_no: string
  name: string
  course: Course
  gender: Gender
  phone: string | null
  total_fee: number
  created_at: string
}

export interface BridgePayment {
  id: string
  bridge_student_id: string
  mode: BridgePaymentMode
  amount: number
}

export interface BridgeDeposit {
  id: string
  academic_year_id: string
  bank_name: string
  amount: number
  deposit_date: string
  reference: string | null
  created_at: string
}

export interface Profile {
  id: string
  name: string
  role: Role
}

export interface ReceiptSequence {
  academic_year_id: string
  last_number: number
}

// Supabase Database type (used to type the client)
export type Database = {
  public: {
    Tables: {
      academic_years: {
        Row: AcademicYear
        Insert: Omit<AcademicYear, 'id' | 'created_at'>
        Update: Partial<Omit<AcademicYear, 'id'>>
      }
      classes: {
        Row: Class
        Insert: Omit<Class, 'id'>
        Update: Partial<Omit<Class, 'id'>>
      }
      transport_routes: {
        Row: TransportRoute
        Insert: Omit<TransportRoute, 'id'>
        Update: Partial<Omit<TransportRoute, 'id'>>
      }
      students: {
        Row: Student
        Insert: Omit<Student, 'id' | 'created_at'>
        Update: Partial<Omit<Student, 'id' | 'created_at'>>
      }
      enrollments: {
        Row: Enrollment
        Insert: Omit<Enrollment, 'id'>
        Update: Partial<Omit<Enrollment, 'id'>>
      }
      fee_structure: {
        Row: FeeStructure
        Insert: Omit<FeeStructure, 'id'>
        Update: Partial<Omit<FeeStructure, 'id'>>
      }
      student_fees: {
        Row: StudentFee
        Insert: Omit<StudentFee, 'id'>
        Update: Partial<Omit<StudentFee, 'id'>>
      }
      receipt_sequences: {
        Row: ReceiptSequence
        Insert: { academic_year_id: string; last_number?: number }
        Update: { last_number?: number }
      }
      payments: {
        Row: Payment
        Insert: Omit<Payment, 'id' | 'created_at'>
        Update: Partial<Omit<Payment, 'id' | 'created_at'>>
      }
      bank_deposits: {
        Row: BankDeposit
        Insert: Omit<BankDeposit, 'id' | 'created_at'>
        Update: Partial<Omit<BankDeposit, 'id' | 'created_at'>>
      }
      bridge_students: {
        Row: BridgeStudent
        Insert: Omit<BridgeStudent, 'id' | 'created_at'>
        Update: Partial<Omit<BridgeStudent, 'id' | 'created_at'>>
      }
      bridge_payments: {
        Row: BridgePayment
        Insert: Omit<BridgePayment, 'id'>
        Update: Partial<Omit<BridgePayment, 'id'>>
      }
      bridge_deposits: {
        Row: BridgeDeposit
        Insert: Omit<BridgeDeposit, 'id' | 'created_at'>
        Update: Partial<Omit<BridgeDeposit, 'id' | 'created_at'>>
      }
      profiles: {
        Row: Profile
        Insert: Profile
        Update: Partial<Omit<Profile, 'id'>>
      }
    }
    Functions: {
      next_receipt_number: {
        Args: { year_id: string }
        Returns: string
      }
      get_user_role: {
        Args: Record<string, never>
        Returns: string
      }
    }
  }
}

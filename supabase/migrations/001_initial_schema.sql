-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Classes (fixed list, seeded)
CREATE TABLE classes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL UNIQUE,
  sort_order INT NOT NULL
);

INSERT INTO classes (name, sort_order) VALUES
  ('LKG', 1), ('UKG', 2),
  ('I', 3), ('II', 4), ('III', 5), ('IV', 6), ('V', 7),
  ('VI', 8), ('VII', 9), ('VIII', 10), ('IX', 11), ('X', 12);

-- Configurable transport routes
CREATE TABLE transport_routes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL UNIQUE,
  fee_amount NUMERIC(10,2) NOT NULL DEFAULT 0
);

-- Academic years
CREATE TABLE academic_years (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  label TEXT NOT NULL UNIQUE,
  is_active BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Students (identity, not year-specific)
CREATE TABLE students (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  adm_no TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  gender TEXT NOT NULL CHECK (gender IN ('male', 'female')),
  village TEXT,
  mobile TEXT,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Student per academic year
CREATE TABLE enrollments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id UUID NOT NULL REFERENCES students(id),
  academic_year_id UUID NOT NULL REFERENCES academic_years(id),
  class_id UUID NOT NULL REFERENCES classes(id),
  route_id UUID REFERENCES transport_routes(id),
  UNIQUE(student_id, academic_year_id)
);

-- Class-level fees (tuition + book per class per year)
CREATE TABLE fee_structure (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  academic_year_id UUID NOT NULL REFERENCES academic_years(id),
  class_id UUID NOT NULL REFERENCES classes(id),
  fee_head TEXT NOT NULL CHECK (fee_head IN ('tuition', 'book')),
  amount NUMERIC(10,2) NOT NULL DEFAULT 0,
  UNIQUE(academic_year_id, class_id, fee_head)
);

-- Per-student fees (hostel, admission, uniform, exam, other)
CREATE TABLE student_fees (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  enrollment_id UUID NOT NULL REFERENCES enrollments(id),
  fee_head TEXT NOT NULL CHECK (fee_head IN ('hostel', 'admission', 'uniform', 'exam', 'other')),
  amount NUMERIC(10,2) NOT NULL DEFAULT 0,
  UNIQUE(enrollment_id, fee_head)
);

-- Receipt sequence per academic year (for atomic receipt number generation)
CREATE TABLE receipt_sequences (
  academic_year_id UUID PRIMARY KEY REFERENCES academic_years(id),
  last_number INT NOT NULL DEFAULT 0
);

-- Payments
CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  enrollment_id UUID NOT NULL REFERENCES enrollments(id),
  fee_head TEXT NOT NULL CHECK (fee_head IN ('tuition', 'book', 'transport', 'hostel', 'admission', 'uniform', 'exam', 'other')),
  amount NUMERIC(10,2) NOT NULL,
  mode TEXT NOT NULL CHECK (mode IN ('cash', 'upi', 'cheque', 'neft_rtgs', 'demand_draft')),
  payment_date DATE NOT NULL,
  reference TEXT,
  receipt_no TEXT NOT NULL UNIQUE,
  remarks TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by UUID REFERENCES auth.users(id)
);

-- Bank deposits (main)
CREATE TABLE bank_deposits (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  academic_year_id UUID NOT NULL REFERENCES academic_years(id),
  bank_name TEXT NOT NULL,
  account_no TEXT NOT NULL,
  amount NUMERIC(10,2) NOT NULL,
  deposit_date DATE NOT NULL,
  reference TEXT,
  remarks TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Bridge course students
CREATE TABLE bridge_students (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  academic_year_id UUID NOT NULL REFERENCES academic_years(id),
  voucher_no TEXT NOT NULL,
  name TEXT NOT NULL,
  course TEXT NOT NULL CHECK (course IN ('IIT', 'NON-IIT')),
  gender TEXT NOT NULL CHECK (gender IN ('male', 'female')),
  phone TEXT,
  total_fee NUMERIC(10,2) NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Bridge payments
CREATE TABLE bridge_payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  bridge_student_id UUID NOT NULL REFERENCES bridge_students(id),
  mode TEXT NOT NULL CHECK (mode IN ('cash', 'phonepe', 'hdfc')),
  amount NUMERIC(10,2) NOT NULL
);

-- Bridge deposits
CREATE TABLE bridge_deposits (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  academic_year_id UUID NOT NULL REFERENCES academic_years(id),
  bank_name TEXT NOT NULL,
  amount NUMERIC(10,2) NOT NULL,
  deposit_date DATE NOT NULL,
  reference TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- User profiles (extends Supabase auth.users)
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('admin', 'accountant', 'cashier'))
);

-- Atomic receipt number generator
CREATE OR REPLACE FUNCTION next_receipt_number(year_id UUID)
RETURNS TEXT AS $$
DECLARE
  year_label TEXT;
  next_num INT;
BEGIN
  SELECT label INTO year_label FROM academic_years WHERE id = year_id;

  IF year_label IS NULL THEN
    RAISE EXCEPTION 'Academic year % not found', year_id;
  END IF;

  INSERT INTO receipt_sequences (academic_year_id, last_number)
  VALUES (year_id, 1)
  ON CONFLICT (academic_year_id)
  DO UPDATE SET last_number = receipt_sequences.last_number + 1
  RETURNING last_number INTO next_num;

  RETURN year_label || '-' || LPAD(next_num::TEXT, 6, '0');
END;
$$ LANGUAGE plpgsql;

-- ── Row Level Security ───────────────────────────────────────────────────────

ALTER TABLE classes ENABLE ROW LEVEL SECURITY;
ALTER TABLE transport_routes ENABLE ROW LEVEL SECURITY;
ALTER TABLE academic_years ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE enrollments ENABLE ROW LEVEL SECURITY;
ALTER TABLE fee_structure ENABLE ROW LEVEL SECURITY;
ALTER TABLE student_fees ENABLE ROW LEVEL SECURITY;
ALTER TABLE receipt_sequences ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE bank_deposits ENABLE ROW LEVEL SECURITY;
ALTER TABLE bridge_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE bridge_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE bridge_deposits ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Helper: get current user's role
CREATE OR REPLACE FUNCTION get_user_role()
RETURNS TEXT AS $$
  SELECT role FROM profiles WHERE id = auth.uid()
$$ LANGUAGE sql SECURITY DEFINER STABLE
SET search_path = public;

-- Classes: all authenticated users can read (fixed list)
CREATE POLICY "auth_read_classes" ON classes FOR SELECT TO authenticated USING (true);

-- Transport routes: all read; admin manages
CREATE POLICY "auth_read_routes" ON transport_routes FOR SELECT TO authenticated USING (true);
CREATE POLICY "admin_manage_routes" ON transport_routes FOR ALL TO authenticated
  USING (get_user_role() = 'admin') WITH CHECK (get_user_role() = 'admin');

-- Academic years: all read; admin manages
CREATE POLICY "auth_read_years" ON academic_years FOR SELECT TO authenticated USING (true);
CREATE POLICY "admin_manage_years" ON academic_years FOR ALL TO authenticated
  USING (get_user_role() = 'admin') WITH CHECK (get_user_role() = 'admin');

-- Students: all read; admin + accountant manage
CREATE POLICY "auth_read_students" ON students FOR SELECT TO authenticated USING (true);
CREATE POLICY "admin_accountant_manage_students" ON students FOR ALL TO authenticated
  USING (get_user_role() IN ('admin', 'accountant'))
  WITH CHECK (get_user_role() IN ('admin', 'accountant'));

-- Enrollments: all read; admin + accountant manage
CREATE POLICY "auth_read_enrollments" ON enrollments FOR SELECT TO authenticated USING (true);
CREATE POLICY "admin_accountant_manage_enrollments" ON enrollments FOR ALL TO authenticated
  USING (get_user_role() IN ('admin', 'accountant'))
  WITH CHECK (get_user_role() IN ('admin', 'accountant'));

-- Fee structure: all read; admin manages
CREATE POLICY "auth_read_fee_structure" ON fee_structure FOR SELECT TO authenticated USING (true);
CREATE POLICY "admin_manage_fee_structure" ON fee_structure FOR ALL TO authenticated
  USING (get_user_role() = 'admin') WITH CHECK (get_user_role() = 'admin');

-- Student fees: all read; admin + accountant manage
CREATE POLICY "auth_read_student_fees" ON student_fees FOR SELECT TO authenticated USING (true);
CREATE POLICY "admin_accountant_manage_student_fees" ON student_fees FOR ALL TO authenticated
  USING (get_user_role() IN ('admin', 'accountant'))
  WITH CHECK (get_user_role() IN ('admin', 'accountant'));

-- Receipt sequences: all read; admin + accountant manage
CREATE POLICY "auth_read_receipt_seq" ON receipt_sequences FOR SELECT TO authenticated USING (true);
CREATE POLICY "admin_accountant_manage_receipt_seq" ON receipt_sequences FOR ALL TO authenticated
  USING (get_user_role() IN ('admin', 'accountant'))
  WITH CHECK (get_user_role() IN ('admin', 'accountant'));

-- Payments: all read; all insert; admin updates/deletes
CREATE POLICY "auth_read_payments" ON payments FOR SELECT TO authenticated USING (true);
CREATE POLICY "auth_insert_payments" ON payments FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "admin_update_payments" ON payments FOR UPDATE TO authenticated
  USING (get_user_role() = 'admin');
CREATE POLICY "admin_delete_payments" ON payments FOR DELETE TO authenticated
  USING (get_user_role() = 'admin');

-- Bank deposits: all read; admin + accountant manage
CREATE POLICY "auth_read_deposits" ON bank_deposits FOR SELECT TO authenticated USING (true);
CREATE POLICY "admin_accountant_manage_deposits" ON bank_deposits FOR ALL TO authenticated
  USING (get_user_role() IN ('admin', 'accountant'))
  WITH CHECK (get_user_role() IN ('admin', 'accountant'));

-- Bridge students: all read; admin + accountant manage
CREATE POLICY "auth_read_bridge_students" ON bridge_students FOR SELECT TO authenticated USING (true);
CREATE POLICY "admin_accountant_manage_bridge_students" ON bridge_students FOR ALL TO authenticated
  USING (get_user_role() IN ('admin', 'accountant'))
  WITH CHECK (get_user_role() IN ('admin', 'accountant'));

-- Bridge payments: all read; all insert
CREATE POLICY "auth_read_bridge_payments" ON bridge_payments FOR SELECT TO authenticated USING (true);
CREATE POLICY "auth_insert_bridge_payments" ON bridge_payments FOR INSERT TO authenticated WITH CHECK (true);

-- Bridge deposits: all read; admin + accountant manage
CREATE POLICY "auth_read_bridge_deposits" ON bridge_deposits FOR SELECT TO authenticated USING (true);
CREATE POLICY "admin_accountant_manage_bridge_deposits" ON bridge_deposits FOR ALL TO authenticated
  USING (get_user_role() IN ('admin', 'accountant'))
  WITH CHECK (get_user_role() IN ('admin', 'accountant'));

-- Profiles: users read their own; admin manages all
CREATE POLICY "users_read_own_profile" ON profiles FOR SELECT TO authenticated
  USING (id = auth.uid() OR get_user_role() = 'admin');
CREATE POLICY "admin_manage_profiles" ON profiles FOR ALL TO authenticated
  USING (get_user_role() = 'admin') WITH CHECK (get_user_role() = 'admin');

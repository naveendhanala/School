-- Immutable audit log: one row per payment edit
CREATE TABLE payment_edits (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  payment_id       UUID NOT NULL REFERENCES payments(id) ON DELETE CASCADE,
  edited_by        UUID NOT NULL REFERENCES auth.users(id),
  edited_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  reason           TEXT NOT NULL,
  old_amount       NUMERIC(10,2),
  new_amount       NUMERIC(10,2),
  old_mode         TEXT,
  new_mode         TEXT,
  old_payment_date DATE,
  new_payment_date DATE,
  old_fee_head     TEXT,
  new_fee_head     TEXT,
  old_reference    TEXT,
  new_reference    TEXT,
  old_remarks      TEXT,
  new_remarks      TEXT
);

ALTER TABLE payment_edits ENABLE ROW LEVEL SECURITY;

CREATE POLICY "admin_read_payment_edits" ON payment_edits
  FOR SELECT TO authenticated USING (get_user_role() = 'admin');

CREATE POLICY "admin_insert_payment_edits" ON payment_edits
  FOR INSERT TO authenticated WITH CHECK (get_user_role() = 'admin');

-- Reset function: wipes all payment/deposit data for a year in one transaction.
-- Uses SECURITY DEFINER so it can delete across tables, but includes an internal
-- role guard so only admins can invoke it.
CREATE OR REPLACE FUNCTION reset_active_year_payments(year_id UUID)
RETURNS void AS $$
BEGIN
  IF get_user_role() != 'admin' THEN
    RAISE EXCEPTION 'Only admins can reset payments';
  END IF;

  -- Main school payments
  DELETE FROM payments
  WHERE enrollment_id IN (
    SELECT id FROM enrollments WHERE academic_year_id = year_id
  );

  -- Main bank deposits
  DELETE FROM bank_deposits WHERE academic_year_id = year_id;

  -- Bridge payments (no CASCADE on bridge_student_id FK — must delete explicitly)
  DELETE FROM bridge_payments
  WHERE bridge_student_id IN (
    SELECT id FROM bridge_students WHERE academic_year_id = year_id
  );

  -- Bridge students
  DELETE FROM bridge_students WHERE academic_year_id = year_id;

  -- Bridge deposits
  DELETE FROM bridge_deposits WHERE academic_year_id = year_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public;

GRANT EXECUTE ON FUNCTION reset_active_year_payments TO authenticated;

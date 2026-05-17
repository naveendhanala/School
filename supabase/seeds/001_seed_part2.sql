-- Enrollments + Hostel Fees
DO $$ DECLARE yr UUID; BEGIN
  SELECT id INTO yr FROM academic_years WHERE label='2025-26';
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE192' AND c.name='LKG' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0002' AND c.name='LKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE179' AND c.name='LKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE202' AND c.name='LKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE220' AND c.name='LKG' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE180' AND c.name='LKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE190' AND c.name='LKG' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE227' AND c.name='LKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE186' AND c.name='LKG' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE198' AND c.name='LKG' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE183' AND c.name='LKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE193' AND c.name='LKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE181' AND c.name='LKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE201' AND c.name='LKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE189' AND c.name='LKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0016' AND c.name='LKG' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE187' AND c.name='LKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE199' AND c.name='LKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE182' AND c.name='LKG' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE221' AND c.name='LKG' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE184' AND c.name='LKG' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE200' AND c.name='LKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE219' AND c.name='LKG' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE191' AND c.name='LKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0025' AND c.name='UKG' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE211' AND c.name='UKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE154' AND c.name='UKG' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE0028' AND c.name='UKG' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE188' AND c.name='UKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE209' AND c.name='UKG' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE195' AND c.name='UKG' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE217' AND c.name='UKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE216' AND c.name='UKG' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE167' AND c.name='UKG' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE168' AND c.name='UKG' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE157' AND c.name='UKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE228' AND c.name='UKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE159' AND c.name='UKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE213' AND c.name='UKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE0040' AND c.name='UKG' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0041' AND c.name='UKG' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE160' AND c.name='UKG' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0043' AND c.name='UKG' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE162' AND c.name='UKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE223' AND c.name='UKG' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0046' AND c.name='UKG' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE196' AND c.name='UKG' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE218' AND c.name='UKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE178' AND c.name='UKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE208' AND c.name='UKG' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE194' AND c.name='UKG' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE225' AND c.name='UKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE222' AND c.name='UKG' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE204' AND c.name='UKG' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE214' AND c.name='UKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE164' AND c.name='UKG' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE206' AND c.name='UKG' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE215' AND c.name='UKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE226' AND c.name='UKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE165' AND c.name='UKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE207' AND c.name='UKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE197' AND c.name='UKG' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE166' AND c.name='UKG' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE169' AND c.name='UKG' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE170' AND c.name='UKG' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE205' AND c.name='UKG' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE229' AND c.name='UKG' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE224' AND c.name='UKG' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0069' AND c.name='UKG' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0070' AND c.name='UKG' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE784' AND c.name='I' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE807' AND c.name='I' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE771' AND c.name='I' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE772' AND c.name='I' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE773' AND c.name='I' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE774' AND c.name='I' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE775' AND c.name='I' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE871' AND c.name='I' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE776' AND c.name='I' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE777' AND c.name='I' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE827' AND c.name='I' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE778' AND c.name='I' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE881' AND c.name='I' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE780' AND c.name='I' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE781' AND c.name='I' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE782' AND c.name='I' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE783' AND c.name='I' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE864' AND c.name='I' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE863' AND c.name='I' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE822' AND c.name='I' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE808' AND c.name='I' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE785' AND c.name='I' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE866' AND c.name='I' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE786' AND c.name='I' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE858' AND c.name='I' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE787' AND c.name='I' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE788' AND c.name='I' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE867' AND c.name='I' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE789' AND c.name='I' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE825' AND c.name='I' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE792' AND c.name='I' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE790' AND c.name='I' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE791' AND c.name='I' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE793' AND c.name='I' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE794' AND c.name='I' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE962' AND c.name='I' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE795' AND c.name='I' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE796' AND c.name='I' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE860' AND c.name='I' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE797' AND c.name='I' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE823' AND c.name='I' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE865' AND c.name='I' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE888' AND c.name='I' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE798' AND c.name='I' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE821' AND c.name='I' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE799' AND c.name='I' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE889' AND c.name='I' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE816' AND c.name='I' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE810' AND c.name='I' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE800' AND c.name='I' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE801' AND c.name='I' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE802' AND c.name='I' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE803' AND c.name='I' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE804' AND c.name='I' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE805' AND c.name='I' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE806' AND c.name='I' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE861' AND c.name='I' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0128' AND c.name='II' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE674' AND c.name='II' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE675' AND c.name='II' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE870' AND c.name='II' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE676' AND c.name='II' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE677' AND c.name='II' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE678' AND c.name='II' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE679' AND c.name='II' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE840' AND c.name='II' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE681' AND c.name='II' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE683' AND c.name='II' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE686' AND c.name='II' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE684' AND c.name='II' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE691' AND c.name='II' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE692' AND c.name='II' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE693' AND c.name='II' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE694' AND c.name='II' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE695' AND c.name='II' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE696' AND c.name='II' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE697' AND c.name='II' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE826' AND c.name='II' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE817' AND c.name='II' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE687' AND c.name='II' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE698' AND c.name='II' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE699' AND c.name='II' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE700' AND c.name='II' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE701' AND c.name='II' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE688' AND c.name='II' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE703' AND c.name='II' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE844' AND c.name='II' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE882' AND c.name='II' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE706' AND c.name='II' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE708' AND c.name='II' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE669' AND c.name='II' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE709' AND c.name='II' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE710' AND c.name='II' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE711' AND c.name='II' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE713' AND c.name='II' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE849' AND c.name='II' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE868' AND c.name='II' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE689' AND c.name='II' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE854' AND c.name='II' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE715' AND c.name='II' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE850' AND c.name='II' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE716' AND c.name='II' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE717' AND c.name='II' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE718' AND c.name='II' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE657' AND c.name='III' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE651' AND c.name='III' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE622' AND c.name='III' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE876' AND c.name='III' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE812' AND c.name='III' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE614' AND c.name='III' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE836' AND c.name='III' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE611' AND c.name='III' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE719' AND c.name='III' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE874' AND c.name='III' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE616' AND c.name='III' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE663' AND c.name='III' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE818' AND c.name='III' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE720' AND c.name='III' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE642' AND c.name='III' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE851' AND c.name='III' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE648' AND c.name='III' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE644' AND c.name='III' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE838' AND c.name='III' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE649' AND c.name='III' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE613' AND c.name='III' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE650' AND c.name='III' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE658' AND c.name='III' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE886' AND c.name='III' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE814' AND c.name='III' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE647' AND c.name='III' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE661' AND c.name='III' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE875' AND c.name='III' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE600' AND c.name='III' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE723' AND c.name='III' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE724' AND c.name='III' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE809' AND c.name='III' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE625' AND c.name='III' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE845' AND c.name='III' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE656' AND c.name='III' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE828' AND c.name='III' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE815' AND c.name='III' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE609' AND c.name='III' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE725' AND c.name='III' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE653' AND c.name='III' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE872' AND c.name='III' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE646' AND c.name='III' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0217' AND c.name='III' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE581' AND c.name='III' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE855' AND c.name='III' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0220' AND c.name='III' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE856' AND c.name='III' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE856' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE728' AND c.name='III' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0223' AND c.name='IV' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE479' AND c.name='IV' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE829' AND c.name='IV' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE829' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE443' AND c.name='IV' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE729' AND c.name='IV' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE523' AND c.name='IV' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE477' AND c.name='IV' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE501' AND c.name='IV' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE453' AND c.name='IV' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE831' AND c.name='IV' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE619' AND c.name='IV' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE457' AND c.name='IV' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE475' AND c.name='IV' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE730' AND c.name='IV' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE588' AND c.name='IV' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE440' AND c.name='IV' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE547' AND c.name='IV' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE474' AND c.name='IV' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE871' AND c.name='IV' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE832' AND c.name='IV' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE832' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE441' AND c.name='IV' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE449' AND c.name='IV' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE824' AND c.name='IV' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE880' AND c.name='IV' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE511' AND c.name='IV' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE852' AND c.name='IV' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE852' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE833' AND c.name='IV' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE731' AND c.name='IV' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE830' AND c.name='IV' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE732' AND c.name='IV' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE504' AND c.name='IV' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE667' AND c.name='IV' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE722' AND c.name='IV' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE481' AND c.name='IV' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE512' AND c.name='IV' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE454' AND c.name='IV' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE499' AND c.name='IV' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE841' AND c.name='IV' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE478' AND c.name='IV' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE884' AND c.name='IV' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE734' AND c.name='IV' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE820' AND c.name='IV' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE480' AND c.name='IV' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE498' AND c.name='IV' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE769' AND c.name='IV' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE859' AND c.name='IV' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE859' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE813' AND c.name='IV' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE813' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE570' AND c.name='IV' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE877' AND c.name='IV' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE877' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE446' AND c.name='IV' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE450' AND c.name='IV' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE497' AND c.name='IV' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE476' AND c.name='IV' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE484' AND c.name='IV' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE846' AND c.name='IV' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE546' AND c.name='IV' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE448' AND c.name='IV' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE482' AND c.name='IV' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE414' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE878' AND c.name='V' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE736' AND c.name='V' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE843' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE843' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE580' AND c.name='V' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE737' AND c.name='V' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE493' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE738' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE738' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE779' AND c.name='V' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE399' AND c.name='V' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE874' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE874' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE549' AND c.name='V' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE752' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE752' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE585' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE585' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE605' AND c.name='V' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE847' AND c.name='V' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE601' AND c.name='V' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE740' AND c.name='V' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE835' AND c.name='V' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE558' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE558' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE819' AND c.name='V' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE887' AND c.name='V' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE373' AND c.name='V' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE384' AND c.name='V' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE837' AND c.name='V' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE848' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE848' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0307' AND c.name='V' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE811' AND c.name='V' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE572' AND c.name='V' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE745' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE745' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE413' AND c.name='V' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE641' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE641' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE741' AND c.name='V' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE742' AND c.name='V' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE377' AND c.name='V' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE744' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE744' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE743' AND c.name='V' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE883' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE883' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE423' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE747' AND c.name='V' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE428' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE568' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE407' AND c.name='V' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE748' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE748' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE496' AND c.name='V' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE589' AND c.name='V' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE419' AND c.name='V' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE633' AND c.name='V' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE834' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE834' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE873' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE873' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE544' AND c.name='V' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE842' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE842' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE590' AND c.name='V' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE879' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE879' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE369' AND c.name='V' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE397' AND c.name='V' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE869' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE869' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE853' AND c.name='V' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE746' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE746' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE751' AND c.name='V' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE753' AND c.name='V' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0342' AND c.name='V' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE754' AND c.name='V' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE494' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE494' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE586' AND c.name='V' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE885' AND c.name='V' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',40000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE885' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE755' AND c.name='V' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE621' AND c.name='V' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE857' AND c.name='V' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE756' AND c.name='V' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE751' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE751' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE569' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE570' AND c.name='VI' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE571' AND c.name='VI' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE638' AND c.name='VI' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE572' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE572' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE688' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE573' AND c.name='VI' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE683' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE682' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE717' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE717' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE636' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE636' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE643' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE643' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE689' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE764' AND c.name='VI' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE640' AND c.name='VI' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE779' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE779' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE574' AND c.name='VI' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE691' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE691' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE641' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE641' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE575' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE576' AND c.name='VI' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE700' AND c.name='VI' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE577' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE684' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE684' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE579' AND c.name='VI' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE580' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE581' AND c.name='VI' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE752' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE752' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE695' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE695' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE582' AND c.name='VI' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE716' AND c.name='VI' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE583' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE583' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE697' AND c.name='VI' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE637' AND c.name='VI' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE584' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE584' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE585' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE585' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE586' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE587' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE707' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE0391' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE0391' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE588' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE588' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE782' AND c.name='VI' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE687' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE687' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE685' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE685' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE755' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE755' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE589' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE590' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE590' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE591' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE591' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE701' AND c.name='VI' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE729' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE729' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE592' AND c.name='VI' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE593' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE733' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE733' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE690' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE690' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE732' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE732' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE595' AND c.name='VI' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE596' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE596' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE594' AND c.name='VI' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE686' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE598' AND c.name='VI' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE599' AND c.name='VI' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE731' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE731' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE696' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE696' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE719' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE719' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE781' AND c.name='VI' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE746' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE746' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE694' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE694' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE693' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE693' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE728' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE728' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE601' AND c.name='VI' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE750' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE750' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE635' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE635' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE602' AND c.name='VI' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE603' AND c.name='VI' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE604' AND c.name='VI' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE605' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE605' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE606' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE606' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE712' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE712' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE710' AND c.name='VI' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE718' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE718' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE727' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE727' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE756' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE756' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE607' AND c.name='VI' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE608' AND c.name='VI' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE740' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE740' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE772' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE772' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE634' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE634' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE709' AND c.name='VI' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE780' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE780' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE609' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE609' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE692' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE692' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE730' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE730' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE610' AND c.name='VI' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE610' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE612' AND c.name='VI' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE600' AND c.name='VI' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE625' AND c.name='VI' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE749' AND c.name='VI' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE471' AND c.name='VII' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE457' AND c.name='VII' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE461' AND c.name='VII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE445' AND c.name='VII' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE686' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE686' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE525' AND c.name='VII' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE515' AND c.name='VII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE735' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE735' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE671' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE671' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE458' AND c.name='VII' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE510' AND c.name='VII' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE446' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE446' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE516' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE630' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE630' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE714' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE714' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE743' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE743' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE631' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE631' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE725' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE725' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE720' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE720' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE452' AND c.name='VII' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE672' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE672' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE678' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE678' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE673' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE673' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE521' AND c.name='VII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE443' AND c.name='VII' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE567' AND c.name='VII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE507' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE507' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE699' AND c.name='VII' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE721' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE721' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE447' AND c.name='VII' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE506' AND c.name='VII' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE676' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE676' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE675' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE675' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE736' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE736' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE629' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE629' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE482' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE482' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE679' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE679' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE715' AND c.name='VII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE748' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE523' AND c.name='VII' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE483' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE483' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE509' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE509' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE780' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE522' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE522' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE441' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE441' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE674' AND c.name='VII' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE677' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE677' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE454' AND c.name='VII' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE448' AND c.name='VII' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE476' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE476' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE450' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE444' AND c.name='VII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE513' AND c.name='VII' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE511' AND c.name='VII' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE505' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE505' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE628' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE628' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE734' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE734' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE632' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE632' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE621' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE621' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE644' AND c.name='VII' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE668' AND c.name='VII' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE520' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE520' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE519' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE519' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE508' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE508' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE681' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE681' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE442' AND c.name='VII' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE438' AND c.name='VII' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE711' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE711' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE526' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE526' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE484' AND c.name='VII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE459' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE459' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE449' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE449' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE680' AND c.name='VII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE680' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE669' AND c.name='VII' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE465' AND c.name='VII' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE462' AND c.name='VII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE451' AND c.name='VII' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE504' AND c.name='VII' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE642' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE642' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE774' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE774' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE662' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE662' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE527' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE527' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE698' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE698' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE753' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE753' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE723' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE723' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE332' AND c.name='VIII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE531' AND c.name='VIII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE327' AND c.name='VIII' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE351' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE753' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE753' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE355' AND c.name='VIII' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE475' AND c.name='VIII' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE350' AND c.name='VIII' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE371' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE371' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE537' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE537' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE342' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE342' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE547' AND c.name='VIII' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE565' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE565' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE760' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE760' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE566' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE566' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE539' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE362' AND c.name='VIII' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0551' AND c.name='VIII' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE536' AND c.name='VIII' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE545' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE545' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE538' AND c.name='VIII' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE358' AND c.name='VIII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE619' AND c.name='VIII' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE416' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE416' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE326' AND c.name='VIII' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE361' AND c.name='VIII' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE364' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE364' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE654' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE654' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE618' AND c.name='VIII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE658' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE658' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE385' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE656' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE656' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE529' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE529' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE543' AND c.name='VIII' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE742' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE742' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE330' AND c.name='VIII' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE372' AND c.name='VIII' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE546' AND c.name='VIII' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE472' AND c.name='VIII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE344' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE761' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE761' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE339' AND c.name='VIII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE569' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE569' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE737' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE737' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE503' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE503' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE346' AND c.name='VIII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE722' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE722' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE738' AND c.name='VIII' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE384' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE633' AND c.name='VIII' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE659' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE659' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE349' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE349' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE540' AND c.name='VIII' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE542' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE532' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE532' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE530' AND c.name='VIII' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE347' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE741' AND c.name='VIII' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE366' AND c.name='VIII' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE660' AND c.name='VIII' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE768' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE329' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE329' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE778' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE778' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE474' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE655' AND c.name='VIII' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE357' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE357' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE663' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE663' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE664' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE664' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE348' AND c.name='VIII' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE657' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE657' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE544' AND c.name='VIII' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE665' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE665' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE533' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE533' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE627' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE627' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE345' AND c.name='VIII' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE473' AND c.name='VIII' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE370' AND c.name='VIII' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE370' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE623' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE623' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE470' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE470' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE613' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE613' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE211' AND c.name='IX' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE776' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE776' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE704' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE704' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE646' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE646' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE773' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE773' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE645' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE645' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE386' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE386' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE666' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE666' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE622' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE622' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE233' AND c.name='IX' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE550' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE550' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE500' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE500' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE554' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE554' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE286' AND c.name='IX' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE667' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE667' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE555' AND c.name='IX' AND rt.name='BUS-E' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE335' AND c.name='IX' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE248' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE248' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE763' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE763' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE652' AND c.name='IX' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE301' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE301' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE739' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE739' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE423' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE423' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE614' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE614' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE456' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE456' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE708' AND c.name='IX' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE216' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE216' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE0641' AND c.name='IX' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE649' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE649' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE434' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE434' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE401' AND c.name='IX' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE325' AND c.name='IX' AND rt.name='BUS-G' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE648' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE648' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE230' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE230' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE315' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE315' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE224' AND c.name='IX' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE213' AND c.name='IX' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE556' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE556' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE406' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE406' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE496' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE496' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE382' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE382' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE568' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE553' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE553' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE653' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE653' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE408' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE408' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE501' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE501' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE239' AND c.name='IX' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE290' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE290' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE498' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE498' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE552' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE552' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE758' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE758' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE615' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE615' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE219' AND c.name='IX' AND rt.name='BUS-C' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE410' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE410' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE765' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE765' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE558' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE558' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE229' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE227' AND c.name='IX' AND rt.name='BUS-D' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE557' AND c.name='IX' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE744' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE744' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE241' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE495' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE495' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE616' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE616' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE252' AND c.name='IX' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE367' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE367' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE0679' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE0679' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE432' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE432' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE724' AND c.name='IX' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE235' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE235' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE713' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE713' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE766' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE766' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE770' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE770' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE639' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE639' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE767' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE767' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE428' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE296' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE296' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE548' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE548' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE499' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE499' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE212' AND c.name='IX' AND rt.name='BUS-A' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE502' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE502' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE647' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE647' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE394' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE394' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE238' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE650' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE650' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE651' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE651' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE756' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE756' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE624' AND c.name='IX' AND rt.name='BUS-B' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE703' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE703' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE757' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE757' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE258' AND c.name='IX' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE243' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE217' AND c.name='IX' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE242' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE242' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,rt.id FROM students s,classes c,transport_routes rt
  WHERE s.adm_no='RSE223' AND c.name='IX' AND rt.name='BUS-F' ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE322' AND c.name='IX' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE322' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE196' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE196' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE184' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE184' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE393' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE393' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE299' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE299' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE559' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE559' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE493' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE493' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE185' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE185' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE375' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE375' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE373' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE373' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE374' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE374' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE487' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE487' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE578' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE578' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE560' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE560' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE430' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE430' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE421' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE421' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE193' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE193' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE620' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE620' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE323' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE323' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE400' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE400' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE186' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE186' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE285' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE285' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE278' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE278' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE268' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE268' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE412' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE412' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE413' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE413' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE561' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE561' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE468' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE468' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE167' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE167' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE494' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE494' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE782' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE782' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE563' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE563' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE388' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE388' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE491' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE491' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE303' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE303' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE392' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE392' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE490' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE490' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE486' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE486' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE270' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE270' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE564' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE564' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE777' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE777' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE280' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE280' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE706' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE706' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE272' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE272' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE176' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE176' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE425' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE425' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE562' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE562' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE198' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE198' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE182' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE182' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE313' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE313' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
  INSERT INTO enrollments(student_id,academic_year_id,class_id,route_id)
  SELECT s.id,yr,c.id,NULL FROM students s,classes c
  WHERE s.adm_no='RSE492' AND c.name='X' ON CONFLICT DO NOTHING;
  INSERT INTO student_fees(enrollment_id,fee_head,amount)
  SELECT e.id,'hostel',45000 FROM enrollments e
  JOIN students st ON st.id=e.student_id
  WHERE st.adm_no='RSE492' AND e.academic_year_id=yr ON CONFLICT DO NOTHING;
END $$;


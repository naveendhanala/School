-- Bridge Course Students, Payments, Deposits
DO $$ DECLARE yr UUID; bs_id UUID; BEGIN
  SELECT id INTO yr FROM academic_years WHERE label='2025-26';
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'1','MADAKA MANOJ KUMAR','NON-IIT','male','9010856417',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'2','EDUBILLI YASHODANJALI','IIT','female','9177723072',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'3','GULLIPALLI BUMITRA','IIT','female','9948070732',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'4','BANDARU LOKESH','IIT','male',NULL,6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'5','TOTTADI AKSHYA','IIT','female',NULL,6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',1000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'6','CHAPPA  JESWANTH','IIT','male',NULL,6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'7','JAMI DEEPIKA','NON-IIT','female','7032150627',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'8','EDUBILLI  NANI','NON-IIT','male',NULL,5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',3000);
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',2000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'9','GOWTHAM SAMBAVARAPU','IIT','male','9505375858',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'10','JAMI VARA PRASAD','NON-IIT','male','9177848801',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'11','LAGUDU TARUN','IIT','male','8499014800',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'12','MIDATHANA SYAM PRASAD','IIT','male','8498930846',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',3000);
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',3000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'13','DURGA SATWIKA','IIT','female','8500336110',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'14','KOTYADA JASWIN SURYA SAI','NON-IIT','male','9494772526',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'15','SUREDDI DINESH','IIT','male','9010770375',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'16','KOMATI THARUN TEJ','NON-IIT','male','8367751916',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'17','VAJJARAPU OMKAR','NON-IIT','male','8465949400',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'18','KADAMATI PRADEEP','NON-IIT','male',NULL,5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'19','CHALAPAREDDI JESWANTH','NON-IIT','male','9010753366',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'20','DANDUPATHI CHANIKYA MOULISWAR','NON-IIT','male','9502927714',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'21','KARRI SANDEEP','NON-IIT','male','8184921698',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'22','SUREDDI MANOJ','IIT','male','7416804875',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'23','GOKADA POORNA PRANEETH','NON-IIT','male','7893869541',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'24','PARRI RAKESH','NON-IIT','male','9553339159',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'25','KASIREDDI DEVI SRI PRASAD','NON-IIT','male','9703885957',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'26','DESILLI SATHVIKA SREE','IIT','female','9989309826',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'27','PARUPALLI DURGA SATYA SAI','NON-IIT','male','9618872471',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'28','NALLABILLI CHANAKYA','NON-IIT','male','6304200579',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'29','KOLLI VIKRANTH','IIT','male','9573707316',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'30','KURMANI HEMA LATHA','NON-IIT','female',NULL,5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',3000);
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',3000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'31','VEMPADAPU SATHVIKA','IIT','female','9866110235',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'32','BARLA JAIDEEP','NON-IIT','male','9010621021',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'33','ANUMALASETTI JITENDRA','NON-IIT','male','9640614254',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'34','SANAPATHI RAMESH','NON-IIT','male','9553994357',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',3000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'35','NAKKA MANOJ','IIT','male','9704514620',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'36','KORADA NIKHIL','IIT','male','9550871440',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'37','JONNAPALLI MAHENDRA NAIDU','NON-IIT','male','9398533913',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'38','SIRIKI NEERAJ','NON-IIT','male','9701976169',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'39','BOTTA THARUN KUMAR','IIT','male','9703713915',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'40','SINGAMPALLI GOWTHAM','IIT','male','8886095883',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'41','ALLU ASHAN','NON-IIT','male','9989158508',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'42','K S M KARTHIKEYA','IIT','male',NULL,6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'43','TOTTADI SHRUTHI HASINI','IIT','female','9392326509',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'44','HARSHITH SIRIKI','IIT','male','8464968895',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'45','BALA BADRA KOMALA KARTHIK KUMAR','NON-IIT','male','8317656716',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'46','CHALUMURI KISHORE','NON-IIT','male','9652253826',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'47','L SHANMUKAH SAI','NON-IIT','male',NULL,5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',3000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'48','J SAINADH SATVIK','IIT','male',NULL,6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'49','SADHANALA BHAVYASRI','IIT','female','7382920990',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'50','KARROTHU VASHIKAR','IIT','male','8919154461',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'51','YELLA PRAVEEN KUMAR','NON-IIT','male','7997817982',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'52','JONNADA HIMA SAGAR','NON-IIT','male','9885244089',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'53','SINAGAM BHARDHAWAJ','NON-IIT','male','9618905372',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'54','VARADI KARTHIK','NON-IIT','male','9542929500',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'55','LAGUDU JASHMITHA','IIT','female',NULL,6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'56','VASANTHALA LAKSHMI NARAYANA','IIT','male','9676249599',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'57','BOTTA PRASANNA','IIT','female',NULL,6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'58','RADHALA MOHITH KUMAR','IIT','male','9989614927',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'59','MAJJI KIRTHANA','IIT','female','9177683407',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',3000);
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',3000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'60','CHALUMURI RAKESH','NON-IIT','male','7093464089',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'61','IJJADA JESWANTH','NON-IIT','male',NULL,5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',4000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'62','IJJADA BHARATH KUMAR','NON-IIT','female',NULL,5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',4000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'63','PENTA RISHI','NON-IIT','male','9885802819',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'64','KINTADA JANARDHANA SAI','NON-IIT','female',NULL,5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'65','BEELA DINESH','NON-IIT','male','8106747868',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'66','JADA KRISHNA VAMSI','IIT','male','8008670084',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'67','RONGALI MAHESH','IIT','male','7013110935',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'68','BOGI DILEEP KUMAR','NON-IIT','male','8522999594',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'69','KORADA RAGHAVA','NON-IIT','male','8106549795',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'70','GADIPALLI DAMARUK NAIDU','NON-IIT','male','7680828381',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'71','VENDRAPU MAHALAXMI','IIT','female','9966512792',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'72','BEELA HARSHA VARDHAN','NON-IIT','male','8125586536',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'73','YENNITI PRADEP KUMAR','IIT','male','7674842834',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'74','S. LAKSHMI PRASANNA','NON-IIT','male','9966803339',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'75','K NAVEEN','NON-IIT','male','7569298867',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'76','BHUMIREDDI JESWANTH','NON-IIT','male','9000713420',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',3000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'77','KOLLA CHARAN MANI KUMAR','NON-IIT','male','6505821141',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'78','ROWTHU KRANTHI CHAITANYA','NON-IIT','male','9346635667',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'79','LOKAVARAPU BHANU PRASAD','NON-IIT','male','8978275421',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'80','KOLLURI CHARAN','IIT','male','9666241720',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'81','JONNADA NITHIN KUMAR','NON-IIT','male','7416206134',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'82','DEEVI BHARADWAJ','IIT','male','9010222719',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'83','RONGALI LIKITH VARDHAN','IIT','male','9493427256',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'84','M HEMA HARSHVARDHINI','NON-IIT','female','9849252275',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'85','B AKSHIYA','NON-IIT','female','9989853406',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'86','ANUMALASETTI REKSHITHA','IIT','female','8142292892',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'87','BORRA VIJAYA GANESH','IIT','male','8374494215',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'89','K Y S GOWRI (DAY SCHOLAR)','IIT','female','8074554370',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',3000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'90','JAMI NEERAJ','IIT','male','9652516748',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'91','K SHYAM CHARAN','NON-IIT','male',NULL,5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'92','N NARENDRA','NON-IIT','male',NULL,5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'93','GINNI NANI','IIT','male','9553883251',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'94','KONDAPU ROHINI','IIT','female','9849536443',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'95','TAMATAPU KARTHIK ROHAN','NON-IIT','male','9948438297',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'96','GOPISETTI VARUN','NON-IIT','male','9866351062',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'97','A SAMEERA','NON-IIT','female','8523824755',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'hdfc',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'98','V TARUN SRI','IIT','female','8096173077',6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'99','K GURUCHARAN','NON-IIT','male','9490303237',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'100','BANDARU JAGADEESH','NON-IIT','male','9052419496',5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'101','K SIRICHNDANA','IIT','female',NULL,6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'102','K JANAKIRAM','NON-IIT','male',NULL,5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'103','N MEGHANA','IIT','female',NULL,6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'104','V DAMODHAR','IIT','male',NULL,6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'cash',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'105','K RAM CHARAN','NON-IIT','male',NULL,5000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',5000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'106','KURAMANI JESHMA','IIT','female',NULL,6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',6000);
  END IF;
  INSERT INTO bridge_students(academic_year_id,voucher_no,name,course,gender,phone,total_fee)
  VALUES(yr,'107','JUTTADA HARIKA','IIT','female',NULL,6000)
  ON CONFLICT DO NOTHING RETURNING id INTO bs_id;
  IF bs_id IS NOT NULL THEN
    INSERT INTO bridge_payments(bridge_student_id,mode,amount) VALUES(bs_id,'phonepe',6000);
  END IF;

  INSERT INTO bridge_deposits(academic_year_id,bank_name,amount,deposit_date,reference)
  VALUES(yr,'Cash/Bank',380000,'2026-05-07','07.05.26');
  INSERT INTO bridge_deposits(academic_year_id,bank_name,amount,deposit_date,reference)
  VALUES(yr,'Cash/Bank',49000,'2026-05-08','08.05.26');
  INSERT INTO bridge_deposits(academic_year_id,bank_name,amount,deposit_date,reference)
  VALUES(yr,'Cash/Bank',60000,'2026-05-08','08.05.26(PHONE PAY SRINU HDFC)');
  INSERT INTO bridge_deposits(academic_year_id,bank_name,amount,deposit_date,reference)
  VALUES(yr,'Cash/Bank',3000,'2026-05-09','09.05.26');
END $$;


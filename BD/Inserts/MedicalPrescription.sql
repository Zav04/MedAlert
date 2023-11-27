INSERT INTO "MedicalPrescription" (id_user, id_dosage,id_medicine,medic_name,emission_date,prescription_status,dt_valid,dt_start,dt_end) 
VALUES(14, 1, 2, 'MEDICO DE TESTE', DATE '2023-10-25', 1, DATE '2023-11-28',DATE '2023-11-28',DATE '2024-11-28');



ALTER TABLE "MedicalPrescription" ADD id_HistoricalMedicalPrespcription BIGINT;
ALTER TABLE "MedicalPrescription" ADD CONSTRAINT "MedicalPrescription" FOREIGN KEY (id_HistoricalMedicalPrespcription) REFERENCES "HistoricMedicalPrescription"(id_historic_medical_prescription);







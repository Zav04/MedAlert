CREATE OR REPLACE FUNCTION get_family_member_medical_history(_family_user_id BIGINT)
RETURNS TABLE(
    patient_user_id BIGINT,
    prescription_id BIGINT,
    historic_date TIMESTAMP,
    prescription_date DATE,
    start_date DATE,
    end_date DATE,
    dosage_time BIGINT,
    dosage_note VARCHAR,
    medicine_name VARCHAR,
    medicine_info VARCHAR,
    medic_name VARCHAR,
    prescription_status BIGINT,
    image_data BYTEA
) AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        p.id_user AS patient_user_id, -- Adicionando o id_user do paciente
        mp.id_medical_prescription,
        hmp.date AS historic_date,
        mp.emission_date AS prescription_date,
        mp.dt_start AS start_date,
        mp.dt_end AS end_date,
        d.dosage_time,
        d.dosage_note,
        m.medicine_name,
        m.medicine_information AS medicine_info,
        mp.medic_name,
        mp.prescription_status,
        hmp.image_data
    FROM "Family" f
    INNER JOIN "Patient" p ON f.id_patient = p.id_patient
    INNER JOIN "MedicalPrescription" mp ON p.id_user = mp.id_user
    INNER JOIN "HistoricMedicalPrescription" hmp ON mp.id_medical_prescription = hmp.id_medical_prescription
    INNER JOIN "Dosage" d ON mp.id_dosage = d.id_dosage
    INNER JOIN "Medicine" m ON mp.id_medicine = m.id_medicine
    WHERE f.id_user = _family_user_id;
END;
$$ LANGUAGE plpgsql;




SELECT get_family_member_medical_history (28)
DROP FUNCTION get_family_member_medical_history(bigint)
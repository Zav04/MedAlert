CREATE OR REPLACE FUNCTION user_medical_prescription(_user_id INT) 
RETURNS TABLE (
    id_medical_prescription BIGINT,
    id_user BIGINT,
    id_dosage BIGINT,
    id_medicine BIGINT,
    medic_name VARCHAR,
    emission_date DATE,
    prescription_status BIGINT,
    dt_valid DATE
) AS $$
BEGIN
    IF _user_id IS NULL THEN
        RAISE EXCEPTION 'Paciente ID está nulo.';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM "MedicalPrescription" WHERE id_user = _user_id) THEN
        RAISE EXCEPTION 'Utilizador não tem Medicação';
    END IF;

    RETURN QUERY (SELECT * FROM "MedicalPrescription" WHERE id_user = _user_id);
END;
$$ LANGUAGE plpgsql;

SELECT(1)

--DROP FUNCTION user_medical_prescription(bigint)
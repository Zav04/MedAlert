CREATE OR REPLACE FUNCTION user_medical_prescription(_user_id INT) 
RETURNS TABLE (
    id_medical_prescription BIGINT,
    full_name VARCHAR,
    dosage_note VARCHAR,
    medicine_name VARCHAR,
    medic_name VARCHAR,
    emission_date DATE,
    prescription_status BIGINT,
    dt_valid DATE,
	dt_start DATE,
	dt_end DATE
) AS $$
BEGIN
    IF _user_id IS NULL THEN
        RAISE EXCEPTION 'Paciente ID está nulo.';
    END IF;

    RETURN QUERY SELECT
        mp.id_medical_prescription,
        CAST((u.first_name || ' ' || u.last_name) AS VARCHAR) AS full_name, -- Cast to VARCHAR
        CAST(d.dosage_note AS VARCHAR) AS dosage_note, -- Cast to VARCHAR if needed
        CAST(m.medicine_name AS VARCHAR) AS medicine_name, -- Cast to VARCHAR if needed
        CAST(mp.medic_name AS VARCHAR) AS medic_name, -- Cast to VARCHAR if needed
        mp.emission_date,
        mp.prescription_status,
        mp.dt_valid,
		mp.dt_start,
		mp.dt_end
    FROM
        "MedicalPrescription" mp
    JOIN "User" u ON mp.id_user = u.id_user
    JOIN "Medicine" m ON mp.id_medicine = m.id_medicine
    JOIN "Dosage" d ON mp.id_dosage = d.id_dosage
    WHERE
        mp.id_user = _user_id;
END;
$$ LANGUAGE plpgsql;


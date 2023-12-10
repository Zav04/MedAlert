CREATE OR REPLACE FUNCTION get_latest_prescription_info(_id_medical_prescription BIGINT)
RETURNS TABLE(dosage_time BIGINT, last_date TIMESTAMP) AS
$$
BEGIN
    RETURN QUERY
    SELECT d.dosage_time, hmp.date
    FROM "MedicalPrescription" mp
    JOIN "Dosage" d ON mp.id_dosage = d.id_dosage
    JOIN "HistoricMedicalPrescription" hmp ON mp.id_medical_prescription = hmp.id_medical_prescription
    WHERE mp.id_medical_prescription = _id_medical_prescription
    ORDER BY hmp.date DESC
    LIMIT 1;
END;
$$
LANGUAGE plpgsql STABLE;


DROP FUNCTION get_latest_prescription_info(bigint)


SELECT get_latest_prescription_info(12)


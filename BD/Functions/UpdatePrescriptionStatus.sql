CREATE OR REPLACE FUNCTION update_prescription_status(_id_medical_prescription BIGINT)
RETURNS VOID AS $$
BEGIN
    -- Verifica o status da prescrição
    IF (SELECT prescription_status FROM "MedicalPrescription" WHERE id_medical_prescription = _id_medical_prescription) = 3 THEN
        -- Atualiza o status para 1 se o status atual for 3
        UPDATE "MedicalPrescription"
        SET prescription_status = 1
        WHERE id_medical_prescription = _id_medical_prescription;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION create_historic_medical_prescription(
    _id_medical_prescription BIGINT,
    _date VARCHAR,
    _validation BOOLEAN,
    _image_data BYTEA)
RETURNS BOOLEAN AS $$
BEGIN
    -- Verificações básicas dos parâmetros
    IF _id_medical_prescription IS NULL THEN
        RAISE EXCEPTION 'ID da prescrição médica é um campo obrigatório.';
    END IF;

    IF _date IS NULL THEN
        RAISE EXCEPTION 'Data é um campo obrigatório.';
    END IF;
	
    IF _image_data IS NULL THEN
        RAISE EXCEPTION 'Imagem é um campo obrigatório.';
    END IF;
    
    -- Insere na tabela HistoricMedicalPrescription
    INSERT INTO "HistoricMedicalPrescription" (
        id_medical_prescription,
        date,
        validation,
        image_data)
    VALUES (
        _id_medical_prescription,
        _date::TIMESTAMP, 
        _validation,
        _image_data);
		
    PERFORM update_prescription_status(_id_medical_prescription);

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

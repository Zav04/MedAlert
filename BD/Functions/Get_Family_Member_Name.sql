CREATE OR REPLACE FUNCTION get_family_member_name(_family_user_id BIGINT)
RETURNS TABLE(
    patient_user_id BIGINT,
    patient_name VARCHAR
) AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        p.id_user AS patient_user_id,
        CAST(u.first_name || ' ' || u.last_name AS VARCHAR) AS patient_name
    FROM "Family" f
    INNER JOIN "Patient" p ON f.id_patient = p.id_patient
    INNER JOIN "User" u ON p.id_user = u.id_user
    WHERE f.id_user = _family_user_id
    GROUP BY p.id_user, u.first_name, u.last_name;
END;
$$ LANGUAGE plpgsql;


SELECT get_family_member_name(28)
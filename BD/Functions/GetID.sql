CREATE OR REPLACE FUNCTION get_id(_email VARCHAR)
RETURNS BIGINT AS $$
DECLARE
    _id BIGINT;
BEGIN
    SELECT id_user INTO _id FROM "User" WHERE email = _email;
    RETURN _id;
END;
$$ LANGUAGE plpgsql;

SELECT get_id('teste1@teste1.com')

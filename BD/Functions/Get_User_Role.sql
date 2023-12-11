CREATE OR REPLACE FUNCTION get_user_role(_id_user BIGINT)
RETURNS role AS $$
DECLARE
    _role role;
BEGIN
    SELECT role INTO _role
    FROM "UserRole"
    WHERE id_user = _id_user;
    
    RETURN _role;
END;
$$ LANGUAGE plpgsql;
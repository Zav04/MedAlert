CREATE OR REPLACE FUNCTION verify_user_credentials(
	email VARCHAR,
	password VARCHAR
)
RETURNS BOOLEAN AS $$
DECLARE
    user_exists BOOLEAN;
BEGIN

	IF email IS NULL OR email = '' THEN
        RAISE EXCEPTION 'Email está vazio.';
    END IF;
	
	IF password IS NULL OR password = '' THEN
        RAISE EXCEPTION 'Password está vazia.';
    END IF;
	
	    -- Verifica se os email é valido
    IF is_email_valid(email) IS False THEN
        RAISE EXCEPTION 'Email não é valido';
    END IF;
	
    -- Verifica se existe um usuário com o email e a senha fornecidos
    SELECT EXISTS (
        SELECT 1 FROM "User" US WHERE US.email = verify_user_credentials.email 
        AND US.password = crypt(verify_user_credentials.password, US.password)
    ) INTO user_exists;

    RETURN user_exists;
END;
$$ LANGUAGE plpgsql;

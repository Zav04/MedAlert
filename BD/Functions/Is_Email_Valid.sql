--Validar se o email é valido para a base de dados
CREATE OR REPLACE FUNCTION is_email_valid(email VARCHAR) 
RETURNS BOOLEAN AS $$
BEGIN
  RETURN email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
END;
$$ LANGUAGE plpgsql;
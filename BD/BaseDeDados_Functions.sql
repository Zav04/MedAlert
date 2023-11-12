--VALIDAR CONNECÇÃO COM A BASE DE DADOS
CREATE OR REPLACE FUNCTION is_connected() RETURNS BOOLEAN AS $$
BEGIN
  RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

--Validar se existe email na base de dados
CREATE OR REPLACE FUNCTION email_exists(input_email VARCHAR)
RETURNS BOOLEAN AS $$
DECLARE
    exists BOOLEAN;
BEGIN
    SELECT EXISTS(SELECT 1 FROM "User" WHERE email = input_email) INTO exists;
    RETURN exists;
END;
$$ LANGUAGE plpgsql;

--Validar se o email é valido para a base de dados
CREATE OR REPLACE FUNCTION is_email_valid(email VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
  RETURN email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
END;
$$ LANGUAGE plpgsql;






INSERT INTO "User" (username, email, password, health_number, status) VALUES
('user1', 'user1@example.com', 'password1', 1234567891, 'Ativo'),
('user2', 'user2@example.com', 'password2', 1234567892, 'Ativo'),
('user3', 'user3@example.com', 'password3', 1234567893, 'Ativo'),
('user4', 'user4@example.com', 'password4', 1234567894, 'Desativo'),
('user5', 'user5@example.com', 'password5', 1234567895, 'Ativo'),
('user6', 'user6@example.com', 'password6', 1234567896, 'Desativo'),
('user7', 'user7@example.com', 'password7', 1234567897, 'Ativo'),
('user8', 'user8@example.com', 'password8', 1234567898, 'Desativo'),
('user9', 'user9@example.com', 'password9', 1234567899, 'Ativo'),
('user10', 'user10@example.com', 'password10', 1234567890, 'Ativo');

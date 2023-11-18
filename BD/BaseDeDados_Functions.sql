--VALIDAR CONNECÇÃO COM A BASE DE DADOS
CREATE OR REPLACE FUNCTION is_connected() 
RETURNS BOOLEAN AS $$
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
CREATE OR REPLACE FUNCTION is_email_valid(email VARCHAR) 
RETURNS BOOLEAN AS $$
BEGIN
  RETURN email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION create_user(
	_email VARCHAR,
      _password VARCHAR,
      _health_number BIGINT,
      _first_name VARCHAR,
      _last_name VARCHAR,
      _birth_date VARCHAR,
      _gender gender_type,
      _phone_number VARCHAR,
      _address VARCHAR,
      _door_number BIGINT,
      _floor_number BIGINT,
      _zip_code VARCHAR)
RETURNS VOID AS $$
DECLARE
    _id_user BIGINT;
BEGIN


	IF _first_name IS NULL OR _first_name = '' THEN
        RAISE EXCEPTION 'Primeiro Nome é um campo obrigatorio.';
    END IF;
	
	IF _last_name IS NULL OR _last_name = '' THEN
        RAISE EXCEPTION 'Ultimo Nome é um campo obrigatorio.';
    END IF;
	
	IF _health_number IS NULL OR _last_name = '' THEN
        RAISE EXCEPTION 'O Número de Saúde é um campo obrigatorio.';
    END IF;

	IF LENGTH(_health_number::text) <> 9 THEN
    RAISE EXCEPTION 'O Número de Saúde deve conter exatamente 9 dígitos.';
	END IF;


	IF EXISTS (SELECT * FROM "User" U WHERE U.health_number = create_user._health_number) THEN
        RAISE EXCEPTION 'O Número de Saúde já foi resgistado anteriormente';
    END IF;

	IF _birth_date IS NULL or _birth_date='' THEN
        RAISE EXCEPTION 'Data de Nascimento é um campo obrigatorio.';
	ELSE 
		_birth_date:=TO_DATE(_birth_date, 'YYYY-MM-DD');
    END IF;
	
	-- Verifica se os campos que não podem ser nulos estão preenchidos
    IF _email IS NULL OR _email = '' THEN
        RAISE EXCEPTION 'Email é um campo obrigatorio.';
    END IF;
	
    -- Verifica se os email é valido
    IF is_email_valid(_email) IS False THEN
        RAISE EXCEPTION 'Email não é valido';
    END IF;
	
	    -- Verifica se os email é valido
    IF email_exists(_email) IS True THEN
        RAISE EXCEPTION 'Email já está registado';
    END IF;
    
    IF _password IS NULL OR _password = '' THEN
        RAISE EXCEPTION 'Password é um campo obrigatorio.';
    END IF;
	
	IF _gender IS NULL THEN
        RAISE EXCEPTION 'Genero é um campo obrigatorio.';
    END IF;
	
	IF _phone_number IS NULL or _phone_number='' THEN
        RAISE EXCEPTION 'Número de telemovel é um campo obrigatorio.';
    END IF;
	
	IF LENGTH(_phone_number::text) <> 9 THEN
    RAISE EXCEPTION 'O Número de Telemovel deve conter exatamente 9 dígitos.';
	END IF;
	
	IF _address IS NULL or _address='' THEN
        RAISE EXCEPTION 'Morada é um campo obrigatorio.';
    END IF;
	
	IF _door_number IS NULL THEN
        RAISE EXCEPTION 'Número da porta é um campo obrigatorio.';
    END IF;
	
	IF _door_number=0 THEN
        RAISE EXCEPTION 'Número da porta incorreto.';
    END IF;
	
	IF _floor_number IS NULL THEN
        _floor_number=NULL;
    END IF;
	
	IF _floor_number <> NULL AND _floor_number=0 THEN
        RAISE EXCEPTION 'Número da piso invalido.';
    END IF;
	
	IF _zip_code IS NULL or _zip_code='-' THEN
        RAISE EXCEPTION 'Codigo de Postal é um campo obrigatorio.';
    END IF;
	
	IF _zip_code='0000-000' or _zip_code NOT SIMILAR TO '[0-9]{4}-[0-9]{3}' THEN
        RAISE EXCEPTION 'Codigo de Postal Invalido.';
    END IF;
   
-- Insere na tabela User
INSERT INTO "User" (email, password, health_number, 
					first_name, last_name, birth_date, 
					gender, phone_number, address, door_number, 
					floor_number, zip_code, status) 
VALUES (_email,_password,_health_number,
		_first_name,_last_name,_birth_date,
		_gender,_phone_number,_address,
		_door_number,_floor_number,_zip_code,'Ativo')
RETURNING id_user INTO _id_user;

END;
$$ LANGUAGE plpgsql;

SELECT create_user('teste@example.com', 'password13', 123456789, 'Teste', 'Teste', '2001-11-10', 'Masculino', '915226207', 'Rua', Null, Null, Null);




INSERT INTO "User" (email, password, health_number, first_name, last_name, birth_date, gender, phone_number, address, door_number, floor_number, zip_code, status) VALUES
('email1@example.com', 'password1', 100000001, 'Nome1', 'Sobrenome1', '2000-01-01', 'Masculino', 900000001, 'Endereço 1', 101, 1, '1234-567', 'Ativo'),
('email2@example.com', 'password2', 100000002, 'Nome2', 'Sobrenome2', '2000-01-02', 'Feminimo', 900000002, 'Endereço 2', 102, 2, '2345-678', 'Ativo'),
('email3@example.com', 'password3', 100000003, 'Nome3', 'Sobrenome3', '2000-01-03', 'Masculino', 900000003, 'Endereço 3', 103, 3, '3456-789', 'Ativo'),
('email4@example.com', 'password4', 100000004, 'Nome4', 'Sobrenome4', '2001-02-01', 'Masculino', 900000004, 'Endereço 4', 104, 4, '4567-890', 'Ativo'),
('email5@example.com', 'password5', 100000005, 'Nome5', 'Sobrenome5', '2001-03-02', 'Feminimo', 900000005, 'Endereço 5', 105, 5, '5678-901', 'Ativo'),
('email6@example.com', 'password6', 100000006, 'Nome6', 'Sobrenome6', '2001-04-03', 'Outro', 900000006, 'Endereço 6', 106, 6, '6789-012', 'Ativo'),
('email7@example.com', 'password7', 100000007, 'Nome7', 'Sobrenome7', '2001-05-04', 'Masculino', 900000007, 'Endereço 7', 107, 7, '7890-123', 'Ativo'),
('email8@example.com', 'password8', 100000008, 'Nome8', 'Sobrenome8', '2001-06-05', 'Feminimo', 900000008, 'Endereço 8', 108, 8, '8901-234', 'Ativo'),
('email9@example.com', 'password9', 100000009, 'Nome9', 'Sobrenome9', '2001-07-06', 'Outro', 900000009, 'Endereço 9', 109, 9, '9012-345', 'Ativo'),
('email10@example.com', 'password10', 100000010, 'Nome10', 'Sobrenome10', '2001-08-07', 'Masculino', 900000010, 'Endereço 10', 110, 10, '0123-456', 'Ativo'),
('email11@example.com', 'password11', 100000011, 'Nome11', 'Sobrenome11', '2001-09-08', 'Feminimo', 900000011, 'Endereço 11', 111, 11, '1234-567', 'Ativo'),
('email12@example.com', 'password12', 100000012, 'Nome12', 'Sobrenome12', '2001-10-09', 'Outro', 900000012, 'Endereço 12', 112, 12, '2345-678', 'Ativo'),
('email13@example.com', 'password13', 100000013, 'Nome13', 'Sobrenome13', '2001-11-10', 'Masculino', 900000013, 'Endereço 13', 113, 13, '3456-789', 'Ativo');


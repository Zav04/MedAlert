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
      _zip_code VARCHAR,
	  _role role)
RETURNS BOOLEAN AS $$
DECLARE
    _id_user BIGINT;
	_status VARCHAR;
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
	
	 _password:=crypt(create_user._password, gen_salt('bf', 10));
	
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
	
	IF _role IS NULL or _zip_code='-' THEN
        RAISE EXCEPTION 'Codigo de Postal é um campo obrigatorio.';
    END IF;
	

IF(_role='NotAplied') THEN
_status='Desativo';
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

INSERT INTO "UserRole" (role,id_user) VALUES(_role,_id_user);

IF(_role='Admin') THEN
INSERT INTO "Admin" (id_user) 
VALUES (_id_user);
END IF;

IF(_role='Doctor') THEN
INSERT INTO "Medic" (id_user) 
VALUES (_id_user);
END IF;

IF(_role='HealthCare') THEN
INSERT INTO "HealthCare" (id_user) 
VALUES (_id_user);
END IF;

IF(_role='Pacient') THEN
INSERT INTO "Patient" (id_user) 
VALUES (_id_user);
END IF;

IF(_role='Family') THEN
INSERT INTO "Family" (id_user) 
VALUES (_id_user);
END IF;

RETURN TRUE;

END;
$$ LANGUAGE plpgsql;



--SELECT create_user('bruno.bx04@gmail.com', 'admin', 123456789, 'Bruno', 'Oliveira', '2001-11-10', 'Masculino', '915226207', 'Rua', 537, Null, '4085-631','Admin');


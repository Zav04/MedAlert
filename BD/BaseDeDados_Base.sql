-- =======================
-- START: USERS
-- =======================
-- Sequence
CREATE SEQUENCE IF NOT EXISTS user_sequence
INCREMENT 1
START 1;

-- Status
-- 1:Ativo
-- 2:Desativo

CREATE TYPE status_type AS ENUM (
   'Ativo', 'Desativo');
   
-- Gender
-- 1:Masculino
-- 2:Feminimo
-- 3:Outro

CREATE TYPE gender_type AS ENUM (
   'Masculino', 'Feminimo', 'Outro'
);


-- Tabela User
CREATE TABLE IF NOT EXISTS "User" (
	id_user BIGINT PRIMARY KEY NOT NULL DEFAULT NEXTVAL('user_sequence'::regclass),
    email VARCHAR UNIQUE NOT NULL,
    password VARCHAR NOT NULL,
    health_number BIGINT UNIQUE NOT NULL,
	first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    birth_date VARCHAR NOT NULL,
    gender gender_type NOT NULL,
    phone_number VARCHAR NOT NULL,
	address VARCHAR NOT NULL,
    door_number BIGINT NOT NULL,
    floor_number BIGINT,
    zip_code VARCHAR NOT NULL,
    status status_type NOT NULL
);

-- =======================
-- END: USERS
-- =======================


-- =======================
-- START: USERS_Role
-- =======================

-- ROLES
-- 1:Admin
-- 2:Doctor
-- 3:HealthCare
-- 4:Pacient
-- 5:Family
-- 6:NotAplied

CREATE TYPE role AS ENUM ('Admin', 'Doctor', 'HealthCare', 'Pacient', 'Family', 'NotAplied');

-- Tabela UserRole
CREATE TABLE IF NOT EXISTS "UserRole" (
    role role NOT NULL,
    id_user BIGINT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE
);

-- =======================
-- END: USERS_Role
-- =======================


-- =======================
-- START: ADMIN
-- =======================

CREATE SEQUENCE IF NOT EXISTS admin_sequence
INCREMENT 1
START 1;

-- Tabela Admin
CREATE TABLE IF NOT EXISTS "Admin" (
    id_admin BIGINT PRIMARY KEY NOT NULL DEFAULT NEXTVAL('admin_sequence'::regclass),
    id_user BIGINT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE
);

-- =======================
-- END: ADMIN
-- =======================



-- =======================
-- START: PATIENT
-- =======================

CREATE SEQUENCE IF NOT EXISTS patient_sequence
INCREMENT 1
START 1;

-- Tabela Patient
CREATE TABLE IF NOT EXISTS "Patient" (
    id_patient BIGINT PRIMARY KEY NOT NULL DEFAULT NEXTVAL('patient_sequence'::regclass),
    id_user BIGINT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE
);

-- =======================
-- END: PATIENT
-- =======================


-- =======================
-- START: MEDIC
-- =======================

CREATE SEQUENCE IF NOT EXISTS medic_sequence
INCREMENT 1
START 1;

-- Tabela Medic
CREATE TABLE IF NOT EXISTS "Medic" (
    id_medic BIGINT PRIMARY KEY NOT NULL DEFAULT NEXTVAL('medic_sequence'::regclass),
    id_user BIGINT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE
);

-- =======================
-- END: MEDIC
-- =======================

-- =======================
-- START: HEALTHCARE
-- =======================

CREATE SEQUENCE IF NOT EXISTS healthcare_sequence
INCREMENT 1
START 1;

-- Tabela HealthCare
CREATE TABLE IF NOT EXISTS "HealthCare" (
    id_healthcare BIGINT PRIMARY KEY NOT NULL DEFAULT NEXTVAL('healthcare_sequence'::regclass),
    id_user BIGINT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE
);


-- =======================
-- END: HEALTHCARE
-- =======================

-- =======================
-- START: FAMILY
-- =======================

CREATE SEQUENCE IF NOT EXISTS family_sequence
INCREMENT 1
START 1;

-- Tabela Family
CREATE TABLE IF NOT EXISTS "Family" (
    id_family BIGINT PRIMARY KEY NOT NULL DEFAULT NEXTVAL('family_sequence'::regclass),
    id_user BIGINT NOT NULL,
    id_patient BIGINT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE,
    FOREIGN KEY (id_patient) REFERENCES "Patient" (id_patient) ON DELETE CASCADE
);


-- =======================
-- END: FAMILY
-- =======================


-- =======================
-- START: DOSAGE
-- =======================

CREATE SEQUENCE IF NOT EXISTS dosage_sequence
INCREMENT 1
START 1;

-- Tabela Dosage
CREATE TABLE IF NOT EXISTS "Dosage" (
    id_dosage BIGINT PRIMARY KEY NOT NULL DEFAULT NEXTVAL('dosage_sequence'::regclass),
    dosage_time BIGINT NOT NULL,
    dosage_amount BIGINT NOT NULL,
	dosage_note VARCHAR NOT NULL
);


-- =======================
-- END: DOSAGE
-- =======================

-- =======================
-- START: MEDICINE
-- =======================

CREATE SEQUENCE IF NOT EXISTS medicine_sequence
INCREMENT 1
START 1;

-- Tabela Medicine
CREATE TABLE IF NOT EXISTS "Medicine" (
    id_medicine BIGINT PRIMARY KEY NOT NULL DEFAULT NEXTVAL('medicine_sequence'::regclass),
    medicine_name VARCHAR NOT NULL,
    medicine_information VARCHAR NOT NULL
);

-- =======================
-- END: MEDICINE
-- =======================


-- =======================
-- START: MEDICAL PRESCRIPTION
-- =======================

CREATE SEQUENCE IF NOT EXISTS medicalprescription_sequence
INCREMENT 1
START 1;


-- prescription_status
-- 0:Concluído
-- 1:Em andamento
-- 2:Cancelado
-- 3:Iniciar


-- Tabela Medical Prescription
CREATE TABLE IF NOT EXISTS "MedicalPrescription" (
    id_medical_prescription BIGINT PRIMARY KEY NOT NULL DEFAULT NEXTVAL('medicalprescription_sequence'::regclass),
    id_user BIGINT NOT NULL,
    id_dosage BIGINT NOT NULL,
    id_medicine BIGINT NOT NULL,
    medic_name VARCHAR NOT NULL,
    emission_date DATE NOT NULL,
    prescription_status BIGINT NOT NULL,
    dt_valid DATE NOT NULL,
	dt_start DATE NOT NULL,
	dt_end DATE NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE,
    FOREIGN KEY (id_dosage) REFERENCES "Dosage" (id_dosage) ON DELETE CASCADE,
    FOREIGN KEY (id_medicine) REFERENCES "Medicine" (id_medicine) ON DELETE CASCADE
);



-- =======================
-- END: MEDICAL PRESCRIPTION
-- =======================

-- =======================
-- START: HISTORIC MEDICAL PRESCRIPTION
-- =======================

CREATE SEQUENCE IF NOT EXISTS historicmedicalprescription_sequence
INCREMENT 1
START 1;

-- Tabela Historic Medical Prescription
CREATE TABLE IF NOT EXISTS "HistoricMedicalPrescription" (
    id_historic_medical_prescription BIGINT PRIMARY KEY NOT NULL DEFAULT NEXTVAL('historicmedicalprescription_sequence'::regclass),
    id_medical_prescription BIGINT NOT NULL,
    date TIMESTAMP NOT NULL,
    validation BOOLEAN DEFAULT NULL,
    image_data BYTEA,
    FOREIGN KEY (id_medical_prescription) REFERENCES "MedicalPrescription" (id_medical_prescription) ON DELETE CASCADE
);


-- =======================
-- END: HISTORIC MEDICAL PRESCRIPTION
-- =======================


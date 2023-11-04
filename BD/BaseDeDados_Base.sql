-- Tabela User
CREATE TABLE IF NOT EXISTS "User" (
    id_user BIGINT PRIMARY KEY NOT NULL,
    username VARCHAR UNIQUE NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    password VARCHAR NOT NULL,
    health_number BIGINT UNIQUE NOT NULL,
    status VARCHAR NOT NULL
);

-- Tabela UserInfos
CREATE TABLE IF NOT EXISTS "UserInfos" (
    id_user BIGINT PRIMARY KEY NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    birth_date DATE NOT NULL,
    gender VARCHAR NOT NULL,
    health_number BIGINT UNIQUE NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    phone_number BIGINT UNIQUE NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE
);

-- Tabela UserRole
CREATE TABLE IF NOT EXISTS "UserRole" (
    role BIGINT NOT NULL,
    id_user BIGINT PRIMARY KEY NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE
);

-- Tabela Address
CREATE TABLE IF NOT EXISTS "Address" (
    id_address BIGINT PRIMARY KEY NOT NULL,
    id_user BIGINT NOT NULL,
    address VARCHAR NOT NULL,
    door_number BIGINT NOT NULL,
    floor VARCHAR,
    zip_code VARCHAR NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE
);

-- Tabela Admin
CREATE TABLE IF NOT EXISTS "Admin" (
    id_admin BIGINT PRIMARY KEY NOT NULL,
    id_user BIGINT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE
);

-- Tabela Patient
CREATE TABLE IF NOT EXISTS "Patient" (
    id_patient BIGINT PRIMARY KEY NOT NULL,
    id_user BIGINT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE
);

-- Tabela Medic
CREATE TABLE IF NOT EXISTS "Medic" (
    id_medic BIGINT PRIMARY KEY NOT NULL,
    id_user BIGINT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE
);

-- Tabela HealthCare
CREATE TABLE IF NOT EXISTS "HealthCare" (
    id_healthcare BIGINT PRIMARY KEY NOT NULL,
    id_user BIGINT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE
);

-- Tabela Family
CREATE TABLE IF NOT EXISTS "Family" (
    id_family BIGINT PRIMARY KEY NOT NULL,
    id_user BIGINT NOT NULL,
    id_patient BIGINT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE,
    FOREIGN KEY (id_patient) REFERENCES "Patient" (id_patient) ON DELETE CASCADE
);

-- Tabela Dosage
CREATE TABLE IF NOT EXISTS "Dosage" (
    id_dosage BIGINT PRIMARY KEY NOT NULL,
    dosage_time BIGINT NOT NULL,
    dosage_amount BIGINT NOT NULL
);

-- Tabela Medicine
CREATE TABLE IF NOT EXISTS "Medicine" (
    id_medicine BIGINT PRIMARY KEY NOT NULL,
    medicine_name VARCHAR NOT NULL,
    medicine_information VARCHAR NOT NULL
);


-- Tabela Medical Prescription
CREATE TABLE IF NOT EXISTS "MedicalPrescription" (
    id_medical_prescription BIGINT PRIMARY KEY NOT NULL,
    id_user BIGINT NOT NULL,
    id_dosage BIGINT NOT NULL,
    id_medicine BIGINT NOT NULL,
    medic_name VARCHAR NOT NULL,
    emission_date DATE NOT NULL,
    prescription_status BIGINT NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (id_user) REFERENCES "User" (id_user) ON DELETE CASCADE,
    FOREIGN KEY (id_dosage) REFERENCES "Dosage" (id_dosage) ON DELETE CASCADE,
    FOREIGN KEY (id_medicine) REFERENCES "Medicine" (id_medicine) ON DELETE CASCADE
);

-- Tabela Historic Medical Prescription
CREATE TABLE IF NOT EXISTS "HistoricMedicalPrescription" (
    id_historic_medical_prescription BIGINT PRIMARY KEY NOT NULL,
    id_medical_prescription BIGINT NOT NULL,
    date DATE NOT NULL,
    validation BOOLEAN NOT NULL,
    image_validation VARCHAR,
    FOREIGN KEY (id_medical_prescription) REFERENCES "MedicalPrescription" (id_medical_prescription) ON DELETE CASCADE
);



--DROP FUNCTION
DROP FUNCTION "create_user";
DROP FUNCTION "email_exists";
DROP FUNCTION "is_connected";
DROP FUNCTION "is_email_valid";

-- DROP TABLE
DROP TABLE "HistoricMedicalPrescription";
DROP TABLE "MedicalPrescription";
DROP TABLE "Dosage";
DROP TABLE "Medicine";
DROP TABLE "UserRole";
DROP TABLE "Admin";
DROP TABLE "Family";
DROP TABLE "Patient";
DROP TABLE "Medic";
DROP TABLE "HealthCare";
DROP TABLE "User";

-- DROP SEQUENCES
DROP SEQUENCE "user_sequence";
DROP SEQUENCE "admin_sequence";
DROP SEQUENCE "patient_sequence";
DROP SEQUENCE "medic_sequence";
DROP SEQUENCE "healthcare_sequence";
DROP SEQUENCE "family_sequence";
DROP SEQUENCE "dosage_sequence";
DROP SEQUENCE "medicine_sequence";
DROP SEQUENCE "medicalprescription_sequence";
DROP SEQUENCE "historicmedicalprescription_sequence";

--DROP ENUM
DROP TYPE IF EXISTS status_type;
DROP TYPE IF EXISTS gender_type;
DROP TYPE IF EXISTS role;




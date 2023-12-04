import 'package:supabase_flutter/supabase_flutter.dart';
import '../Class/ClassBDResponse.dart';
import 'dart:typed_data';

const String supabaseUrl = 'https://exaeozpjrqqzfrztgulf.supabase.co';
const String supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV4YWVvenBqcnFxemZyenRndWxmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5ODc2NDcwNCwiZXhwIjoyMDE0MzQwNzA0fQ.dTFuOFu1IXdZ2DvafCpjW-hbGYKaLw-aZl9qk4O-m5A'; // Use sua chave de serviço real aqui.

final SupabaseClient supabase = SupabaseClient(supabaseUrl, supabaseKey);

Future<bool> checkSupabaseConnection() async {
  try {
    // Tente fazer uma operação autenticada. Você pode substituir isso por qualquer operação válida.
    final response = await supabase.rpc('is_connected').execute();

    if (response.data == true && response.status == 200) {
      return true;
    }
    return false;
    // Verifique se a resposta é bem-sucedida.
  } catch (e) {
    // Em caso de exceção, assuma que não há conexão.
    return false;
  }
}

Future<bool> dbCheckEmailExists(String email) async {
  try {
    final response = await supabase
        .rpc('email_exists', params: {'input_email': email}).execute();

    if (response.data == true && response.status == 200) {
      return true; // O e-mail existe
    } else {
      return false; // O e-mail não existe ou houve um erro
    }
  } catch (e) {
    return false;
  }
}

Future<bool> dbCheckEmailValid(String email) async {
  try {
    final response = await supabase
        .rpc('is_email_valid', params: {'email': email}).execute();

    if (response.data == true && response.status == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<int> getId(String email) async {
  try {
    final response =
        await supabase.rpc('get_id', params: {'_email': email}).execute();

    if (response.status == 200 && response.data != null) {
      return response.data;
    } else {
      return -1;
    }
  } catch (e) {
    return -1;
  }
}

Future<CreateDBResponse> getMedication(int id) async {
  try {
    final response = await supabase
        .rpc('user_medical_prescription', params: {'_user_id': id}).execute();

    //Sucesso
    if (response.error == null && response.data != null) {
      return CreateDBResponse(
        success: true,
        data: response.data,
      );
    } else {
      // Falha, com mensagem de erro
      return CreateDBResponse(
        success: false,
        errorMessage: response.error?.message,
      );
    }
  } catch (e) {
    // Falha, com exceção capturada
    return CreateDBResponse(
      success: false,
      errorMessage: e.toString(),
    );
  }
}

Future<CreateDBResponse> createUser({
  required String? email,
  required String? password,
  required int? healthNumber,
  required String? firstName,
  required String? lastName,
  required String? birthDate,
  required String? gender,
  required String? phoneNumber,
  required String? address,
  required int? doorNumber,
  int? floorNumber, // Opcional, já que pode ser nulo
  required String? zipCode,
  required String? role,
}) async {
  if (role != null) {
    switch (role) {
      case "Médico":
        role = "Doctor";
        break;
      case "Paciente":
        role = "Pacient";
        break;
      case "Profissional de Saúde":
        role = "HealthCare";
        break;
      case "Familiar":
        role = "Family";
        break;
      case "Administrador":
        role = "Admin";
        break;
      default:
    }
  }
  try {
    final response = await supabase.rpc('create_user', params: {
      '_email': email,
      '_password': password,
      '_health_number': healthNumber,
      '_first_name': firstName,
      '_last_name': lastName,
      '_birth_date': birthDate,
      '_gender': gender,
      '_phone_number': phoneNumber,
      '_address': address,
      '_door_number': doorNumber,
      '_floor_number': floorNumber,
      '_zip_code': zipCode,
      '_role': role,
    }).execute();

    //Sucesso
    if (response.error == null) {
      return CreateDBResponse(
        success: true,
        data: response.data,
      );
    } else {
      // Falha, com mensagem de erro
      return CreateDBResponse(
        success: false,
        errorMessage: response.error?.message,
      );
    }
  } catch (e) {
    // Falha, com exceção capturada
    return CreateDBResponse(
      success: false,
      errorMessage: e.toString(),
    );
  }
}

Future<CreateDBResponse> login({
  required String? email,
  required String? password,
}) async {
  try {
    final response = await supabase.rpc('verify_user_credentials',
        params: {'email': email, 'password': password}).execute();

    //Sucesso
    if (response.error == null && response.data == true) {
      return CreateDBResponse(
        success: true,
        data: response.data,
      );
    } else {
      // Falha, com mensagem de erro
      return CreateDBResponse(
        success: false,
        errorMessage: response.error?.message,
      );
    }
  } catch (e) {
    // Falha, com exceção capturada
    return CreateDBResponse(
      success: false,
      errorMessage: e.toString(),
    );
  }
}

Future<CreateDBResponse> createHistoricMedicalPrescription({
  required int? idMedicalPrescription,
  required String? date,
  required bool? validation,
  required Uint8List? imageValidation,
}) async {
  try {
    final response =
        await supabase.rpc('create_historic_medical_prescription', params: {
      '_id_medical_prescription': idMedicalPrescription,
      '_date': date,
      '_validation': validation,
      '_image_data': imageValidation
    }).execute();

    //Sucesso
    if (response.error == null && response.data == true) {
      return CreateDBResponse(
        success: true,
        data: response.data,
      );
    } else {
      // Falha, com mensagem de erro
      return CreateDBResponse(
        success: false,
        errorMessage: response.error?.message,
      );
    }
  } catch (e) {
    // Falha, com exceção capturada
    return CreateDBResponse(
      success: false,
      errorMessage: e.toString(),
    );
  }
}

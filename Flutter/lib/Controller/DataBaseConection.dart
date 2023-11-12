//Necessario importar o seguinte comando flutter pub add supabase_flutter para ter a api do supabase
import 'package:supabase_flutter/supabase_flutter.dart';

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

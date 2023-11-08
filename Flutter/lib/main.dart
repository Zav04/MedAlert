import 'package:flutter/material.dart';
import './Menus/SplashScreen.dart';
import 'DataBaseConection.dart';
import './Warnings/NoDataBaseConnection.dart';

// Importe o pacote de conectividade ou o pacote da sua base de dados

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Verificar conexão com a base de dados antes de iniciar o aplicativo
  bool dbConnected = await checkSupabaseConnection();

  runApp(MedAlert(dbConnected: dbConnected));
}

class MedAlert extends StatelessWidget {
  final bool dbConnected;

  const MedAlert({Key? key, required this.dbConnected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: dbConnected ? SplashScreen() : NoConnectionScreen(),
    );
  }
}

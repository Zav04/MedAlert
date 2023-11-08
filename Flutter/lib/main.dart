import 'package:flutter/material.dart';
import './Menus/SplashScreen.dart';
import 'DataBaseConection.dart';
import 'Warnings/NoDataBaseConnection.dart';
import 'package:flutter/services.dart';

// Importe o pacote de conectividade ou o pacote da sua base de dados

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MedAlert());
}

class MedAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<bool>(
          // Substitua isso pela sua lógica de verificação de conexão
          future: checkSupabaseConnection(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            } else if (snapshot.hasData && snapshot.data!) {
              return SplashScreen(); // Substitua isso pela tela principal do seu aplicativo
            } else {
              // Mostra o widget de sem conexão
              return NoConnectionWidget(
                tryAgainAction: () {
                  checkSupabaseConnection();
                },
                exitAction: () {
                  SystemNavigator.pop();
                },
              );
            }
          },
        ),
      ),
    );
  }
}

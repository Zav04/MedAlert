import 'package:flutter/material.dart';
import 'Widgets/SplashScreen.dart';
import 'Controller/DataBaseConection.dart';
import 'Warnings/NoDataBaseConnection.dart';
import 'Menus/LoginPage.dart';
import 'package:intl/date_symbol_data_local.dart';

// Importe o pacote de conectividade ou o pacote da sua base de dados

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('pt_PT', null).then((_) => runApp(const MedAlert()));
}

class MedAlert extends StatelessWidget {
  const MedAlert({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<bool>(
          future: checkSupabaseConnection(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            } else if (snapshot.hasData && snapshot.data!) {
              return const LoginPage();
            } else {
              return NoConnectionWidget(
                tryAgainAction: () => tryAgain(context),
              );
            }
          },
        ),
      ),
    );
  }

  // Função assíncrona separada para tentar novamente
  void tryAgain(BuildContext context) async {
    bool tryagain = await checkSupabaseConnection();
    if (tryagain) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MedAlert()));
    }
  }
}

import 'package:flutter/material.dart';
//import 'dart:io' show Platform;
import 'dart:io';

import './Menus/SplashScreen.dart';
import 'Controller/DataBaseConection.dart';
import 'Warnings/NoDataBaseConnection.dart';
import 'Menus/LoginPage.dart';

// Importe o pacote de conectividade ou o pacote da sua base de dados

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MedAlert());
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
              return SplashScreen();
            } else if (snapshot.hasData && snapshot.data!) {
              //TODO CHANGE TO MATERIAL  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()),);
              return const LoginPage();
            } else {
              return NoConnectionWidget(
                tryAgainAction: () {
                  checkSupabaseConnection();
                },
              );
            }
          },
        ),
      ),
    );
  }

//isto para a main thread tem de ser async, senão for para a main thread
  void synchronousSleep(int timetoDelay) {
    sleep(Duration(seconds: timetoDelay));
  }
}

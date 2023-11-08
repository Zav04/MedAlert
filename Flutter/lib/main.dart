import 'package:flutter/material.dart';

import './Menus/SplashScreen.dart';

void main() {
  runApp(const MedAlert());
}

class MedAlert extends StatelessWidget {
  const MedAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          SplashScreen(),
        ]),
      ),
    );
  }
}

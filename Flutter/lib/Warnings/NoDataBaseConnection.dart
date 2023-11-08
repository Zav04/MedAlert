import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Defina um widget para exibir quando não há conexão
class NoConnectionScreen extends StatelessWidget {
  String noConn = 'Não existe ligação à internet.';
  String closeApp = 'Fechar Aplicativo';
  double szboxHeight = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(noConn),
            SizedBox(height: szboxHeight),
            ElevatedButton(
              onPressed: () {
                if (Theme.of(context).platform == TargetPlatform.android) {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                } else {
                  // No iOS, é melhor apenas retornar à tela anterior ou minimizar o app
                  Navigator.of(context).pop();
                }
              },
              child: Text(closeApp),
            ),
          ],
        ),
      ),
    );
  }
}

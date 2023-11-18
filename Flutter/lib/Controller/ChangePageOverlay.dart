import '../Overlay/Overlay.dart';
import 'package:flutter/material.dart';
import '../Menus/LoginPage.dart';

abstract class ErrorMessageAction {
  void execute(BuildContext context);
}

class ChangeToHome implements ErrorMessageAction {
  @override
  void execute(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (Route<dynamic> route) =>
          false, // Esta condição sempre retorna false, removendo todas as rotas anteriores
    );
  }
}

import 'package:MedAlert/Menus/MainMenu.dart';
import 'package:flutter/material.dart';
import '../Menus/LoginPage.dart';
import '../Class/Class_User.dart';

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

class ChangeToMainMenu implements ErrorMessageAction {
  User user;
  ChangeToMainMenu({required this.user});
  @override
  void execute(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => MainMenu(user: user)),
      (Route<dynamic> route) =>
          false, // Esta condição sempre retorna false, removendo todas as rotas anteriores
    );
  }
}

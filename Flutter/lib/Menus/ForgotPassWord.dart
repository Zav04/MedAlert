import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../Controller/DataBaseConection.dart';
import '../Overlay/Overlay.dart';
import '../Controller/ChangePageOverlay.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with ErrorMessageOverlayMixin {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Fecha o teclado ao tocar fora do campo de texto
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFE8ECF9),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(150),
                      Container(
                        width: 365,
                        height: 177,
                        decoration: const ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Logo.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(40),
                const Text(
                  'Insira um email registado',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  textAlign: TextAlign.left,
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Insira um e-mail válido'),
                  ),
                ),
                const Gap(10),
                ElevatedButton(
                  onPressed: () async {
                    bool isValid = await _dbIsEmailValid(emailController.text);
                    if (isValid) {
                      isValid = await _dbEmailCheck(emailController.text);
                      if (isValid) {
                        removeErrorMessageOverlay();
                        showErrorMessageOverlay("Pedido enviado", 2,
                            action: ChangeToHome());
                      } else {
                        showErrorMessageOverlay(
                            'O email inserido não esta registado', 1);
                      }
                    } else {
                      showErrorMessageOverlay(
                          'O email inserido não é um email valido', 1);
                    }
                  },
                  child: const Text(
                    'Recuperar Palavra-Passe',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<bool> _dbIsEmailValid(String email) async {
    bool status = await dbCheckEmailValid(email);
    return status;
  }

  Future<bool> _dbEmailCheck(String email) async {
    bool emailExists = await dbCheckEmailExists(email);
    return emailExists;
  }
}

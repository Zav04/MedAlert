import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../Controller/DataBaseConection.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          removeErrorMessageOverlay();
          return true;
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
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
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
                      } else {
                        showErrorMessageOverlay(
                            'Este email não esta registado');
                      }
                    } else {
                      showErrorMessageOverlay('Não é um Email válido');
                    }
                  },
                  child: const Text(
                    'Recuperar Palavra-Passe',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white), // Você pode personalizar a cor
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void showErrorMessageOverlay(String message) {
    // Remove o overlay anterior se já estiver sendo exibido
    overlayEntry?.remove();

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height *
            0.8, // Posicionamento do overlay
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.red,
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );

    // Insere o overlay
    Overlay.of(context).insert(overlayEntry!);
  }

  void removeErrorMessageOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
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

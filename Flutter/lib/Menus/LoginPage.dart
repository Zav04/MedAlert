import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../Controller/PasswordField.dart';
import 'ForgotPassWord.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Insira um e-mail válido como abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: PasswordField(),
            ),
            const Gap(10),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ForgotPassword()));
              },
              child: const Text(
                'Esqueceu-se da sua Palavra passe',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue), // Você pode personalizar a cor
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
                  //TODO fazer o backend para validar se existe
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            TextButton(
              onPressed: () {
                //TODO: Criação de novo utilizador
                print('Precionado');
              },
              child: const Text(
                'Novo Utilizador? Criar conta',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue), // Você pode personalizar a cor
              ),
            ),
          ],
        ),
      ),
    );
  }
}

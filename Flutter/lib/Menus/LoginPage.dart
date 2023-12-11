import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../Controller/PasswordField.dart';
import 'ForgotPassWord.dart';
import 'CreateUser.dart';
import '../Class/Class_User.dart';
import '../Controller/DataBaseConection.dart';
import '../Overlay/Overlay.dart';
import '../Controller/ChangePageOverlay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ErrorMessageOverlayMixin {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  User validUser = User(userId: 0);
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
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Insira um e-mail válido como abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: PasswordField(controller: _passwordController),
                ),
                const Gap(10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ForgotPassword()));
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
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () async {
                      var validation = await login(
                          email: _emailController.text,
                          password: _passwordController.text);
                      if (validation.success == true) {
                        int id = await getId(_emailController.text);
                        validUser.userId = id;
                        var role = await getUserRole(id);
                        if (role.data.toString() == 'Family' ||
                            role.data.toString() == 'Doctor' ||
                            role.data.toString() == 'HealthCare') {
                          showErrorMessageOverlay(
                              "Login efetuado com Sucesso", 2,
                              action:
                                  ChangeToMainMenuInspector(user: validUser));
                        } else {
                          showErrorMessageOverlay(
                              "Login efetuado com Sucesso", 2,
                              action: ChangeToMainMenu(user: validUser));
                        }
                      } else {
                        if (validation.errorMessage == null) {
                          showErrorMessageOverlay("Credenciais Invalidas", 1);
                        } else {
                          showErrorMessageOverlay(
                              validation.errorMessage.toString(), 1);
                        }
                      }
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CreateUser()));
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
        ));
  }
}

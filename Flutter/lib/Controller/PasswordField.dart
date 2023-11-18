import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordField({Key? key, required this.controller}) : super(key: key);
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Password',
        hintText: 'Insira a sua Palavra passe',
        suffixIcon: IconButton(
          icon: Icon(
            // Alterna os ícones de olho aberto/fechado
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            // Atualiza o estado para mostrar ou esconder
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}

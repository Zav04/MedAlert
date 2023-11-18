import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostalCodeFields extends StatelessWidget {
  final TextEditingController combinedPostalCodeController;

  const PostalCodeFields({Key? key, required this.combinedPostalCodeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController postalCode1Controller = TextEditingController();
    final TextEditingController postalCode2Controller = TextEditingController();

    // Atualiza o combinedPostalCodeController sempre que houver uma mudança
    void updateCombinedPostalCode() {
      combinedPostalCodeController.text =
          '${postalCode1Controller.text}-${postalCode2Controller.text}';
    }

    postalCode1Controller.addListener(updateCombinedPostalCode);
    postalCode2Controller.addListener(updateCombinedPostalCode);

    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: postalCode1Controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            decoration: const InputDecoration(
              labelText: 'Código Postal',
              hintText: 'Insira os primeiros 4 digitos do Código Postal',
            ),
            onChanged: (value) {
              updateCombinedPostalCode();
            },
          ),
        ),
        const SizedBox(width: 10),
        const Text("-", style: TextStyle(fontSize: 30, height: 2)),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: postalCode2Controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            decoration: const InputDecoration(
              labelText: 'Código Postal',
              hintText: 'Insira os ultimos 3 digitos do Código Postal',
            ),
            onChanged: (value) {
              updateCombinedPostalCode();
            },
          ),
        ),
      ],
    );
  }
}

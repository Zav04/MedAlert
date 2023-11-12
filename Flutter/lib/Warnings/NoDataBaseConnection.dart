import 'package:flutter/material.dart';

class NoConnectionWidget extends StatelessWidget {
  final VoidCallback tryAgainAction;

  const NoConnectionWidget({
    Key? key,
    required this.tryAgainAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 100),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 50,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Oops! Sem conexão com a internet. Conecte-se para acessar todas as funcionalidades da aplicação',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: tryAgainAction,
              child: const Text('Reconnectar', style: TextStyle(fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}

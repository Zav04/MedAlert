import 'package:flutter/material.dart';

class NoConnectionWidget extends StatelessWidget {
  final VoidCallback tryAgainAction;
  final VoidCallback exitAction;

  NoConnectionWidget({
    Key? key,
    required this.tryAgainAction,
    required this.exitAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 100),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'SEM LIGAÇÃO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: tryAgainAction,
              child: Text('TENTAR'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: exitAction,
              child: Text('SAIR'),
            ),
          ],
        ),
      ),
    );
  }
}

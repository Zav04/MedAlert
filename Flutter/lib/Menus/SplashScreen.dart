import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.only(
                top: 333,
                left: 12,
                right: 13,
                bottom: 311,
              ),
              decoration: const BoxDecoration(color: Color(0xFFE8ECF9)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 365,
                    height: 177,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Logo.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Loading, Please Wait',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

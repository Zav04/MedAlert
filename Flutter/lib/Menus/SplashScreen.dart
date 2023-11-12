import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: const BoxDecoration(color: Color(0xFFE8ECF9)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 365,
              height: 177,
              decoration: const ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Logo.png'),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                ),
              ),
            ),
            const SizedBox(height: 20),
            LoadingAnimationWidget.bouncingBall(
              color: Color.fromRGBO(62, 88, 143, 1.0),
              size: 80,
            ),
            const SizedBox(height: 10),
            const Text(
              'Loading, Please Wait',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

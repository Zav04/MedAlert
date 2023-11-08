import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          height: 844,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 333,
                    left: 12,
                    right: 13,
                    bottom: 311,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Color(0xFFE8ECF9)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
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
                              side: BorderSide(width: 1)),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Loading, Please Wait',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

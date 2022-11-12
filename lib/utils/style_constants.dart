import 'package:flutter/material.dart';

class StyleConstants {
  static const TextStyle onboardingText =
      TextStyle(fontSize: 20.0, color: Colors.white);

  static const TextStyle loginHintTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'OpenSans',
  );

  static const TextStyle loginLabelTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  static BoxDecoration loginBoxDecorationStyle = BoxDecoration(
    border: Border.all(color: Colors.black26),
    color: Colors.white,
    borderRadius: BorderRadius.circular(30.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  static const TextStyle answerText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
    fontSize: 20,
  );

  static const textAnswer = TextStyle(
    color: Colors.white,
    //fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
    fontSize: 15,
  );
}

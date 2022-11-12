import 'package:flutter/material.dart';
import '../constants/colors.dart';

class StyleConstants {
  static const TextStyle onboardingText =
      TextStyle(fontSize: 20.0, color: Colors.white);

  static TextStyle loginHintTextStyle = TextStyle(
    color: LightTheme.foregroundAlt,
    fontFamily: 'OpenSans',
  );

  static const TextStyle loginLabelTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  static BoxDecoration loginBoxDecorationStyle = BoxDecoration(
    border: Border.all(color: Colors.transparent),
    borderRadius: BorderRadius.circular(50.0),
    boxShadow: const [
      BoxShadow(
        color: Color(0x25000000),
        blurRadius: 8.0,
        offset: Offset(0, 4),
      ),
    ],
    color: Colors.white,
  );

  static const TextStyle answerText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
    fontSize: 20,
  );

  static const textAnswer = TextStyle(
    color: Colors.white,
    fontFamily: 'OpenSans',
    fontSize: 15,
  );
}

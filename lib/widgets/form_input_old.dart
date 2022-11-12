import 'package:flutter/material.dart';

import '../constants.dart';

class FormInput extends StatelessWidget {
  final IconData icon;
  final String prompt;
  final TextInputType? textInputType;
  final bool obscure;
  final TextEditingController textEditingController;

  const FormInput({
    super.key,
    required this.icon,
    required this.prompt,
    this.textInputType,
    this.obscure = false,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: StyleConstants.loginBoxDecorationStyle,
      height: 60.0,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: obscure,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          hintText: 'Enter your $prompt',
          hintStyle: StyleConstants.loginHintTextStyle,
        ),
      ),
    );
  }
}

// Flutter
import 'package:flutter/material.dart';

// Local imports
import 'package:harvesthacks2022/constants/colors.dart';

class StyledInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const StyledInput({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8.0,
            offset: Offset(0, 2),
            color: Color(0x3F000000),
          ),
        ],
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 16.0),
      height: 60.0,
      child: Center(
        child: TextField(
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 14.0),
            hintText: label,
            hintStyle: TextStyle(
              color: LightTheme.foregroundAlt,
            ),
          ),
          controller: controller,
        ),
      ),
    );
  }
}

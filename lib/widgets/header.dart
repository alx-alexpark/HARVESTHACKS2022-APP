// Flutter
import 'package:flutter/material.dart';

// Local imports
import 'package:harvesthacks2022/constants/colors.dart';

class Header extends StatelessWidget {
  final String title;
  final String? subheading;

  const Header({
    super.key,
    this.subheading,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Text(
        title,
        style: const TextStyle(
          fontSize: 48.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Divider(
          color: LightTheme.foreground,
          thickness: 2.0,
        ),
      ),
    ];

    if (subheading != null) {
      children.add(
        Text(
          subheading!,
          style: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      );
    }

    return Positioned(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

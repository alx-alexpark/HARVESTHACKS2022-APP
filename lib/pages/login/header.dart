import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class Header extends StatelessWidget {
  final String subheading;

  const Header({
    super.key,
    required this.subheading,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Unflash",
            style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Divider(
              color: LightTheme.foreground,
              thickness: 3.0,
            ),
          ),
          Text(
            subheading,
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

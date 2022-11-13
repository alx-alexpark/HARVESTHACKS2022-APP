// Flutter
import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';

// Local imports
import 'package:harvesthacks2022/constants/colors.dart';

import 'package:harvesthacks2022/pages/login.dart';

class UserBlock extends StatelessWidget {
  final String username;
  final String email;

  const UserBlock({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        CircleAvatar(
          backgroundColor: GlobalTheme.accent,
          radius: 35,
          child: Text(
            username[0],
            style: const TextStyle(
              fontSize: 28,
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Info and Buttons
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              email,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: LightTheme.foregroundAlt,
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                  Color(0xFFC62368),
                ),
                padding: MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 18.0),
                ),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: Text(
                "Log out",
                style: TextStyle(
                  color: LightTheme.background,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harvesthacks2022/pages/login.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          child: const Text("Log out"),
        ),
      ],
    );
  }
}

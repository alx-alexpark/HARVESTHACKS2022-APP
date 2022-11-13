// Flutter
import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harvesthacks2022/constants/colors.dart';

// Local imports
import 'package:harvesthacks2022/pages/settings/user.dart';
import 'package:harvesthacks2022/widgets/header.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // int _slider = StorageManager.readData("ai_temp") as int;
  // int _model = StorageManager.readData("ai_model") as int;
  int _slider = 1;
  int _model = 2;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;

    return Padding(
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Header(title: "Settings"),
            const SizedBox(height: 50),

            // User
            UserBlock(
              username: user?.displayName ?? "?",
              email: user?.email ?? "",
            ),
            const SizedBox(height: 50),

            // Theme settings
            const Text(
              "AI settings",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: GlobalTheme.accent,
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Level of variation: ${["Low", "Medium", "High"][_slider]}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Slider(
                    value: _slider.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _slider = value.floor();
                      });
                      // StorageManager.saveData("ai_temp", _slider);
                    },
                    min: 0,
                    max: 2,
                    divisions: 2,
                  ),
                  Text(
                    "Model: ${["Bad", "Okay", "Good", "Advanced"][_model]}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Slider(
                    value: _model.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _model = value.floor();
                      });
                      // StorageManager.saveData("ai_temp", _model);
                    },
                    min: 0,
                    max: 3,
                    divisions: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

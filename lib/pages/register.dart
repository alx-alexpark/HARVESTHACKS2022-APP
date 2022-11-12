import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/dialogs.dart';
import '../widgets/form_input.dart';
import 'home.dart';
import 'login/waves.dart';
import '../widgets/header.dart';

class RegisterPage extends StatefulWidget {
  final String email;
  final String password;

  const RegisterPage({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController usernameInputController;
  late TextEditingController emailInputController;
  late TextEditingController passwordInputController;
  late TextEditingController passwordConfirmInputController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    usernameInputController = TextEditingController();
    emailInputController = TextEditingController();
    passwordInputController = TextEditingController();
    passwordConfirmInputController = TextEditingController();

    emailInputController.text = widget.email;
    passwordInputController.text = widget.password;
  }

  void _handleRegister() {
    if (passwordInputController.text != passwordConfirmInputController.text) {
      dialogPasswordsMismatch(context);
    }

    if (usernameInputController.text.isNotEmpty) {
      print("HELLO");
      // TODO: setup database user initialization
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailInputController.text,
              password: passwordInputController.text)
          .then((currentUser) async {
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.user!.uid)
            .set({
          "username": usernameInputController.text,
          "email": emailInputController.text,
          "uid": currentUser.user!.uid,
          "introduced": false,
          "courses": [],
        });
      });
      print("sign up");
      print(FirebaseAuth.instance.currentUser);
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Inputs
                FormInput(
                  icon: Icons.person,
                  prompt: "Username",
                  textEditingController: usernameInputController,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 25.0),
                FormInput(
                  icon: Icons.email,
                  prompt: "Email",
                  textEditingController: emailInputController,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 25.0),
                FormInput(
                  icon: Icons.lock,
                  prompt: "Password",
                  textEditingController: passwordInputController,
                  obscure: true,
                ),
                const SizedBox(height: 25.0),
                FormInput(
                  icon: Icons.lock,
                  prompt: "Confirm password",
                  textEditingController: passwordConfirmInputController,
                  obscure: true,
                ),
                const SizedBox(height: 25.0),

                // Register buttons
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: _handleRegister,
                        style: TextButton.styleFrom(
                          backgroundColor: LightTheme.foreground,
                          foregroundColor: LightTheme.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: LightTheme.foreground),
                          ),
                        ),
                        child: const Text("Register"),
                      ),
                    ),
                    const SizedBox(width: 25.0),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: LightTheme.foreground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(
                              color: LightTheme.foreground,
                              width: 3.0,
                            ),
                          ),
                        ),
                        child: const Text("Already a user?"),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Title (top)
            Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: const Header(
                title: "Unflash",
                subheading: 'Make your new\naccount',
              ),
            )

            // Waves (bottom)
            // const BottomWaves(),
          ],
        ),
      ),
    );
  }
}

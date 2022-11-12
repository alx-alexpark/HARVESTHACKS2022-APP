import 'package:flutter/material.dart';
import 'package:harvesthacks2022/pages/register.dart';

import '../constants/colors.dart';
import '../widgets/form_input.dart';
import 'login/waves.dart';
import 'login/header.dart';

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
  late TextEditingController emailInputController;
  late TextEditingController passwordInputController;
  late TextEditingController passwordConfirmInputController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    emailInputController = TextEditingController();
    passwordInputController = TextEditingController();
    passwordConfirmInputController = TextEditingController();

    emailInputController.text = widget.email;
    passwordInputController.text = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Inputs
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
                        onPressed: () {},
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
            const Header(subheading: 'Make your new\naccount'),

            // Waves (bottom)
            // const BottomWaves(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:harvesthacks2022/pages/register.dart';

import '../constants/colors.dart';
import '../widgets/form_input.dart';
import './login/waves.dart';
import './login/header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailInputController;
  late TextEditingController passwordInputController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    emailInputController = TextEditingController();
    passwordInputController = TextEditingController();
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

                // Login buttons
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
                        child: const Text("Login"),
                      ),
                    ),
                    const SizedBox(width: 25.0),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterPage(
                              email: emailInputController.text,
                              password: passwordInputController.text,
                            ),
                          ));
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
                        child: const Text("Need an account?"),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Title (top)
            const Header(subheading: 'Sign in to your\naccount'),

            // Waves (bottom)
            // const BottomWaves(),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/register.dart';
import '../constants/colors.dart';
import '../utils/dialogs.dart';
import '../widgets/form_input.dart';
import './login/waves.dart';
import './login/header.dart';
import './home.dart';

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

  String emailValidator(String? value) {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Email format is invalid';
    } else {
      return "";
    }
  }

  void login() async {
    print("LOGIN ATTEMPTED");

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailInputController.text,
            password: passwordInputController.text)
        .then((currentUser) async {
      print(currentUser.user!.uid);

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.user!.uid)
          .get();
      print(snapshot.data);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }).catchError(
      (e) {
        if (emailInputController.text.isEmpty ||
            passwordInputController.text.isEmpty) {
          dialogMissingInput(context);
        }

        print(e.toString());

        if (e.toString().startsWith('[firebase_auth/wrong-password]') ||
            e.toString().startsWith('[firebase_auth/user-not-found]')) {
          dialogMissingEmailOrPassword(context);
        }
      },
    );
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
                  icon: Icons.email,
                  prompt: "Email",
                  textEditingController: emailInputController,
                  textInputType: TextInputType.emailAddress,
                  validator: emailValidator,
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
                        onPressed: login,
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

                    // Switch to register page
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
            Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: const Header(subheading: 'Sign in to your\naccount'),
            )

            // Waves (bottom)
            // const BottomWaves(),
          ],
        ),
      ),
    );
  }
}

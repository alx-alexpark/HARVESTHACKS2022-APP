import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harvesthacks2022/screens/home.dart';
import 'package:harvesthacks2022/screens/sign_up.dart';
import 'package:harvesthacks2022/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harvesthacks2022/widgets/form_input_old.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int pageIndex = 0;
  late TextEditingController emailInputController;
  late TextEditingController passwordInputController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    emailInputController = TextEditingController();
    passwordInputController = TextEditingController();
  }

  String emailValidator(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 50.0, 0.0, 0.0),
                      child: const Text(
                        'UnFlash',
                        style: TextStyle(
                          fontSize: 70.0,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 125.0, 0.0, 0.0),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),

            /*
             * Form inputs
             */
            Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 40.0),
                      FormInput(
                        icon: Icons.email,
                        prompt: 'email',
                        textInputType: TextInputType.emailAddress,
                        textEditingController: emailInputController,
                      ),
                      const SizedBox(height: 30.0),
                      FormInput(
                        icon: Icons.lock,
                        prompt: 'password',
                        obscure: true,
                        textEditingController: passwordInputController,
                      ),
                    ],
                  ),

                  //SizedBox(height: MediaQuery.of(context).size.height / 5,),
                  const SizedBox(
                    height: 40.0,
                  ),

                  GestureDetector(
                    onTap: () async {
                      print("LOGIN ATTEMPTED");
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailInputController.text,
                              password: passwordInputController.text)
                          .then((currentUser) async {
                        print(currentUser.user!.uid);
                        DocumentSnapshot snapshot = await FirebaseFirestore
                            .instance
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
                      }).catchError((e) {
                        print(e.toString());
                        if (e.toString() ==
                            '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Invalid Email or Password',
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text(
                                        'Ok',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                        if (e.toString() ==
                            '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Invalid Email or Password',
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text(
                                        'Ok',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    child: const Text('Register'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (Material(
                            child: SignupScreen(),
                          )),
                        ),
                      );
                    },
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

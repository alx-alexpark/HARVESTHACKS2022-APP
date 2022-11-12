import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:harvesthacks2022/screens/home.dart';
// import 'package:path/path.dart' as Path;
import 'package:harvesthacks2022/screens/login.dart';
import 'package:harvesthacks2022/constants.dart';

alertDialog(BuildContext context) {
  // This is the ok button
  Widget ok = TextButton(
    child: const Text("Okay"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // show the alert dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("I am Here!"),
        content: const Text("I appeared because you pressed the button!"),
        actions: [
          ok,
        ],
        elevation: 5,
      );
    },
  );
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  late TextEditingController nameInputController;
  late TextEditingController emailInputController;
  late TextEditingController passwordInputController;

  @override
  void initState() {
    super.initState();
    nameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    passwordInputController = new TextEditingController();
  }

  // String? emailValidator(String value) {
  //   String pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regex = new RegExp(pattern);
  //   if (!regex.hasMatch(value)) {
  //     return 'Email format is invalid';
  //   }
  // }

  // String? passwordValidator(String value) {
  //   if (value.length < 8) {
  //     return 'Password length must be longer than 8 characters';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          //SizedBox(height: 20.0,),
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                  child: const Text('UnFlash',
                      style: TextStyle(
                          fontSize: 70.0,
                          fontWeight: FontWeight.w200,
                          color: Colors.black)),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 125.0, 0.0, 0.0),
                  child: const Text('Sign up',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),

          Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _signUpFormKey,
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 40.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: StyleConstants.loginBoxDecorationStyle,
                        height: 60.0,
                        child: TextFormField(
                          controller: nameInputController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(top: 14.0),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            hintText: 'Name',
                            hintStyle: StyleConstants.loginHintTextStyle,
                          ),
                          validator: (input) {
                            if (input!.trim().isEmpty) {
                              return "Please input a valid name";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 15.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: StyleConstants.loginBoxDecorationStyle,
                        height: 60.0,
                        child: TextFormField(
                          controller: emailInputController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(top: 14.0),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            hintText: 'Email',
                            hintStyle: StyleConstants.loginHintTextStyle,
                          ),
                          // validator: emailValidator,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 15.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: StyleConstants.loginBoxDecorationStyle,
                        height: 60.0,
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordInputController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(top: 14.0),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            hintText: 'Password',
                            hintStyle: StyleConstants.loginHintTextStyle,
                          ),
                          // validator: passwordValidator,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      if (nameInputController.text.isNotEmpty) {
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
                            "name": nameInputController.text,
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
                    },
                    child: SizedBox(
                      height: 50.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(25.0),
                        shadowColor: Colors.blue,
                        color: Colors.black,
                        elevation: 5.0,
                        child: const Center(
                          child: Text(
                            'SIGNUP',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            alignment: Alignment.topCenter,
            child: TextButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => (const LoginScreen()),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harvesthacks2022/screens/Home.dart';
import 'package:harvesthacks2022/screens/sign_up.dart';
import 'package:harvesthacks2022/utils/style_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:trailqr/screens/bottomBarScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int pageIndex = 0;
  late TextEditingController emailInputController;
  late TextEditingController passwordInputController;
  final GlobalKey<FormState> _loginFormKey = new GlobalKey();

  @override
  void initState() {
    emailInputController = new TextEditingController();
    passwordInputController = new TextEditingController();
  }

  String emailValidator(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
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
        child: Container(
            child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 50.0, 0.0, 0.0),
                        child: Text('UnFlash',
                            style: TextStyle(
                                fontSize: 70.0,
                                fontWeight: FontWeight.w200,
                                color: Colors.black)),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 125.0, 0.0, 0.0),
                        child: Text('Sign in',
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 40.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: StyleConstants.loginBoxDecorationStyle,
                            height: 60.0,
                            child: TextFormField(
                              controller: emailInputController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                hintText: 'Enter your Email',
                                hintStyle: StyleConstants.loginHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: StyleConstants.loginBoxDecorationStyle,
                            height: 60.0,
                            child: TextFormField(
                              controller: passwordInputController,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                hintText: 'Enter your Password',
                                hintStyle: StyleConstants.loginHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //SizedBox(height: MediaQuery.of(context).size.height / 5,),
                  SizedBox(
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
                          MaterialPageRoute(builder: (context) => HomePage()),
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
                                  title: Text(
                                    'Invalid Email or Password',
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
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
                                  title: Text(
                                    'Invalid Email or Password',
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
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
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text('Register'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                (Material(child: SignupScreen()))),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

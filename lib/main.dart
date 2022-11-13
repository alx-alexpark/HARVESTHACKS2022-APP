// Flutter
import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// Local imports
import 'package:harvesthacks2022/firebase_options.dart';

import 'package:harvesthacks2022/widgets/themed_material_app.dart';

import 'package:harvesthacks2022/pages/login.dart';
import 'package:harvesthacks2022/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());

          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ThemedMaterialApp(
            home: Scaffold(
              body: FirebaseAuth.instance.currentUser != null
                  ? const HomePage()
                  : const LoginPage(),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

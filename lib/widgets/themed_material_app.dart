// Flutter
import 'package:flutter/material.dart';

class ThemedMaterialApp extends StatelessWidget {
  final Widget home;

  const ThemedMaterialApp({
    super.key,
    required this.home,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unflash',
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en'),
      ],

      // Themes
      theme: ThemeData(
        brightness: Brightness.light,

        // Colors
        backgroundColor: const Color(0xFFFFFFFF),
        primaryColor: const Color(0xFF6159D0),
        hintColor: const Color(0xFFA2A2A2),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF272635),
        ),

        // Fonts
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontSize: 18),
        ),
      ),

      darkTheme: ThemeData(
        // How to break your code by uncommenting the line below 101
        // brightness: Brightness.dark,

        // Colors
        backgroundColor: const Color(0xFF272635),
        primaryColor: const Color(0xFF6159D0),
        hintColor: const Color(0xFFA2A2A2),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFFFFFFF),
        ),

        // Fonts
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontSize: 18),
        ),
      ),

      themeMode: ThemeMode.system,

      // Widgets B)
      home: SafeArea(child: home),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'poppins',
        primaryColor: Colors.white,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        accentColor: Colors.blue,
        focusColor: Colors.red,
        textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            headline2: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.blue,
            ),
            bodyText1: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.redAccent,
            )),
      ),
      home: const LoginPage(),
    );
  }
}

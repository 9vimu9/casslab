import 'package:casslab/classifiers/classifier.dart';
import 'package:casslab/classifiers/classifier_one.dart';
import 'package:casslab/screens/Login/login_screen.dart';
import 'package:casslab/screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      title: 'Cassava Recognition',
      // home: Home(ClassifierOne()),
      // home: LoginScreen(),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

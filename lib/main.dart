import 'package:casslab/screens/Save/save_screen.dart';
import 'package:casslab/screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

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
      ),
      title: 'Cassava Recognition',
      home: WelcomeScreen(),
      // home: SaveScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:casslab/classifiers/classifier.dart';
import 'package:casslab/classifiers/classifier_one.dart';
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
      title: 'Cassava Recognition',
      home: Home(ClassifierOne()),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:casslab/classifiers/classifier_one.dart';
import 'package:casslab/screens/Prediction/components/body.dart';
import 'package:flutter/material.dart';

class PredictionScreen extends StatelessWidget {

  const PredictionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(ClassifierOne()),
    );
  }
}

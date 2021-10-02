import 'dart:io';

import 'package:tflite/tflite.dart';


abstract class Classifier{

  final String classifierPath;
  final String labelsPath;

  Classifier(this.classifierPath, this.labelsPath);

  loadModel() async {
    await Tflite.loadModel(
      model: classifierPath,
      labels: labelsPath,
    );
  }

  closeModel() {
    Tflite.close();
  }

  Future<List> classifyImage(File? image);


}
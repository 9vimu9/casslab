import 'dart:io';

import 'package:tflite/tflite.dart';


abstract class Classifier{

  final String classifierPath;
  final String labelsPath;
  List<Map<String, String>> classes;

  Classifier(this.classifierPath, this.labelsPath,this.classes);

  loadModel() async {
    await Tflite.loadModel(
      model: classifierPath,
      labels: labelsPath,
    );
  }

  closeModel() {
    Tflite.close();
  }

  Future<String> classifyImage(File? image);


}
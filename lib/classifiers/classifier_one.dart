import 'dart:io';
import 'dart:typed_data';

import 'package:casslab/classifiers/classifier.dart';
import 'package:image/image.dart' as img;
import 'package:tflite/tflite.dart';

const int IMAGE_SIZE = 224;
const int NUMBER_OF_CLASSES = 6;
const double THRESHOLD = 0.1;
const double MEAN = 127.5;
const double STD = 127.5;
const Map<String, String> UNKNOWN_CLASS = {"label": "Unknown", "class": "5"};

const String MODEL_PATH = "assets/models/model.tflite";
const String LABELS_PATH = "assets/models/labels.txt";

const List<Map<String, String>> CLASSES = [
  {"label": "Bacterial Blight", "class": "0"},
  {"label": "Brown Streak", "class": "1"},
  {"label": "Green Mite", "class": "2"},
  {"label": "Mosaic", "class": "3"},
  {"label": "Healthy", "class": "4"},
  UNKNOWN_CLASS,
];

class ClassifierOne extends Classifier {
  ClassifierOne() : super(MODEL_PATH, LABELS_PATH, CLASSES);

  @override
  Future<String> classifyImage(File? image) async {
    List<dynamic>? output;
    if(image != null){
      img.Image oriImage = img.decodeJpg(image.readAsBytesSync());

      img.Image resizedImage = img.copyResize(
        oriImage,
        height: IMAGE_SIZE,
        width: IMAGE_SIZE,
      );

      output = await Tflite.runModelOnBinary(
          binary: _imageToByteListFloat32(resizedImage, IMAGE_SIZE, MEAN, STD),
          numResults: NUMBER_OF_CLASSES,
          threshold: THRESHOLD,
          asynch: true);
    }

    if (output == null || output.isEmpty) {
      output = [UNKNOWN_CLASS];
    }

    print("********************OUTPUT***********************");
    print(output);

    if (output.length > 1 && output[0]["index"].toString() == UNKNOWN_CLASS["class"]) {
      output = [output[1]];
    }

    return _getLabelFromValue(output[0]["label"]);
  }

  Uint8List _imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  String _getLabelFromValue(String className) {
    for (var mlClass in CLASSES) {
      if (mlClass["class"] == className) {
        return mlClass["label"]!;
      }
    }
    return UNKNOWN_CLASS["label"]!;
  }
}
/*
* Machine learning models
[https://colab.research.google.com/drive/1HALRWZHvCFrhFetq7NEV60ZP_yNltB2P#scrollTo=mAYq1H6nw1-j](https://colab.research.google.com/drive/1HALRWZHvCFrhFetq7NEV60ZP_yNltB2P#scrollTo=mAYq1H6nw1-j)

TensorFlow hub cassava model
[https://tfhub.dev/google/lite-model/cropnet/classifier/cassava_disease_V1/1](https://tfhub.dev/google/lite-model/cropnet/classifier/cassava_disease_V1/1)

google collab of TensorFlow hub
[https://colab.research.google.com/github/tensorflow/hub/blob/master/examples/colab/cropnet_cassava.ipynb](https://colab.research.google.com/github/tensorflow/hub/blob/master/examples/colab/cropnet_cassava.ipynb)

kaggle my code
[https://www.kaggle.com/nipunwimukthi/cassava-infer/edit](https://www.kaggle.com/nipunwimukthi/cassava-infer/edit)

kaggle ref code
[cassava-infer](https://www.kaggle.com/devonstanfield/cassava-infer/notebook)
*
* */

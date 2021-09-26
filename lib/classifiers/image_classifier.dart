import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:tflite/tflite.dart';

const int IMAGE_SIZE = 224;
const int NUMBER_OF_CLASSES = 6;
const double THRESHOLD = 0.1;
const double MEAN = 127.5;
const double STD = 127.5;
const String UNKNOWN_LABEL = "unknown";

const String MODEL_PATH = "assets/models/model.tflite";
const String LABELS_PATH = "assets/models/labels.txt";

class ImageClassifier {
  static Future<List> classifyImage(File image) async {
    img.Image oriImage = img.decodeJpg(image.readAsBytesSync());

    img.Image resizedImage = img.copyResize(
      oriImage,
      height: IMAGE_SIZE,
      width: IMAGE_SIZE,
    );

    var output = await Tflite.runModelOnBinary(
        binary: _imageToByteListFloat32(
          resizedImage,
          IMAGE_SIZE,
          MEAN,
          STD,
        ),
        numResults: NUMBER_OF_CLASSES,
        threshold: THRESHOLD,
        asynch: true);

    if (output == null || output.isEmpty) {
      output = [
        {"label": UNKNOWN_LABEL}
      ];
    }
    return output;
  }

  static Uint8List _imageToByteListFloat32(
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

  static loadModel() async {
    await Tflite.loadModel(
      model: MODEL_PATH,
      labels: LABELS_PATH,
    );
  }

  static closeModel() {
    Tflite.close();
  }
}

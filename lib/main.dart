import 'dart:async';
import 'package:camera/camera.dart';
import 'package:casslab/helpers/helpers.dart';
import 'package:casslab/widgets/image_capture_view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    // Fetch the available cameras before initializing the app.
    List<CameraDescription> cameras = await availableCameras();
    CameraDescription camera = cameras[0];
    runApp(ImageCaptureView(camera));
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
}
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

void logError(String code, String? message) {
  if (message != null) {
    print('Error: $code\nError Message: $message');
  } else {
    print('Error: $code');
  }
}

void showInSnackBar(String message, {String title = "CassLab"}) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM, colorText: Colors.black);
}

Future<String> getFilePathWithGeneratedFileName(
  String extension, {
  bool withUnixTime = false,
  String? filePath,
}) async {
  if (filePath == null) {
    final Directory directory = await getApplicationDocumentsDirectory();
    filePath = directory.path;
  }

  List<int> values =
      List<int>.generate(10, (i) => Random.secure().nextInt(255));
  String filePathWithExtension = filePath + base64UrlEncode(values);

  if (withUnixTime) {
    filePathWithExtension = filePathWithExtension +
        "_" +
        DateTime.now().millisecondsSinceEpoch.toString();
  }

  return filePathWithExtension +"."+ extension;
}

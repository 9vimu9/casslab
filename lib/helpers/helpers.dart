import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';


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

  String filePathWithExtension = filePath + generateRandomString(10);

  if (withUnixTime) {
    filePathWithExtension = filePathWithExtension +
        "_" +
        getUnixTimeStampInMillis().toString();
  }

  return filePathWithExtension + "." + extension;
}

Future<bool> internetAvailable() async {

  ConnectivityResult connectivityResult =
      await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  }

  return false;
}

String generateRandomString(int length) {
  List<int> values =
      List<int>.generate(length, (i) => Random.secure().nextInt(255));
  return base64UrlEncode(values);
}

int getUnixTimeStampInMillis(){
  return DateTime.now().toUtc().millisecondsSinceEpoch;
}
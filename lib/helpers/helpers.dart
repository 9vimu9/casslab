import 'package:flutter/material.dart';
import 'package:get/get.dart';

void logError(String code, String? message) {
  if (message != null) {
    print('Error: $code\nError Message: $message');
  } else {
    print('Error: $code');
  }
}

void showInSnackBar(String message) {
  Get.snackbar("Camera", message,snackPosition: SnackPosition.BOTTOM,colorText: Colors.white );
}
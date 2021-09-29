import 'package:flutter/material.dart';
import 'package:get/get.dart';

void logError(String code, String? message) {
  if (message != null) {
    print('Error: $code\nError Message: $message');
  } else {
    print('Error: $code');
  }
}

void showInSnackBar(String message,{String title="CassLab"}) {
  Get.snackbar(title, message,snackPosition: SnackPosition.BOTTOM,colorText: Colors.black );
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class GetImageURL {
  final String referenceFilePath;

  GetImageURL(this.referenceFilePath);

  Future<String?> action() async {
    try {
      return await FirebaseStorage.instance.ref().child(referenceFilePath).getDownloadURL();
    } on FirebaseException catch (e) {
      print("file download link error *************************************");
      print(e.code);
      print(e.message);
      return null;
    }
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddImage {
  final String filePath;

  AddImage(this.filePath);

  Future<String?> action() async {
    try {
      String referenceFileName = "uploads/" + basename(filePath);
      await FirebaseStorage.instance
          .ref(referenceFileName)
          .putFile(File(filePath));
      return referenceFileName;
    } on FirebaseException catch (e) {
      print("store error *************************************");
      print(e.code);
      print(e.message);
     return null;
    }
  }
}

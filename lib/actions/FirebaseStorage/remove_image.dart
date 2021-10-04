import 'package:firebase_storage/firebase_storage.dart';

class RemoveImage {
  final String referenceFilePath;

  RemoveImage(this.referenceFilePath);

  Future<void> action() async {
    try {
      await FirebaseStorage.instance.ref().child(referenceFilePath).delete();
    } on FirebaseException catch (e) {
      print("store delete error *************************************");
      print(e.code);
      print(e.message);
    }
  }
}

import 'package:casslab/actions/Authentication/login_firebase.dart';
import 'package:casslab/actions/FirebaseStorage/add_image.dart';
import 'package:casslab/actions/FirebaseStorage/remove_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const key = "favourites";

class FavouriteFirestoreRepository {
  add(
    String description,
    String prediction,
    String imagePath,
    int dateTaken,
    String favouriteID,
  ) {
    LoginFirebase().checkUserIsLoggedIn().first.then((user) async {
      CollectionReference favourites =
          FirebaseFirestore.instance.collection(key);
      String? referenceImagePath = await AddImage(imagePath).action();

      await favourites
          .add({
            'prediction': prediction,
            'description': description,
            'date_taken': dateTaken,
            'user_id': user!.uid,
            'reference_image_path': referenceImagePath,
            'id': favouriteID,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    });
  }

  removeSelectedByFavouriteID(String id) async {
    User? user = await LoginFirebase().getFireBaseUser();
    if (user == null) {
      return;
    }

    CollectionReference favourites = FirebaseFirestore.instance.collection(key);
    QuerySnapshot<Object?> documents =
        await favourites.where("id", isEqualTo: id).get();

    documents.docs.forEach((doc) {
      String referenceImagePath = doc["reference_image_path"];

      favourites.doc(doc.id).delete().then((value) {
        print("favourite Deleted");
        RemoveImage(referenceImagePath).action();
      }).catchError((error) => print("Failed to delete favourite: $error"));
    });
  }

  Future<void> updateDescription(String description, String id) async {
    User? user = await LoginFirebase().getFireBaseUser();
    if (user == null) {
      return;
    }

    CollectionReference favourites = FirebaseFirestore.instance.collection(key);
    QuerySnapshot<Object?> documents =
        await favourites.where("id", isEqualTo: id).get();

    documents.docs.forEach((doc) {
      favourites.doc(doc.id).update({'description': description}).then((value) {
        print("favourite updated");
      }).catchError((error) => print("Failed to update favourite: $error"));
    });
  }
}

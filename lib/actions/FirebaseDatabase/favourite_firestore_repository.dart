import 'package:casslab/Model/favourite_local.dart';
import 'package:casslab/actions/Authentication/login_firebase.dart';
import 'package:casslab/actions/FirebaseStorage/add_image.dart';
import 'package:casslab/actions/FirebaseStorage/remove_image.dart';
import 'package:casslab/actions/LocalStorage/favourite_local_storage_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const key = "favourites";

class FavouriteFirestoreRepository {

  User user;
  FavouriteFirestoreRepository(this.user);

  add(
    String description,
    String prediction,
    String imagePath,
    int dateTaken,
    String favouriteID,
  ) async {

    String? referenceImagePath = await AddImage(imagePath).action();

    await FirebaseFirestore.instance.collection(key).add({
      'prediction': prediction,
      'description': description,
      'date_taken': dateTaken,
      'user_id': user.uid,
      'reference_image_path': referenceImagePath,
      'local_image_path': imagePath,
      'id': favouriteID,
    }).then((value) {
      print("User Added");
      syncData();
    }).catchError((error) => print("Failed to add user: $error"));
  }

  removeSelectedByFavouriteID(String id) async {
    await syncData();

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

  Future<QueryDocumentSnapshot<Object?>?> find(String id) async {
    User? user = await LoginFirebase().getFireBaseUser();
    if (user == null) {
      return null;
    }

    CollectionReference favourites = FirebaseFirestore.instance.collection(key);
    QuerySnapshot<Object?> querySnapshot =
        await favourites.where("id", isEqualTo: id).get();
    List<QueryDocumentSnapshot<Object?>> queryDocumentSnapshots =
        querySnapshot.docs;

    if (queryDocumentSnapshots.isEmpty) {
      return null;
    }

    return queryDocumentSnapshots[0];
  }

  Future<void> updateDescription(String description, String id) async {
    await syncData();

    CollectionReference favourites = FirebaseFirestore.instance.collection(key);
    QuerySnapshot<Object?> documents =
        await favourites.where("id", isEqualTo: id).get();

    documents.docs.forEach((doc) {
      favourites.doc(doc.id).update({'description': description}).then((value) {
        print("favourite updated");
      }).catchError((error) => print("Failed to update favourite: $error"));
    });
  }

  syncData() async {

    List<FavouriteLocal> localFavourites =
        await FavouriteLocalStorageRepository().all();
    for (FavouriteLocal localFavourite in localFavourites) {
      QueryDocumentSnapshot<Object?>? queryDocumentSnapshot =
          await find(localFavourite.id);
      if (queryDocumentSnapshot == null) {
        add(
          localFavourite.description,
          localFavourite.prediction,
          localFavourite.imagePath,
          localFavourite.dateTaken,
          localFavourite.id,
        );
      }
    }
  }
}

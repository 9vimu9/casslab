import 'package:casslab/actions/Authentication/login_firebase.dart';
import 'package:casslab/actions/FirebaseDatabase/favourite_firestore_repository.dart';
import 'package:casslab/actions/LocalStorage/favourite_local_storage_repository.dart';
import 'package:casslab/helpers/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouritesRepository {
  Future<String> add(
    String description,
    String prediction,
    String imagePath,
    int dateTaken,
  ) async {
    String favouriteID = generateRandomString(20);
    bool internetIsAvailable = await internetAvailable();
    User? user = await LoginFirebase().getFireBaseUser();

    if (!internetIsAvailable || user == null) {
      await FavouriteLocalStorageRepository()
          .add(description, prediction, imagePath, dateTaken, favouriteID);
    } else {
      FavouriteFirestoreRepository()
          .add(description, prediction, imagePath, dateTaken, favouriteID);
    }

    return favouriteID;
  }

  updateDescription(String description, String id) async {
    bool internetIsAvailable = await internetAvailable();
    User? user = await LoginFirebase().getFireBaseUser();

    if (!internetIsAvailable || user == null) {
      FavouriteLocalStorageRepository().updateDescription(description, id);
    } else {
      FavouriteFirestoreRepository().updateDescription(description, id);
    }
  }

  removeSelectedByFavouriteID(String id) async {
    bool internetIsAvailable = await internetAvailable();
    User? user = await LoginFirebase().getFireBaseUser();

    if (!internetIsAvailable || user == null) {
      await FavouriteLocalStorageRepository().removeSelectedByFavouriteID(id);
    } else {
      FavouriteFirestoreRepository().removeSelectedByFavouriteID(id);
    }
  }
}

import 'package:casslab/Model/favourite.dart';
import 'package:casslab/Model/favourite_firebase.dart';
import 'package:casslab/Model/favourite_local.dart';
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

    await FavouriteLocalStorageRepository().add(
      description,
      prediction,
      imagePath,
      dateTaken,
      favouriteID,
    );

    if (internetIsAvailable && user != null) {
      await FavouriteFirestoreRepository(user).add(
        description,
        prediction,
        imagePath,
        dateTaken,
        favouriteID,
      );
    }

    return favouriteID;
  }

  updateDescription(String description, String id) async {
    bool internetIsAvailable = await internetAvailable();
    User? user = await LoginFirebase().getFireBaseUser();

    await FavouriteLocalStorageRepository().updateDescription(description, id);

    if (internetIsAvailable && user != null) {
      await FavouriteFirestoreRepository(user).updateDescription(
        description,
        id,
      );
    }
  }

  removeSelectedByFavouriteID(String id) async {
    bool internetIsAvailable = await internetAvailable();
    User? user = await LoginFirebase().getFireBaseUser();

    await FavouriteLocalStorageRepository().removeSelectedByFavouriteID(id);
    if (internetIsAvailable && user != null) {
      await FavouriteFirestoreRepository(user).removeSelectedByFavouriteID(id);
    }
  }

  Future<List<Favourite>> all() async {
    bool internetIsAvailable = await internetAvailable();
    User? user = await LoginFirebase().getFireBaseUser();

    List<Favourite> favourites = [];

    if (internetIsAvailable && user != null) {
      List<FavouriteFirebase> firebaseFavourites =  await FavouriteFirestoreRepository(user).all();
      for(FavouriteFirebase firebaseFavourite in firebaseFavourites){
        Favourite favourite = await firebaseFavourite.getData();
        favourites.add(favourite);
      }
    }else{
      List<FavouriteLocal> localFavourites = await FavouriteLocalStorageRepository().all();

      for(FavouriteLocal localFavourite in localFavourites){
        Favourite favourite = await localFavourite.getData();
        favourites.add(favourite);
      }
    }

    return favourites;
  }

  removeAll() async {
    bool internetIsAvailable = await internetAvailable();
    User? user = await LoginFirebase().getFireBaseUser();
    if (internetIsAvailable && user != null) {
      await FavouriteFirestoreRepository(user).syncData();
    }
    await FavouriteLocalStorageRepository().removeAll();
  }
}

import 'package:casslab/Model/favourite.dart';
import 'package:casslab/Model/favourite_local.dart';
import 'package:casslab/actions/FirebaseDatabase/favourite_firestore_repository.dart';
import 'package:casslab/actions/LocalStorage/favourite_local_storage_repository.dart';
import 'package:casslab/actions/Syncing/sync_favourites.dart';
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

    await FavouriteLocalStorageRepository().add(
      description,
      prediction,
      imagePath,
      dateTaken,
      favouriteID,
    );

    User? user = await readyForUserSyncing();
    if ( user != null) {
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
    await FavouriteLocalStorageRepository().updateDescription(description, id);

    User? user = await readyForUserSyncing();
    if (user != null) {
      await FavouriteFirestoreRepository(user).updateDescription(
        description,
        id,
      );
    }
  }

  removeSelectedByFavouriteID(String id) async {
    await FavouriteLocalStorageRepository().removeSelectedByFavouriteID(id);

    User? user = await readyForUserSyncing();
    if (user != null) {
      await FavouriteFirestoreRepository(user).removeSelectedByFavouriteID(id);
    }
  }

  Future<List<Favourite>> all() async {
    await SyncFavourites().startSyncing();
    List<FavouriteLocal> localFavourites = await FavouriteLocalStorageRepository().all();
    List<Favourite> favourites = [];
    for (FavouriteLocal localFavourite in localFavourites) {
      Favourite favourite = await localFavourite.getData();
      favourites.add(favourite);
    }
    return favourites;
  }

  removeAll() async {
    await SyncFavourites().startSyncing();
    await FavouriteLocalStorageRepository().removeAll();
  }
}

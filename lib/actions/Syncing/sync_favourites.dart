import 'package:casslab/Model/favourite_firebase.dart';
import 'package:casslab/Model/favourite_local.dart';
import 'package:casslab/actions/FirebaseDatabase/favourite_firestore_repository.dart';
import 'package:casslab/actions/FirebaseStorage/download_image.dart';
import 'package:casslab/actions/FirebaseStorage/get_image_url.dart';
import 'package:casslab/actions/LocalStorage/favourite_local_storage_repository.dart';
import 'package:casslab/helpers/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SyncFavourites {
  startSyncing() async {
    // 1 compare local ids with firebase and send missing favourites to firebase
    // 2 compare firebase ids with local and send missing favourites to local
    // 3 compare updated_at date each favourite on both side and update description of the old

    // 1 compare local ids with firebase and send missing favourites to firebase
    User? user = await readyForUserSyncing();
    if (user == null) {
      return;
    }
    FavouriteFirestoreRepository favouriteFirestoreRepository = FavouriteFirestoreRepository(user);
    List<FavouriteLocal> localFavourites = await FavouriteLocalStorageRepository().all();

    for (FavouriteLocal localFavourite in localFavourites) {
      QueryDocumentSnapshot<Object?>? queryDocumentSnapshot = await favouriteFirestoreRepository.find(localFavourite.id);
      if (queryDocumentSnapshot == null) {
        await favouriteFirestoreRepository.add(
          localFavourite.description,
          localFavourite.prediction,
          localFavourite.imagePath,
          localFavourite.dateTaken,
          localFavourite.id,
        );
      }
    }

    // 2 compare firebase ids with local and send missing favourites to local
    List<FavouriteFirebase> firebaseFavourites =  await FavouriteFirestoreRepository(user).all();

    for(FavouriteFirebase firebaseFavourite in firebaseFavourites){

      FavouriteLocal? favouriteLocal = await FavouriteLocalStorageRepository().find(firebaseFavourite.id);

      if(favouriteLocal == null){

        String? localFilePath = await _getLocalFilePathOfTheCloudImage(firebaseFavourite);
        // ToDO : show template image if image is null

        await FavouriteLocalStorageRepository().add(
          firebaseFavourite.description,
          firebaseFavourite.prediction,
          localFilePath!,
          firebaseFavourite.dateTaken,
          firebaseFavourite.id
        );
      }
    }

    // 3 compare updated_at date each favourite on both side and update description of the old
    favouriteFirestoreRepository = FavouriteFirestoreRepository(user);
    localFavourites = await FavouriteLocalStorageRepository().all();

    for (FavouriteLocal localFavourite in localFavourites) {
      QueryDocumentSnapshot<Object?>? firestoreFavourite = await favouriteFirestoreRepository.find(localFavourite.id);

      if(firestoreFavourite == null){
        continue;
      }

      int firestoreFavouriteUpdatedAt = int.parse(firestoreFavourite["updated_at"].toString());
      int localFavouriteUpdatedAt = localFavourite.updatedAt;

      if(firestoreFavouriteUpdatedAt > localFavouriteUpdatedAt){
        FavouriteLocalStorageRepository().updateDescription(firestoreFavourite["description"], localFavourite.id);
      }
      else{
        FavouriteFirestoreRepository(user).updateDescription(localFavourite.description, localFavourite.id);
      }
    }

  }

  Future<String?> _getLocalFilePathOfTheCloudImage(
    FavouriteFirebase firebaseFavourite,
  ) async {
    String newFilePath = firebaseFavourite.localImagePath;
    bool fileExist = await checkFileAvailable(newFilePath);

    if (fileExist) {
      return newFilePath;
    }

    String? imageURL =
        await GetImageURL(firebaseFavourite.referenceImagePath).action();
    if (imageURL == null) {
      return null;
    }
    newFilePath = await getFilePathWithGeneratedFileName(
      "jpg",
      withUnixTime: true,
    );
    bool result = await DownloadImage().action(newFilePath, imageURL);

    if (!result) {
      return null;
    }
    return newFilePath;
  }
}

import 'dart:convert';

import 'package:casslab/Model/favourite_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_service.dart';

const key = "favourites";

class FavouriteLocalStorageRepository extends LocalStorageService {
  Future<List<FavouriteLocal>> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favourites = prefs.getStringList(key) ?? [];
    List<FavouriteLocal> localFavourites = [];

    for (String rawFavourite in favourites) {
      Map<String, dynamic> map = jsonDecode(rawFavourite);
      FavouriteLocal favouriteLocal = FavouriteLocal.fromJson(map);
      localFavourites.add(favouriteLocal);
    }

    return localFavourites;
  }

  Future<void> add(
    String description,
    String prediction,
    String imagePath,
    int dateTaken,
    String id,
  ) async {
    FavouriteLocal favouriteLocal = FavouriteLocal(
      description,
      prediction,
      imagePath,
      dateTaken,
      id,
    );
    Map<String, dynamic> map = favouriteLocal.toJson();
    String rawJson = jsonEncode(map);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> rawFavourites = prefs.getStringList(key) ?? [];
    rawFavourites.add(rawJson);
    await prefs.setStringList(key, rawFavourites);
  }

  removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, []);
  }

  Future<void> removeSelectedByFavouriteID(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> rawFavourites = prefs.getStringList(key) ?? [];
    List<String> newLocalFavourites = [];

    for (String rawFavourite in rawFavourites) {
      FavouriteLocal favouriteLocal =
          FavouriteLocal.fromJson(jsonDecode(rawFavourite));
      if (favouriteLocal.id != id) {
        newLocalFavourites.add(rawFavourite);
      }
    }
    await prefs.setStringList(key, newLocalFavourites);
  }

  Future<void> updateDescription(String description, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> rawFavourites = prefs.getStringList(key) ?? [];
    List<String> newLocalFavourites = [];

    for (String rawFavourite in rawFavourites) {
      FavouriteLocal favouriteLocal =
          FavouriteLocal.fromJson(jsonDecode(rawFavourite));
      if (favouriteLocal.id == id) {
        favouriteLocal.description = description;
      }

      print(jsonEncode(favouriteLocal.toJson()));

      newLocalFavourites.add(jsonEncode(favouriteLocal.toJson()));
    }

    await prefs.setStringList(key, newLocalFavourites);
  }
}

import 'dart:convert';

import 'package:casslab/Model/favourite_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_service.dart';

const key = "favourites";

class FavouriteService extends LocalStorageService {

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

  add(
    String description,
    String prediction,
    String imagePath,
    int dateTaken,
  ) async {
    FavouriteLocal favouriteLocal = FavouriteLocal(
      description,
      prediction,
      imagePath,
      dateTaken,
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

  Future<void> removeSelectedByDateTaken(int dateTaken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> rawFavourites = prefs.getStringList(key) ?? [];
    List<String> newLocalFavourites = [];

    for (String rawFavourite in rawFavourites) {
      FavouriteLocal favouriteLocal = FavouriteLocal.fromJson(jsonDecode(rawFavourite));
      if (favouriteLocal.dateTaken != dateTaken) {
        newLocalFavourites.add(rawFavourite);
      }
    }
    await prefs.setStringList(key, newLocalFavourites);
  }
}

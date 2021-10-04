import 'package:casslab/Model/favourite.dart';
import 'package:casslab/actions/FirebaseStorage/get_image_url.dart';

class FavouriteFirebase {
  String _description;
  final String _prediction;
  final String _imagePath;
  final String _localImagePath;
  final String _referenceImagePath;
  final String _id;
  final String _userId;
  final int _dateTaken;

  FavouriteFirebase(
    this._description,
    this._prediction,
    this._imagePath,
    this._localImagePath,
    this._referenceImagePath,
    this._id,
    this._userId,
    this._dateTaken,
  );

  String get description => _description;

  String get prediction => _prediction;

  int get dateTaken => _dateTaken;

  String get userId => _userId;

  String get id => _id;

  String get referenceImagePath => _referenceImagePath;

  String get localImagePath => _localImagePath;

  String get imagePath => _imagePath;

  set description(String value) {
    _description = value;
  }

  Future<Favourite> getData() async {
    Favourite favourite =  Favourite(
      _description,
      _prediction,
      _id,
      _dateTaken,
    );
    favourite.urlImagePath = await GetImageURL(_referenceImagePath).action();
    return favourite;
  }
}

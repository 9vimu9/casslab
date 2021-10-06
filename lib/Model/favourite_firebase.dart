import 'package:casslab/Model/favourite.dart';
import 'package:casslab/actions/FirebaseStorage/get_image_url.dart';

class FavouriteFirebase {
  String _description;
  final String _prediction;
  final String _localImagePath;
  final String _referenceImagePath;
  final String _id;
  final String _userId;
  final int _dateTaken;
  final int _updatedAt;

  FavouriteFirebase(
    this._description,
    this._prediction,
    this._localImagePath,
    this._referenceImagePath,
    this._id,
    this._userId,
    this._dateTaken,
    this._updatedAt,
  );

  String get description => _description;

  String get prediction => _prediction;

  int get dateTaken => _dateTaken;

  int get updatedAt => _updatedAt;

  String get userId => _userId;

  String get id => _id;

  String get referenceImagePath => _referenceImagePath;

  String get localImagePath => _localImagePath;


  set description(String value) {
    _description = value;
  }

  Future<Favourite> getData() async {
    String? imagePath = await GetImageURL(_referenceImagePath).action();
    Favourite favourite =  Favourite(
      _description,
      _prediction,
      _id,
      _dateTaken,
      imagePath
    );
    favourite.imageType = ImageTypes.firebaseStorage;
    return favourite;
  }
}

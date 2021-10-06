import 'package:casslab/Model/favourite.dart';

class FavouriteLocal {

  String _description;
  final String _prediction;
  final String _imagePath;
  final String _id;
  final int _dateTaken;
  int _updatedAt;

  String get description => _description;

  String get id => _id;

  String get prediction => _prediction;

  int get dateTaken => _dateTaken;

  int get updatedAt => _updatedAt;

  String get imagePath => _imagePath;

  set description(String value) {
    _description = value;
  }


  set updatedAt(int value) {
    _updatedAt = value;
  }

  FavouriteLocal(
    this._description,
    this._prediction,
    this._imagePath,
    this._dateTaken,
    this._updatedAt,
    this._id,
  );

  FavouriteLocal.fromJson(Map<String, dynamic> json)
      : _description = json['description'],
        _prediction = json['prediction'],
        _imagePath = json['image_path'],
        _dateTaken = json['date_taken'],
        _updatedAt = json['updated_at'],
        _id = json['id'];

  Map<String, dynamic> toJson() {
    return {
      'description': _description,
      'prediction': _prediction,
      'image_path': _imagePath,
      'date_taken': _dateTaken,
      'updated_at': _updatedAt,
      'id': _id,
    };
  }

  Future<Favourite> getData() async {
    Favourite favourite =  Favourite(
      _description,
      _prediction,
      _id,
      _dateTaken,
      _imagePath,
    );
    favourite.imageType = ImageTypes.localStorage;
    return favourite;
  }
}

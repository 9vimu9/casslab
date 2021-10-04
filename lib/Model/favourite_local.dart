import 'package:casslab/Model/favourite.dart';

class FavouriteLocal {
  String _description;

  set description(String value) {
    _description = value;
  }

  final String _prediction;
  final String _imagePath;
  final String _id;
  final int _dateTaken;

  String get description => _description;

  String get id => _id;

  String get prediction => _prediction;

  int get dateTaken => _dateTaken;

  String get imagePath => _imagePath;

  FavouriteLocal(this._description, this._prediction, this._imagePath,
      this._dateTaken, this._id);

  FavouriteLocal.fromJson(Map<String, dynamic> json)
      : _description = json['description'],
        _prediction = json['prediction'],
        _imagePath = json['image_path'],
        _dateTaken = json['date_taken'],
        _id = json['id'];

  Map<String, dynamic> toJson() {
    return {
      'description': _description,
      'prediction': _prediction,
      'image_path': _imagePath,
      'date_taken': _dateTaken,
      'id': _id,
    };
  }

  Future<Favourite> getData() async {
    Favourite favourite =  Favourite(
      _description,
      _prediction,
      _id,
      _dateTaken,
    );
    favourite.localImagePath = _imagePath;
    return favourite;
  }
}

/*
* JSON → object
String rawJson = '{"name":"Mary","age":30}';
Map<String, dynamic> map = jsonDecode(rawJson);
Person person = Person.fromJson(map);
* */

/*
* Object → JSON
Person person = Person('Mary', 30);
Map<String, dynamic> map = person.toJson();
String rawJson = jsonEncode(map);
*
* */

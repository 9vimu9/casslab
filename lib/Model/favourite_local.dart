class FavouriteLocal{

  final String _description;
  final String _prediction;
  final String _imagePath;
  final int _dateTaken;

  int get dateTaken => _dateTaken;

  FavouriteLocal(this._description, this._prediction, this._imagePath, this._dateTaken);

  FavouriteLocal.fromJson(Map<String, dynamic> json)
      : _description = json['prediction'],
        _prediction = json['prediction'],
        _imagePath = json['image_path'],
        _dateTaken = json['date_taken'];

  Map<String, dynamic> toJson() {
    return {
      'description': _description,
      'prediction': _prediction,
      'image_path': _imagePath,
      'date_taken': _dateTaken,
    };
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
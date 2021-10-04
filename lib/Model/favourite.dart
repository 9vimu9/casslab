class Favourite{

  final String _description;
  final String _prediction;
  final String _id;
  final int _dateTaken;

  String get description => _description;
  String? _localImagePath;
  String? _urlImagePath;


  Favourite(this._description, this._prediction, this._id, this._dateTaken);

  String get prediction => _prediction;

  String? get urlImagePath => _urlImagePath;

  String? get localImagePath => _localImagePath;

  int get dateTaken => _dateTaken;

  String get id => _id;

  set urlImagePath(String? value) {
    _urlImagePath = value;
  }

  set localImagePath(String? value) {
    _localImagePath = value;
  }
}
enum ImageTypes {
  localStorage,
  firebaseStorage,
}

class Favourite {
  final String _description;
  final String _prediction;
  final String _id;
  final int _dateTaken;
  final String? _imagePath;
  ImageTypes? _imageType;

  ImageTypes? get imageType => _imageType;

  String? get imagePath => _imagePath;

  String get description => _description;

  String get prediction => _prediction;

  int get dateTaken => _dateTaken;

  String get id => _id;

  set imageType(ImageTypes? value) {
    _imageType = value;
  }

  Favourite(
    this._description,
    this._prediction,
    this._id,
    this._dateTaken,
    this._imagePath,
  );
}
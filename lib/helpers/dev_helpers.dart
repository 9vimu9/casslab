import 'package:shared_preferences/shared_preferences.dart';

void logError(String code, String? message) {
  if (message != null) {
    print('Error: $code\nError Message: $message');
  } else {
    print('Error: $code');
  }
}

Future<void> logAllLocalFavourites() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favourites = prefs.getStringList("favourites") ?? [];

  print("*******************LOCAL FAVOURITE START******************");
  for (String rawFavourite in favourites) {
    print(rawFavourite);
  }
  print("*******************LOCAL FAVOURITE END******************");

}
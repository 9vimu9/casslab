import 'package:casslab/actions/Syncing/sync_favourites.dart';
import 'package:casslab/screens/Welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helpers/dev_helpers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  logAllLocalFavourites();
  await SyncFavourites().startSyncing();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      title: 'CassLab',
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:casslab/Model/favourite.dart';
import 'package:casslab/actions/Favourites/favourites_repository.dart';
import 'package:casslab/screens/Favourites/components/body.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatelessWidget {

  FavouritesScreen({Key? key}) : super(key: key);

  Future<List<Favourite>> favourites = FavouritesRepository().all();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: favourites,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Favourite> favourites = snapshot.data ?? [];
            return Body(favourites);
          },
        ),
      ),
    );
  }
}

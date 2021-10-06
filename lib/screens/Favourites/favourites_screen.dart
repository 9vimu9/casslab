import 'package:casslab/Model/favourite.dart';
import 'package:casslab/actions/Favourites/favourites_repository.dart';
import 'package:casslab/screens/Favourites/components/body.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatelessWidget {

  List<Favourite> favourites;
  FavouritesScreen(this.favourites,{Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Body(favourites),
      ),
    );
  }
}

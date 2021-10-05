import 'package:casslab/Model/favourite.dart';
import 'package:casslab/screens/Favourites/components/background.dart';
import 'package:casslab/screens/Favourites/components/favourite_detail.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  List<Favourite> favourites;

  Body(
    this.favourites, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Container(
        padding: const EdgeInsets.only(top: 40),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return FavouriteDetail(favourites[index]);
          },
          itemCount: favourites.length,
        ),
      ), // removing background
    );
  }
}

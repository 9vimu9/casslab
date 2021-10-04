import 'package:casslab/screens/Favourites/components/background.dart';
import 'package:casslab/screens/Favourites/components/favourite_detail.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Container(
        padding: const EdgeInsets.only(top: 40),
        child: ListView(
          children: [
            FavouriteDetail(),
            FavouriteDetail(),
            FavouriteDetail(),
            FavouriteDetail(),
          ],
        ),
      ), // removing background
    );
  }
}

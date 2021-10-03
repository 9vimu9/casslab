import 'package:casslab/screens/Favourites/components/body.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatelessWidget {

  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SafeArea(child:Body()) ,
    );
  }
}


import 'package:casslab/screens/Favourites/components/background.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Container(),
      ),
    );
  }

}

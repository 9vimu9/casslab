import 'dart:io';

import 'package:casslab/Model/favourite.dart';
import 'package:casslab/actions/Favourites/favourites_repository.dart';
import 'package:casslab/constants.dart';
import 'package:flutter/material.dart';

class FavouriteDetail extends StatefulWidget {
  Favourite favourite;

  FavouriteDetail(this.favourite, {Key? key}) : super(key: key);

  @override
  _FavouriteDetailState createState() => _FavouriteDetailState(favourite);
}

class _FavouriteDetailState extends State<FavouriteDetail> {
  Size? size;
  Favourite favourite;

  _FavouriteDetailState(this.favourite);

  late String _description;
  late String _prediction;
  late String _id;
  late String _dateTaken;

  @override
  void initState() {
    _description = favourite.description;
    _prediction = favourite.prediction;
    _id = favourite.id;
    _dateTaken =
        DateTime.fromMillisecondsSinceEpoch(favourite.dateTaken).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return predictionWidget();
  }

  Widget predictionWidget() {
    double height = size!.height;

    return Column(
      children: [
        SizedBox(child: imagePreview(), height: height * 0.65),
        SizedBox(child: dateTakenBar(), height: height * 0.04),
        SizedBox(child: predictionLabelBar(), height: height * 0.06),
        descriptionBar(),
      ],
    );
  }

  Widget descriptionBar() {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: size!.width * 0.05),
          SizedBox(
            width: size!.width * 0.8,
            child: Container(
                child: Text(
              _description,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            )),
          ),
          SizedBox(
            width: size!.width * 0.05,
          ),
        ],
      ),
      padding: const EdgeInsets.only(bottom: 80),
    );
  }

  Widget dateTakenBar() {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: size!.width * 0.05),
          SizedBox(
            width: size!.width * 0.9,
            child: Text(
              'Date Taken: $_dateTaken',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            width: size!.width * 0.05,
          ),
        ],
      ),
      padding: EdgeInsets.zero,
    );
  }

  Widget imagePreview() {
    return Container(
      child: OverflowBox(
          minWidth: 0.0,
          minHeight: 0.0,
          maxWidth: double.infinity,
          child: _getImagePreview()),
    );
  }

  Widget predictionLabelBar() {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: size!.width * 0.05),
          SizedBox(
            width: size!.width * 0.6,
            child: Text(
              _prediction,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: size!.width * 0.15),
          SizedBox(
              width: size!.width * 0.1,
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  size: 36,
                  color: kPrimaryColor,
                ),
                onPressed: () async {
                  var result = showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Removing from favourites'),
                      content: const Text(
                          'Do you really want to this remove from favourites ?'),
                      elevation: 24,
                      actions: <Widget>[
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context, favouritesDoNotRemove),
                          child: const Text('No, Keep it'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await FavouritesRepository()
                                .removeSelectedByFavouriteID(_id);
                            Navigator.pop(context, favouritesRemove);
                          },
                          child: const Text('Yes, Remove it'),
                        ),
                      ],
                    ),
                  );
                  result.then((userDecision) async {
                    if (userDecision == favouritesRemove) {}
                  });
                },
              )),
          SizedBox(width: size!.width * 0.05),
        ],
      ),
      padding: EdgeInsets.only(top: 0),
    );
  }

  Image _getImagePreview() {
    if (favourite.imageType == ImageTypes.localStorage) {
      return Image.file(
        //to do set default image if image not available
        File(favourite.imagePath!),
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        favourite.imagePath!,
        fit: BoxFit.cover,
      );
    }
  }
}

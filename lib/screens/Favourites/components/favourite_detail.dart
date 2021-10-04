import 'dart:io';

import 'package:casslab/constants.dart';
import 'package:flutter/material.dart';

class FavouriteDetail extends StatefulWidget {
  @override
  _FavouriteDetailState createState() => _FavouriteDetailState();
}

class _FavouriteDetailState extends State<FavouriteDetail> {
  Size? size;

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
              'description here description here description heredescription heredescription heredescription here description here description here description heredescription heredescription heredescription here',
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
      padding: const EdgeInsets.only(bottom: 50),
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
              'Date Taken: 2021-12-13 08:51:23 am',
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
          child: Image.file(
            File(
                "/data/user/0/com.casslab.casslab/app_flutterGRbLkYhFc-3wjQ==_1633290027119.jpg"),
            fit: BoxFit.cover,
          )),
    );
  }

  Widget predictionLabelBar() {
    return Container(child: Row(
      children: <Widget>[
        SizedBox(width: size!.width * 0.05),
        SizedBox(
          width: size!.width * 0.6,
          child: Text(
            "prediction",
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Colors.black, fontSize: 35, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(width: size!.width * 0.15),
        SizedBox(
            width: size!.width * 0.1,
            child: IconButton(
              icon: const Icon(Icons.favorite_outlined,
                  size: 36, color: kPrimaryColor),
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
                        onPressed: () =>
                            Navigator.pop(context, favouritesRemove),
                        child: const Text('Yes, Remove it'),
                      ),
                    ],
                  ),
                );
                result.then((userDecision) async {
                  if (userDecision == favouritesRemove) {
                    // await FavouriteService().removeSelectedByDateTaken(_dateTaken!);
                  }
                });
              },
            )),
        SizedBox(width: size!.width * 0.05),
      ],
    ),padding: EdgeInsets.only(top: 0),);
  }
}

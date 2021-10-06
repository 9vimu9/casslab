import 'dart:io';

import 'package:casslab/Model/favourite.dart';
import 'package:casslab/actions/Favourites/favourites_repository.dart';
import 'package:casslab/classifiers/classifier.dart';
import 'package:casslab/components/add_to_favorites_dialog.dart';
import 'package:casslab/components/loader.dart';
import 'package:casslab/components/rounded_button.dart';
import 'package:casslab/components/top_button_bar.dart';
import 'package:casslab/constants.dart';
import 'package:casslab/helpers/helpers.dart';
import 'package:casslab/screens/Favourites/favourites_screen.dart';
// import 'package:casslab/screens/Prediction/components/background.dart'; // removing background
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  Classifier classifier;

  Body(this.classifier);

  @override
  _BodyState createState() => _BodyState(classifier);
}

class _BodyState extends State<Body> {
  bool _noImageSelected = true;
  int? _dateTaken;
  bool _addedToFavourite = false;
  File? _image;
  late String _description;
  late String _favouriteID;
  late String _output;
  final picker = ImagePicker();
  Classifier classifier;
  late Size size;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  _BodyState(this.classifier);

  @override
  void initState() {
    super.initState();
    classifier.loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    classifier.closeModel();
  }

  classifyImage(File? image) async {

  }

  getImageFrom(ImageSource imageSource) async {
    Loader().showLoader(context);
    XFile? image = await picker.pickImage(source: imageSource);
    if (image == null) {
      Navigator.pop(context);
      return;
    }
    String newFilePath = await getFilePathWithGeneratedFileName(
      "jpg",
      withUnixTime: true,
    );
    print("***************** file path ********************");
    print(newFilePath);

    File savedImage = await File(image.path).copy(newFilePath);
    String output = await classifier.classifyImage(savedImage);
    Navigator.pop(context);
    setState(() {
      _image = savedImage;
      _output = output;
      _noImageSelected = false;
      _description = "";
      _addedToFavourite = false;
      _dateTaken = getUnixTimeStampInMillis();
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // return Background(//removing background
    //   child: Column(//removing background
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: TopButtonBar(),
          flex: 1,
        ),
        Flexible(
          child: predictionWidget(),
          flex: 8,
        ),
        Flexible(
          child: actionButtonsBar(),
          flex: 3,
        ),
      ],

      // ),// removing background
    );
  }

  Widget actionButtonsBar() {
    return Container(
      child: Column(
        children: [
          Row(children: <Widget>[
            SizedBox(width: size.width * 0.1),
            SizedBox(
                width: size.width * 0.2,
                child: ElevatedButton(
                  onPressed:()=> getImageFrom(ImageSource.camera),
                  child: const Icon(Icons.camera_alt, size: 35),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    backgroundColor: MaterialStateProperty.all(
                        kPrimaryLightColor), // <-- Button color
                    overlayColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed))
                        return kPrimaryCancelColor; // <-- Splash color
                    }),
                  ),
                )),
            SizedBox(width: size.width * 0.1),
            SizedBox(
                width: size.width * 0.5,
                child: RoundedButton(
                  text: "Pick From Gallery",
                  color: kPrimaryLightColor,
                  textColor: Colors.black,
                  press:()=> getImageFrom(ImageSource.gallery),
                  width: size.width * 0.5,
                )),
            SizedBox(width: size.width * 0.1),
          ]),
          RoundedButton(
            text: "My Favourites",
            color: kPrimaryLightColor,
            textColor: Colors.black,
            press: () async {

              Loader().showLoader(context);
              List<Favourite> favourites = await FavouritesRepository().all();
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FavouritesScreen(favourites);
                  },
                ),
              );
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      padding: const EdgeInsets.only(top: 10),
    );
  }

  Widget predictionWidget() {
    //show nothing if no picture selected
    if (_noImageSelected || _image == null) {
      return Center(
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Tap ",style: TextStyle(color: Colors.black,fontSize: 20),
              ),
              WidgetSpan(
                child: Icon(Icons.camera_alt_sharp, size: 20),
              ),
              TextSpan(
                text: " or 'Pick From Gallery' ",style: TextStyle(color: Colors.black,fontSize: 20),
              ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: Column(
        children: [
          descriptionBar(),
          Flexible(child: imagePreview(), flex: 12),
          Flexible(child: predictionLabelBar(), flex: 1),
        ],
      ),
    );
  }

  Widget descriptionBar() {
    return _addedToFavourite
        ? Container(
            child: Row(
              children: <Widget>[
                SizedBox(width: size.width * 0.05),
                SizedBox(
                  width: size.width * 0.8,
                  child: Container(
                      child: Text(
                    '${_description}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  )),
                ),
                SizedBox(
                  width: size.width * 0.1,
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: kPrimaryColor),
                    onPressed: () {
                      AddToFavoritesDialog(
                        _description,
                        context,
                        _formKey,
                        onUpdateFavourite,
                        onCancelFavouriteDialog,
                      ).displayAddToFavoritesDialog();
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * 0.05,
                ),
              ],
            ),
            padding: const EdgeInsets.only(bottom: 5),
          )
        : Container();
  }

  Widget imagePreview() {
    return Container(
      child: OverflowBox(
          minWidth: 0.0,
          minHeight: 0.0,
          maxWidth: double.infinity,
          child: Image.file(
            _image!,
            fit: BoxFit.cover,
          )),
    );
  }

  Widget predictionLabelBar() {
    return Row(children: <Widget>[
      SizedBox(width: size.width * 0.1),
      SizedBox(
        width: size.width * 0.6,
        child: Text(
          _output,
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Colors.black, fontSize: 35, fontWeight: FontWeight.w600),
        ),
      ),
      SizedBox(width: size.width * 0.1),
      SizedBox(
          width: size.width * 0.1,
          child: IconButton(
            icon: Icon(
                _addedToFavourite
                    ? Icons.favorite_outlined
                    : Icons.favorite_border,
                size: 36,
                color: kPrimaryColor),
            onPressed: () async {
              if (_addedToFavourite) {
                // remove from favourite list
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
                          Loader().showLoader(context);
                          await FavouritesRepository().removeSelectedByFavouriteID(_favouriteID);
                          Navigator.pop(context);
                          Navigator.pop(context, favouritesRemove);
                        },
                        child: const Text('Yes, Remove it'),
                      ),
                    ],
                  ),
                );
                result.then((userDecision) {
                  if (userDecision == favouritesRemove) {
                    setState(() {
                      _addedToFavourite = false;
                    });
                  }
                });
              } else {
                AddToFavoritesDialog(
                  _description,
                  context,
                  _formKey,
                  onSaveFavourite,
                  onCancelFavouriteDialog,
                ).displayAddToFavoritesDialog();
              }
            },
          )),
      SizedBox(width: size.width * 0.1),
    ]);
  }

  Future<void> onSaveFavourite() async {
    final dataFields = _formKey.currentState!.fields;
    var description = dataFields[favouritesDescriptionFieldName]!.value;
    description  = description ?? "";

    Loader().showLoader(context);
    String favouriteID = await FavouritesRepository().add(description, _output, _image!.path, _dateTaken!);
    Navigator.pop(context);
    setState(() {
      _description = description;
      _favouriteID = favouriteID;
      _addedToFavourite = true;
      Navigator.pop(context);
    });
  }


  Future<void> onUpdateFavourite() async {

    var description = _formKey.currentState!.fields[favouritesDescriptionFieldName]!.value;
    description  = description ?? "";

    Loader().showLoader(context);
    await FavouritesRepository().updateDescription(description, _favouriteID);
    Navigator.pop(context);
    setState(() {
      _description = description;
      Navigator.pop(context);
    });
  }

  void onCancelFavouriteDialog() {
    setState(() {
      Navigator.pop(context);
    });
  }
}

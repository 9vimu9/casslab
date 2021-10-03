import 'dart:io';

import 'package:casslab/classifiers/classifier.dart';
import 'package:casslab/components/add_to_favorites_dialog.dart';
import 'package:casslab/components/rounded_button.dart';
import 'package:casslab/components/top_button_bar.dart';
import 'package:casslab/constants.dart';
import 'package:casslab/helpers/helpers.dart';
import 'package:casslab/screens/List/list_screen.dart';

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
  bool _addedToFavourite = false;
  File? _image;
  String? _description;
  late List _output;
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
    List output = await classifier.classifyImage(image);
    //[{confidence: 0.8950297236442566, index: 2, label: Green Mite}]
    setState(() {
      _output = output;
      _noImageSelected = false;
      _description = "";
      _addedToFavourite = false;
    });
  }

  pickImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    String newFilePath = await getFilePathWithGeneratedFileName(
      "jpg",
      withUnixTime: true,
    );
    print("***************** file path ********************");
    print(newFilePath);
    File(image.path).copy(newFilePath).then((savedImage) {
      setState(() {
        _image = savedImage;
      });
      classifyImage(_image);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // return Background(//removing background
    //   child: Column(//removing background
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TopButtonBar(),
        predictionWidget(),
        actionButtonsBar(),
      ],

      // ),// removing background
    );
  }

  Widget actionButtonsBar() {
    return Column(
      children: [
        Row(children: <Widget>[
          SizedBox(width: size.width * 0.1),
          SizedBox(
              width: size.width * 0.2,
              child: ElevatedButton(
                onPressed: pickImage,
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
                press: pickGalleryImage,
                width: size.width * 0.5,
              )),
          SizedBox(width: size.width * 0.1),
        ]),
        RoundedButton(
          text: "My Predictions",
          color: kPrimaryLightColor,
          textColor: Colors.black,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ListScreen();
                },
              ),
            );
          },
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget predictionWidget() {
    //show nothing if no picture selected
    if (_noImageSelected || _image == null) {
      return Container(
        height: size.height * 0.65,
      );
    }

    return Center(
      child: Column(
        children: [
          descriptionBar(),
          imagePreview(),
          predictionLabelBar(),
        ],
      ),
    );
  }

  Widget descriptionBar() {
    return _addedToFavourite
        ? Row(
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
                      fontWeight: FontWeight.w600),
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
                      onSaveFavourite,
                      onCancelFavouriteDialog,
                    ).displayAddToFavoritesDialog();
                  },
                ),
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
            ],
          )
        : Container();
  }

  Widget imagePreview() {
    return Container(
      height: size.height * 0.55,
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
          '${_output[0]['label']}',
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
            onPressed: () {
              if (_addedToFavourite) {
                // remove from favourite list
                // ask question before do that

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

  void onSaveFavourite() {
    final dataFields = _formKey.currentState!.fields;
    final description = dataFields[favouritesDescriptionFieldName]!.value;
    print(description);
    //added to local storage and firebase here
    setState(() {
      _description = description;
      _addedToFavourite = true;
      Navigator.pop(context);
    });
  }

  void onCancelFavouriteDialog() {
    setState(() {
      Navigator.pop(context);
    });
  }
}

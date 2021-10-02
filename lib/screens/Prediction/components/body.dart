import 'dart:io';

import 'package:casslab/classifiers/classifier.dart';
import 'package:casslab/components/rounded_button.dart';
import 'package:casslab/constants.dart';
import 'package:casslab/helpers/helpers.dart';
import 'package:casslab/screens/List/list_screen.dart';
import 'package:casslab/screens/Prediction/components/background.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Body extends StatefulWidget {
  Classifier classifier;

  Body(this.classifier);

  @override
  _BodyState createState() => _BodyState(classifier);
}

class _BodyState extends State<Body> {
  bool _noImageSelected = true;
  File? _image;
  late List _output;
  final picker = ImagePicker();
  Classifier classifier;
  late Size size;

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
    });
  }

  pickImage() async {

    XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    String newFilePath = await getFilePathWithGeneratedFileName("jpg",withUnixTime: true) ;
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

  showPreviousPredictionsPage() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(height: size.height * 0.05),
            imagePreviewWidget(),
            RoundedButton(text: "Take A Photo", press: pickImage),
            RoundedButton(
              text: "Pick From Gallery",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: pickGalleryImage,
            ),
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
        ),
      ),
    );
  }

  Widget imagePreviewWidget() {
    //show nothing if no picture selected
    if (_noImageSelected || _image==null) {
      return Container();
    }

    return Center(
      child: Column(
        children: [
          Container(
            height: size.height * 0.4,
            child: OverflowBox(
                minWidth: 0.0,
                minHeight: 0.0,
                maxWidth: double.infinity,
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${_output[0]['label']}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }


}

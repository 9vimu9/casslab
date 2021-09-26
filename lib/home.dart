import 'dart:io';

import 'package:casslab/classifiers/classifier.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  Classifier classifier;

  Home(this.classifier);

  @override
  _HomeState createState() => _HomeState(classifier);
}

class _HomeState extends State<Home> {
  bool _noImageSelected = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();
  Classifier classifier;

  _HomeState(this.classifier);

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

  classifyImage(File image) async {
    List output = await classifier.classifyImage(image);
    setState(() {
      _output = output;
      _noImageSelected = false;
    });
  }

  pickImage() async {
    //this function to grab the image from camera
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white54),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loginRegisterButtonWidget(),
                Spacer(),
                imagePreviewWidget(),
                mainButtonsWidget(),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePreviewWidget() {
    //show nothing if no picture selected
    if (_noImageSelected) {
      return Container();
    }

    return Center(
      child: Column(
        children: [
          Container(
            height: 250,
            width: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.file(
                _image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 30,
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

  Widget mainButtonsWidget() {
    return Container(
      child: Column(
        children: [
          buttonWidget('Take A Photo', pickImage),
          SizedBox(
            height: 30,
          ),
          buttonWidget('Pick From Gallery', pickGalleryImage),
          SizedBox(
            height: 30,
          ),
          buttonWidget('My Predictions', showPreviousPredictionsPage),
        ],
      ),
    );
  }

  Widget buttonWidget(
      String buttonText, GestureTapCallback? gestureTapCallback) {
    return GestureDetector(
      onTap: gestureTapCallback,
      child: Container(
        width: MediaQuery.of(context).size.width - 200,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
        decoration: BoxDecoration(
            color: Color(0xFF225340), borderRadius: BorderRadius.circular(15)),
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget loginRegisterButtonWidget() {
    return Container(
      child: Container(
        child: Row(
          children: [
            Visibility(
              child: TextButton(
                onPressed: () => {},
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.account_circle_outlined,
                        size: 25, color: Colors.black),
                    Text(" Log in/Register",
                        style: TextStyle(fontSize: 25, color: Colors.black))
                  ],
                ),
              ),
              visible: false,
            ),
            Visibility(
                child: TextButton(
                  onPressed: () => {},
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.save, size: 25),
                      Text(" Save", style: TextStyle(fontSize: 25))
                    ],
                  ),
                ),
                visible: true),
            Spacer(),
            Visibility(
              child: TextButton(
                onPressed: () => {},
                child: Row(
                  children: const <Widget>[
                    Text(" Log out", style: TextStyle(fontSize: 25)),
                    Icon(Icons.exit_to_app_outlined, size: 25)
                  ],
                ),
              ),
              visible: true,
            ),
          ],
        ),
        alignment: Alignment.topLeft,
      ),
    );
  }
}

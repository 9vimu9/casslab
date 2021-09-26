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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black.withOpacity(0.9),
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 50),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Color(0xFF2A363B),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imagePreviewWidget(),
              mainButtonsWidget(),
            ],
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
          Divider(height: 25, thickness: 1),
          Text(
            '${_output[0]['label']}!',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Divider(height: 25, thickness: 1),
        ],
      ),
    );
  }

  Widget mainButtonsWidget() {
    return Container(
      child: Column(
        children: [
          buttonWidget('Take As Photo',pickImage),
          SizedBox(
            height: 30,
          ),
          buttonWidget( 'Pick Froms Gallery',pickGalleryImage),
        ],
      ),
    );
  }

  Widget buttonWidget(String buttonText,GestureTapCallback? gestureTapCallback){
    return           GestureDetector(
      onTap: gestureTapCallback,
      child: Container(
        width: MediaQuery.of(context).size.width - 200,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
        decoration: BoxDecoration(
            color: Colors.blueGrey[600],
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

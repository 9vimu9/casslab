import 'package:casslab/components/rounded_button.dart';
import 'package:casslab/components/rounded_input_field.dart';
import 'package:casslab/components/rounded_multiline_input_field.dart';
import 'package:casslab/constants.dart';
import 'package:casslab/screens/Save/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Center(
              child: Column(
                children: [
                  // Container(
                  //   height: size.height * 0.4,
                  //   child: FittedBox(
                  //     alignment: Alignment.bottomCenter,
                  //     fit: BoxFit.fitWidth,
                  //     // child: ClipRRect(child: Image.file(_image)),
                  //     child: SvgPicture.asset(
                  //       "assets/icons/login.svg",
                  //       height: size.height * 0.35,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'prediction here',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedMultilineInputField(
              minLines: 5,
              hintText: "Description",
              onChanged: (value) {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                RoundedButton(
                  color: kPrimaryCancelColor,
                  width: size.width * 0.35,
                  text: "Cancel",
                  press: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                RoundedButton(
                  color: kPrimaryColor,
                  width: size.width * 0.35,
                  text: "Save",
                  press: () {},
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}

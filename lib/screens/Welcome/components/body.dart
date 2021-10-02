import 'package:casslab/actions/Authentication/login_firebase.dart';
import 'package:casslab/components/rounded_button.dart';
import 'package:casslab/constants.dart';
import 'package:casslab/screens/Login/login_screen.dart';
import 'package:casslab/screens/Prediction/prediction_screen.dart';
import 'package:casslab/screens/Welcome/components/background.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/icons/chat.png",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "PREDICT NOW !",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PredictionScreen();
                    },
                  ),
                );
              },
            ),
            loginButtonWidget()
          ],
        ),
      ),
    );
  }
  final Future<dynamic> user = LoginFirebase().checkUserIsLoggedIn().first;

  Widget loginButtonWidget(){

     return FutureBuilder(
      future: user,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        bool _userLoggedIn = !(snapshot.data == null);
        return Visibility(
          child: RoundedButton(
            text: "LOGIN/REGISTER",
            color: kPrimaryLightColor,
            textColor: Colors.black,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
          visible: !_userLoggedIn,
        );
      },
    );


  }
}

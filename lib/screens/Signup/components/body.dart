import 'package:flutter/material.dart';
import 'package:casslab/screens/Login/login_screen.dart';
import 'package:casslab/screens/Signup/components/background.dart';
import 'package:casslab/screens/Signup/components/or_divider.dart';
import 'package:casslab/screens/Signup/components/social_icon.dart';
import 'package:casslab/components/already_have_an_account_acheck.dart';
import 'package:casslab/components/rounded_button.dart';
import 'package:casslab/components/rounded_input_field.dart';
import 'package:casslab/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              name: "email_field",
              validator: (value) {
                return null;
              },
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              name: "password_field",
              onChanged: (value) {},
              validator: (String? value) {  },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
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
          ],
        ),
      ),
    );
  }
}

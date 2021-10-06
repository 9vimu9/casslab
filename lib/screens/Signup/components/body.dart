import 'package:casslab/actions/Authentication/login_firebase.dart';
import 'package:casslab/actions/Authentication/signup_firebase.dart';
import 'package:casslab/helpers/helpers.dart';
import 'package:casslab/screens/Prediction/prediction_screen.dart';
import 'package:flutter/material.dart';
import 'package:casslab/screens/Login/login_screen.dart';
import 'package:casslab/screens/Signup/components/background.dart';
import 'package:casslab/components/already_have_an_account_acheck.dart';
import 'package:casslab/components/rounded_button.dart';
import 'package:casslab/components/rounded_input_field.dart';
import 'package:casslab/components/rounded_password_field.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  BodyState createState() {
    return BodyState();
  }
}
class BodyState extends State<Body> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FormBuilder(child: Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/icons/signup.png",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              name: "email_field",
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.email(context),
                FormBuilderValidators.required(context),
              ]),
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              name: "password_field",
              onChanged: (value) {},
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.minLength(context,6),
                FormBuilderValidators.maxLength(context,12),
                FormBuilderValidators.required(context),
              ]),
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                final validationResult = _formKey.currentState!.validate();

                if (validationResult) {
                  final dataFields = _formKey.currentState!.fields;
                  final email = dataFields["email_field"]!.value;
                  final password = dataFields["password_field"]!.value;
                  final bool result = await SignupFirebase()
                      .registerNewUser(email, password);

                  if (result) {
                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => PredictionScreen(),
                      ),
                          (route) => false,
                      //if you want to disable back feature set to false
                    );
                  }

                }
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
    ),
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

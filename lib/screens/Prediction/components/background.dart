import 'package:casslab/actions/Authentication/login_firebase.dart';
import 'package:casslab/screens/Login/login_screen.dart';
import 'package:casslab/screens/Save/save_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../prediction_screen.dart';

class Background extends StatelessWidget {
  final Widget child;

  Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          loginRegisterButtonWidget(context),
          child,
        ],
      ),
    );
  }

  final Future<User?> user = LoginFirebase().checkUserIsLoggedIn().first;

  Widget loginRegisterButtonWidget(BuildContext context) {
    return FutureBuilder(
      future: user,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        bool _userLoggedIn = !(snapshot.data == null);
        return Container(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Visibility(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SaveScreen();
                        },
                      ),
                    );
                  },
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.save, size: 20, color: Colors.black),
                      Text(" Save",
                          style: TextStyle(fontSize: 20, color: Colors.black))
                    ],
                  ),
                ),
                visible: _userLoggedIn,
              ),
              Spacer(),
              Visibility(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.account_circle_outlined,
                          size: 20, color: Colors.black),
                      Text(" Log in/Register",
                          style: TextStyle(fontSize: 20, color: Colors.black))
                    ],
                  ),
                ),
                visible: !_userLoggedIn,
              ), //login
              Visibility(
                child: TextButton(
                  onPressed: () {
                    LoginFirebase().signUserOut();
                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => PredictionScreen(),
                      ),
                      (route) =>
                          false, //if you want to disable back feature set to false
                    );
                  },
                  child: Row(
                    children: const <Widget>[
                      Text(" Log out",
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      Icon(Icons.exit_to_app_outlined,
                          size: 20, color: Colors.black)
                    ],
                  ),
                ),
                visible: _userLoggedIn,
              ), //logout
            ],
          ),
          alignment: Alignment.topLeft,
        );
      },
    );
  }
}

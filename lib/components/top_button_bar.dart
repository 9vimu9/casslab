import 'package:casslab/actions/Authentication/login_firebase.dart';
import 'package:casslab/screens/Login/login_screen.dart';
import 'package:casslab/screens/Save/save_screen.dart';
import 'package:casslab/screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

class TopButtonBar extends StatelessWidget {
  TopButtonBar({
    Key? key,
  }) : super(key: key);

  final Future<dynamic?> user = LoginFirebase().checkUserIsLoggedIn().first;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        bool _userLoggedIn = !(snapshot.data == null);
        return Container(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/casslab_min_space.png",
                height: 30,
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
                    LoginFirebase().signUserOut().then((value) {
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => WelcomeScreen(),
                        ),
                        (route) =>
                            false, //if you want to disable back feature set to false
                      );
                    });
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

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
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
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/signup_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.25,
            ),
          ),
          loginRegisterButtonWidget(),
          child,
        ],
      ),
    );
  }

  Widget loginRegisterButtonWidget() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Visibility(
            child: TextButton(
              onPressed: () => {},
              child: Row(
                children: const <Widget>[
                  Icon(Icons.account_circle_outlined,
                      size: 20, color: Colors.black),
                  Text(" Log in/Register",
                      style: TextStyle(fontSize: 20, color: Colors.black))
                ],
              ),
            ),
            visible: true,
          ),
          Visibility(
              child: TextButton(
                onPressed: () => {},
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.save, size: 20, color: Colors.black),
                    Text(" Save",
                        style: TextStyle(fontSize: 20,color: Colors.black))
                  ],
                ),
              ),
              visible: false),
          Spacer(),
          Visibility(
            child: TextButton(
              onPressed: () => {},
              child: Row(
                children: const <Widget>[
                  Text(" Log out",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  Icon(Icons.exit_to_app_outlined,
                      size: 20, color: Colors.black)
                ],
              ),
            ),
            visible: true,
          ),
        ],
      ),
      alignment: Alignment.topLeft,
    );
  }
}

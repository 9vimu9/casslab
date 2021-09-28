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
          loginRegisterButtonWidget(context),
          child,
        ],
      ),
    );
  }

  Widget loginRegisterButtonWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                children: const <Widget>[
                  Icon(Icons.arrow_back_outlined,size: 20, color: Colors.black),
                  // Text(" Back",style: TextStyle(fontSize: 20, color: Colors.black)),
                ],
              ),
            ),
            visible: true,
          ), //back
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
          ), //logout
        ],
      ),
      alignment: Alignment.topLeft,
    );
  }
}

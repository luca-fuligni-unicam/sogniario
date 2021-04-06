import 'package:flutter/material.dart';


// ignore: must_be_immutable
class SogniarioButton extends StatelessWidget {

  Function onPressed;
  Widget child;
  int gender;
  int verified;
  Color background;
  Color overlay;

  SogniarioButton({
    this.onPressed,
    this.child,
    this.gender = 0,
    this.verified = 0,
    this.background,
    this.overlay
  });


  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: child,
        style: ButtonStyle(
            side: MaterialStateProperty.all(
                BorderSide(color: Colors.black54)
            ),

            foregroundColor: MaterialStateProperty.all(Colors.black),
            backgroundColor: MaterialStateProperty.all(
                gender == verified ? background : Colors.transparent
            ),
            overlayColor: MaterialStateProperty.all(
                overlay
            ),
            textStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 18)
            )
        )
    );
  }

}

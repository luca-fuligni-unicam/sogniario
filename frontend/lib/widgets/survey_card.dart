import 'package:flutter/material.dart';


// ignore: must_be_immutable
class NoSurvey extends StatelessWidget {

  Widget child;

  NoSurvey({
    @required this.child
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Container(
        color: Colors.white,
        width: 300,
        height: 200,
        child: child,
      ),
    );
  }
}

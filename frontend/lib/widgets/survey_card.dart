import 'package:flutter/material.dart';


// ignore: must_be_immutable
class NoSurvey extends StatelessWidget {

  Widget child;

  NoSurvey({
    @required this.child
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30)
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: Colors.blue.shade200,
            width: 1.5,
          ),
        ),
        child: Center(
            child: child
        ),
      ),
    );
  }

}

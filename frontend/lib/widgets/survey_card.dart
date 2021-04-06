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
          color: Colors.blue.shade100.withOpacity(0.8),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)
          )
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)
          ),
          side: BorderSide(
            color: Colors.blue.shade200.withOpacity(0.8),
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

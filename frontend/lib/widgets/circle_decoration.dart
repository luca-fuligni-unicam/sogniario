import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CircleDecoration extends StatelessWidget {

  double height;
  double width;
  Offset offset;
  Color shadow, gradientOne, gradientTwo;

  CircleDecoration({
    this.height = 200,
    this.width = 300,
    this.offset = const Offset(5, 5),
    this.shadow,
    this.gradientOne,
    this.gradientTwo,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              colors: [gradientOne, gradientTwo]
          ),
          boxShadow: [
            BoxShadow(
                color: shadow,
                offset: offset,
                blurRadius: 10
            )
          ]),
    );
  }
}

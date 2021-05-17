import 'package:flutter/material.dart';


class MenuBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            child: Text(
                "Sogniario",
                style: TextStyle(
                    color: Colors.black87, // textPrimary,
                    fontSize: 30,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w400
                )
            ),
          ),

          Container(
              height: 2,
              margin: EdgeInsets.only(bottom: 24),
              color: Colors.black54
          ),
        ]);
  }
}

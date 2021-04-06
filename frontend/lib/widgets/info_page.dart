import 'package:flutter/material.dart';
import 'package:frontend/widgets/circle_decoration.dart';


// ignore: must_be_immutable
class InfoPage extends StatelessWidget {

  String title;
  String content;

  InfoPage({
    this.title,
    this.content
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
              children: [

                title == 'App Info' ? Positioned(
                  top: -20,
                  left: -100,
                  child: CircleDecoration(
                    height: 400,
                    width: 400,
                    offset: Offset(2, 2),
                    shadow: Colors.teal.shade300,
                    gradientOne: Colors.teal.shade50,
                    gradientTwo: Colors.teal.shade100,
                  ),
                ) : Positioned(
                  top: 50,
                  right: -100,
                  child: CircleDecoration(
                    height: 400,
                    width: 400,
                    offset: Offset(2, 2),
                    shadow: Colors.teal.shade300,
                    gradientOne: Colors.teal.shade50,
                    gradientTwo: Colors.teal.shade100,
                  ),
                ),

                ListView(
                  padding: EdgeInsets.all(10),
                  physics: BouncingScrollPhysics(),
                  children: [

                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.chevron_left),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.black87.withOpacity(0.8),
                        iconSize: 30,
                      ),
                    ),

                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87.withOpacity(0.8)
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      content,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w400
                      ),
                    )
                  ]),

              ]),
        ),
      ),
    );
  }
}

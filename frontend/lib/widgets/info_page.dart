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

                if (title == 'App Info')
                  Positioned(
                    top: -20,
                    left: -60,
                    child: CircleDecoration(
                      height: 400,
                      width: 400,
                      offset: Offset(2, 3),
                      shadow: Colors.blue.shade300,
                      gradientOne: Colors.blue.shade50,
                      gradientTwo: Colors.blue.shade100,
                    ),
                  ),

                if (title == 'App Privacy')
                  Positioned(
                    top: 50,
                    right: -80,
                    child: CircleDecoration(
                      height: 400,
                      width: 400,
                      offset: Offset(3, 2),
                      shadow: Colors.blue.shade400,
                      gradientOne: Colors.blue.shade100,
                      gradientTwo: Colors.blue.shade200,
                    ),
                  ),

                if (title == 'Quality Dream')
                  Positioned(
                    top: 100,
                    right: -40,
                    child: CircleDecoration(
                      height: 400,
                      width: 400,
                      offset: Offset(0, 0),
                      shadow: Colors.blue.shade600,
                      gradientOne: Colors.blue.shade100,
                      gradientTwo: Colors.blue.shade200,
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

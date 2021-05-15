import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web/services/routes.dart';
import 'package:web/widgets/button.dart';
import 'package:web/widgets/menu.dart';


class Home extends StatefulWidget {

  final isAdmin;

  Home({
    @required this.isAdmin
  });


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.all(12),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    MenuBar(),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black87,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w300
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),

                    SizedBox(height: 24),

                    CustomButton(
                      icon: Icon(Icons.download_rounded, color: Colors.black),
                      child: Text(
                        'DOWNLOAD DATA\n2021/03/14 - 2021/04/29',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                      onPressed: () {

                      },
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Visibility(
                      visible: widget.isAdmin,
                      child: CustomButton(
                        icon: Icon(Icons.people, color: Colors.black),
                        child: Text(
                          'MANAGE USERS',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.candidates);
                        },
                      ),
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Visibility(
                      visible: widget.isAdmin,
                      child: CustomButton(
                        icon: Icon(Icons.list_alt_outlined, color: Colors.black),
                        child: Text(
                          'CHANGE QUESTIONNAIRES',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),

                  ]),
            )
          )
        ])
    );
  }
}

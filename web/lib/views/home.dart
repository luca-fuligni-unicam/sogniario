import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web/services/rest_api/report_api.dart';
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

  ReportApi reportApi = ReportApi();
  bool semesterOne = false;
  bool semesterTwo = false;

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
                      child: Column(
                        children: [
                          Text(
                            'DOWNLOAD DATA',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),

                          SizedBox(height: 8),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Text(
                                'Semester - January / June ?',
                                style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.black.withOpacity(0.8)),
                              ),

                              SizedBox(width: 6),

                              Checkbox(
                                onChanged: (value) {
                                  setState(() {
                                    if (!semesterTwo) {
                                      semesterOne = value;
                                    }
                                  });
                                },
                                value: semesterOne,
                                activeColor: Colors.blue.shade200,
                              )
                            ]),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Text(
                                  'Second - July / December ?',
                                  style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.black.withOpacity(0.8)),
                                ),

                                SizedBox(width: 6),

                                Checkbox(
                                  onChanged: (value) {
                                    setState(() {
                                      if (!semesterOne) {
                                        semesterTwo = value;
                                      }
                                    });
                                  },
                                  value: semesterTwo,
                                  activeColor: Colors.blue.shade200,
                                )
                              ]),
                        ]),
                      onPressed: () {
                        reportApi.download(semesterOne);
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

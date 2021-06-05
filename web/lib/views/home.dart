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
  DateTime? before, after, now = DateTime.now();
  final list = <DateTime>[
    DateTime(2021, 1, 1),
    DateTime(2021, 4, 30),
    DateTime(2021, 5, 31),
    DateTime(2021, 6, 30),
    DateTime(2023, 1, 1),
    DateTime(2023, 6, 30),
  ];

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
                                'Sogniario is an open access data repository of dream reports collected over the Italian national territory. Reports are in Italian. Besides dream reports, the repository contains data on dream emotion content and levels of conscious control of dreams, and data on chronotype (Morningness-Eveningness Questionnaire) and sleep quality (Pittsburgh Scale Quality Index) for each subject enrolled. All data are anonymized and encrypted and available for download  For information please send an email to michele.bellesi@unicam.it.',
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

                          SizedBox(
                              width: 420,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.blue.shade100, width: 1.5),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)
                                  ),
                                ),
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


                                      for (int index = 0; index < list.length - 1; index++)
                                        if (list[index].isBefore(DateTime.now()))
                                          Padding(
                                            padding: EdgeInsets.all(2),
                                            child: CustomButton(
                                                onPressed: () {
                                                  reportApi.download(list[index], list[index + 1]);
                                                },
                                                child: Text(
                                                  'RELEASE   ${list[index + 1].isAfter(now!) ? now.toString().substring(0, 10) : list[index + 1].toString().substring(0, 10)}',
                                                  style: TextStyle(
                                                    color: Colors.black87.withOpacity(0.8),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                icon: Icon(Icons.list_alt_outlined)
                                            ),
                                          )

                                    ]),
                              )
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

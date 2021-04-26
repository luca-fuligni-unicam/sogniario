import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend/models/completed_survey.dart';
import 'package:frontend/models/dream.dart';
import 'package:frontend/models/report.dart';
import 'package:frontend/models/survey.dart';
import 'package:frontend/services/rest_api/report_api.dart';
import 'package:frontend/services/rest_api/suvery_api.dart';
import 'package:frontend/widgets/alert.dart';
import 'package:frontend/widgets/survey_card.dart';


class SurveyDream extends StatefulWidget {

  final Dream dream;

  SurveyDream({
    this.dream
  });

  @override
  _SurveyDreamState createState() => _SurveyDreamState();
}

class _SurveyDreamState extends State<SurveyDream> {

  PageController controller = PageController();
  SurveyApi surveyApi;
  ReportApi reportApi;
  int currentIndex = 0;

  TextStyle _questionStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Colors.black87
  );

  List<int> answers = List.generate(6, (index) => 0);

  @override
  void initState() {
    surveyApi = SurveyApi();
    reportApi = ReportApi();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text('Report del Sogno', style: TextStyle(color: Colors.black87)),
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0,
      ),

      body: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width
        ),
        child: Stack(
            children: [

              Align(
                alignment: Alignment.topCenter,
                child: ClipPath(
                  clipper: DiagonalPathClipperOne(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                    ),
                    height: 100,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: WaveClipperOne(reverse: true, flip: true),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                    ),
                    height: 100,
                  ),
                ),
              ),

              FutureBuilder(
                future: surveyApi.getSurveys('dream-survey'),
                builder: (context, AsyncSnapshot<Survey> data) {

                  if (data.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  } else {

                    if (data.data.id == null) {
                      return Center(
                        child: NoSurvey(
                          child: Text(
                            'No Report!',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87.withOpacity(0.7),
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      );
                    }

                    return PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller,
                      onPageChanged: (index) => setState(() => currentIndex = index),
                      itemBuilder: (context, index) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                    data.data.questions.keys.toList()[index],
                                    softWrap: true,
                                    style: _questionStyle
                                ),
                              ),

                              Divider(
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                                color: Colors.black,
                              ),

                              for (int count = 0; count < data.data.questions.values.toList()[index].length; count++)
                                RadioListTile(
                                  value: count,
                                  groupValue: answers[index],
                                  title: Text(data.data.questions.values.toList()[index].toList()[count]),
                                  onChanged: (changed) => setState(() => answers[index] = changed),
                                ),

                              Container(
                                child: Center(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [

                                        TextButton(
                                          child: Icon(
                                            Icons.chevron_left,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            controller.animateToPage(controller.page.ceil() - 1,
                                                duration: Duration(milliseconds: 750),
                                                curve: Curves.easeInQuad
                                            );
                                          },
                                        ),

                                        Container(
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Text(
                                            '${currentIndex + 1}/${data.data.questions.length}',
                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                                          ),
                                        ),

                                        TextButton(
                                          child: Icon(
                                            Icons.chevron_right,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            if (currentIndex == data.data.questions.length - 1) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return SogniarioAlert(
                                                        content: "\nConfermi le risposte date?\n",
                                                        buttonLabelDx: 'Conferma',
                                                        onPressedDx: () async {

                                                          List<String> answer = List
                                                              .generate(6, (index) => data.data.questions.values.toList()[index][answers[index]]);

                                                          bool valid = await reportApi.insertReport(
                                                            Report(
                                                              dreamerId: reportApi.getToken(),
                                                              dream: widget.dream,
                                                              completedSurvey: CompletedSurvey(
                                                                surveyId: data.data.id,
                                                                answers: answer
                                                              )
                                                            )
                                                          );

                                                          if (valid) {
                                                            showDialog(
                                                                context: context,
                                                                builder: (context) {
                                                                  return SogniarioAlert(
                                                                      content: "Report mandato con successo!",
                                                                      buttonLabelDx: 'Ok',
                                                                      type: AlertDialogType.SUCCESS,
                                                                      onPressedDx: () {
                                                                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                                                                      },
                                                                      onPressedSx: () => Navigator.pop(context),
                                                                  );
                                                                });

                                                          } else {
                                                            showDialog(
                                                                context: context,
                                                                builder: (context) {
                                                                  return SogniarioAlert(
                                                                      content: "Problemi nel mandare il report!",
                                                                      buttonLabelDx: 'Ok',
                                                                      type: AlertDialogType.ERROR,
                                                                      onPressedDx: () {},
                                                                      onPressedSx: () => Navigator.pop(context)
                                                                  );
                                                                });
                                                          }

                                                        },
                                                        onPressedSx: () => Navigator.pop(context)
                                                    );
                                                  });

                                            } else {
                                              controller.animateToPage(controller.page.ceil() + 1,
                                                  duration: Duration(milliseconds: 700),
                                                  curve: Curves.easeIn);
                                            }
                                          },
                                        ),

                                      ]),
                                ),
                              ),
                            ]);
                      },
                      itemCount: data.data.questions.keys.length,
                    );

                  }
                },
              )

            ]),

      ),
    );
  }
}

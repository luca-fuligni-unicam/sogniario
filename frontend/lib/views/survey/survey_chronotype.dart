import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend/models/completed_survey.dart';
import 'package:frontend/models/survey.dart';
import 'package:frontend/services/rest_api/suvery_api.dart';
import 'package:frontend/widgets/alert.dart';
import 'package:frontend/widgets/survey_card.dart';
import 'package:frontend/common/constants.dart';


class SurveyChronotype extends StatefulWidget {

  @override
  _SurveyChronotypeState createState() => _SurveyChronotypeState();
}

class _SurveyChronotypeState extends State<SurveyChronotype> {

  PageController controller = PageController();
  SurveyApi surveyApi;
  int currentIndex = 0;

  List<int> answers = List.generate(40, (index) => 0);

  @override
  void initState() {
    surveyApi = SurveyApi();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text('Questionario sul Cronotipo', style: titleTextStyle),
        iconTheme: IconThemeData(color: Colors.black87.withOpacity(0.8)),
        elevation: 0,
      ),

      body: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
        child: Stack(
          children: [

            Align(
              alignment: Alignment.topCenter,
              child: ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                  ),
                  height: 80,
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: WaveClipperTwo(reverse: true, flip: true),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                  ),
                  height: 80,
                ),
              ),
            ),

            FutureBuilder(
              future: surveyApi.getSurveys('meq'),
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
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                  data.data.questions.keys.toList()[index],
                                  softWrap: true,
                                  style: questionTextStyle
                              ),
                            ),

                            divider,

                            for (int count = 0; count < data.data.questions.values.toList()[index].length; count++)
                              RadioListTile(
                                value: count,
                                groupValue: answers[index],
                                title: Text(
                                    data.data.questions.values.toList()[index].toList()[count].toString().substring(4),
                                    style: answerTextStyle
                                ),
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
                                          '${currentIndex + 1}/${data.data.questions.keys.length}',
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
                                          if (currentIndex == data.data.questions.keys.length - 1) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SogniarioAlert(
                                                    content: "\nConfermi le risposte date?\n",
                                                    buttonLabelDx: 'Conferma',
                                                    onPressedDx: () async {

                                                      List<String> answer = List
                                                          .generate(data.data.questions.keys.length - 1, (index) => data.data.questions.values.toList()[index][answers[index]]);

                                                      bool valid = await surveyApi.insert(
                                                          surveyApi.getId(),
                                                          CompletedSurvey(surveyId: data.data.id, answers: answer)
                                                      );

                                                      if (valid) {
                                                        surveyApi.setReminderChronotype();
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return SogniarioAlert(
                                                                content: "Questionario mandato con successo!",
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
                                                                content: "Problemi nel mandare il questionario!",
                                                                buttonLabelDx: 'Ok',
                                                                type: AlertDialogType.ERROR,
                                                                onPressedDx: () {},
                                                                onPressedSx: () => Navigator.pop(context),
                                                              );
                                                            });
                                                      }

                                                    },
                                                    onPressedSx: () => Navigator.pop(context),
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
            ),

          ]),
      ),
    );
  }
}

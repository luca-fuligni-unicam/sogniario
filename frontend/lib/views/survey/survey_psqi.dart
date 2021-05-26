import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:frontend/common/constants.dart';
import 'package:frontend/models/completed_survey.dart';
import 'package:frontend/models/survey.dart';
import 'package:frontend/services/rest_api/suvery_api.dart';
import 'package:frontend/views/survey/score_psqi.dart';
import 'package:frontend/widgets/alert.dart';
import 'package:frontend/widgets/survey_card.dart';

import 'dart:convert';


class SurveyPSQI extends StatefulWidget {

  @override
  _SurveyPSQIState createState() => _SurveyPSQIState();
}

class _SurveyPSQIState extends State<SurveyPSQI> {

  PageController controller = PageController();
  SurveyApi surveyApi;
  int currentIndex = 0;
  bool verified = false;
  bool first = true;
  List<String> bonus = ['Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'];
  List<String> finalAnswer = [];

  List<int> answers = List.generate(20, (index) => 0);

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
        title: Text('PSQI', style: titleTextStyle),
        iconTheme: IconThemeData(color: Colors.black87),
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
              future: surveyApi.getSurveys('psqi'),
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

                  if (first) {
                    finalAnswer = List.generate(data.data.questions.keys.length, (index) => data.data.questions.values.toList()[index][0]);
                    first = false;
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
                                  data.data.questions.keys.toList()[index < 15 ? index : index + 1],
                                  softWrap: true,
                                  style: questionTextStyle
                              ),
                            ),

                            divider,

                            index == 1 ? getMinute(index, finalAnswer) :
                            index < 3 ? getTime(index, finalAnswer) :
                            index > 2 && index < 5 ? HourMinute(index, finalAnswer) :
                            index == 14 ? doubleAnswer(index, data.data.questions, finalAnswer) :
                            index > 4 && index < 15 ? returnAnswer(index, data.data.questions, finalAnswer) :
                            returnAnswer(index + 1, data.data.questions, finalAnswer),

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
                                          '${currentIndex + 1}/${data.data.questions.keys.length - 1}',
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
                                          FocusScope.of(context).unfocus();

                                          if (index == data.data.questions.keys.length - 2) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SogniarioAlert(
                                                    content: "\nConfermi le risposte date?\n",
                                                    buttonLabelDx: 'Conferma',
                                                    onPressedDx: () async {

                                                      bool valid = await surveyApi.insert(
                                                          surveyApi.getId(),
                                                          CompletedSurvey(surveyId: data.data.id, answers: finalAnswer)
                                                      );

                                                      if (valid) {
                                                        surveyApi.setReminderPSQI();
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return SogniarioAlert(
                                                                content: "Questionario mandato con successo!",
                                                                buttonLabelDx: 'Ok',
                                                                type: AlertDialogType.SUCCESS,
                                                                onPressedDx: () {
                                                                  Navigator.push(context, MaterialPageRoute(builder: (_) => ScorePage(score: finalAnswer)));
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
                    itemCount: data.data.questions.keys.length - 1,
                  );

                }
              },
            ),

          ]),
      )
    );
  }


  Widget returnAnswer(int index, Map<String, dynamic> questions, List<String> finalAnswer) {
    return Container(
      height: 260,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          for (int count = 0; count < questions.values.toList()[index].length; count++)
            RadioListTile(
              value: count,
              groupValue: answers[index],
              title: Text(questions.values.toList()[index].toList()[count].toString()),
              onChanged: (changed) => setState(() {
                answers[index] = changed;
                finalAnswer[index] = questions.values.toList()[index][answers[index]];
              }),
            )
        ]),
    );
  }


  Widget getMinute(int index, List<String> finalAnswer) {

    var time = '''
    [
      ${List.generate(121, (index) => '$index')}
    ]
    ''';

    return Padding(
      padding: EdgeInsets.all(10),
      child: TextButton(
        child: Text('Minuti?', style: buttonTextStyle),
        onPressed: () {
          Picker(
              adapter: PickerDataAdapter<String>(
                  pickerdata: JsonDecoder().convert(time),
                  isArray: true
              ),
              hideHeader: true,
              selectedTextStyle: TextStyle(color: Colors.blue.shade500),
              confirmText: 'Conferma',
              confirmTextStyle: TextStyle(fontSize: 17, color: Colors.blue.shade500),
              cancelTextStyle: TextStyle(fontSize: 17, color: Colors.blue.shade500),
              title: Text('Minuti'),
              onConfirm: (Picker picker, List value) {
                finalAnswer[index] = picker.getSelectedValues()[0];
              }
          ).showDialog(context);
        },
      )
    );
  }

  Widget getTime(int index, List<String> finalAnswer) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          TextButton(
            onPressed: () async {
              var time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(hour: 21, minute: 15),
              );

              if (time != null) {
                setState(() => finalAnswer[index] = time.toString().substring(10, 15));
              }
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 25),
                  Text('Premi per selezionare l\'ora', style: buttonTextStyle),
                  SizedBox(height: 25)
                ]),
          ),

          SizedBox(height: 10)
        ]),
    );
  }



  Widget doubleAnswer(int index, Map<String, dynamic> questions, List<String> finalAnswer) {
    return Expanded(
      child: ListView(
          children: [
            Container(
              height: 100,
              child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    for (int count = 0; count < questions.values.toList()[index].length; count++)
                      RadioListTile(
                        value: count,
                        groupValue: answers[index],
                        title: Text(
                          questions.values.toList()[index].toList()[count].toString(),
                          style: answerTextStyle,
                        ),
                        onChanged: (changed) => setState(() {
                          answers[index] = changed;
                          finalAnswer[index] = questions.values.toList()[index][answers[index]];
                          if (finalAnswer[index] == 'Si.') {
                            setState(() => verified = true);
                          } else {
                            setState(() => verified = false);
                            finalAnswer[index + 1] = null;
                          }
                        }),
                      )
                  ]),
            ),

            verified ? Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(labelText: 'Quale?'),
                onChanged: (problem) {
                  finalAnswer[index] = 'Si - $problem';
                },
              ),
            ) : SizedBox(),

            verified ? SizedBox(height: 15) : SizedBox(),

            verified ? Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                  questions.keys.toList()[15],
                  softWrap: true,
                  style: questionTextStyle
              ),
            ) : SizedBox(),

            verified ? Container(
              height: 250,
              child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    for (int count = 0; count < bonus.length; count++)
                      RadioListTile(
                        value: count,
                        groupValue: answers[index + 1],
                        title: Text(bonus[count]),
                        onChanged: (changed) => setState(() {
                          answers[index + 1] = changed;
                          finalAnswer[index + 1] = bonus[answers[index + 1]];
                        }),
                      )
                  ]),
            ) : SizedBox()

          ]),
    );
  }

}



// ignore: must_be_immutable
class HourMinute extends StatefulWidget {

  final int index;
  List<String> finalAnswer;

  HourMinute(this.index, this.finalAnswer);

  @override
  _HourMinuteState createState() => _HourMinuteState();
}

class _HourMinuteState extends State<HourMinute> {

  var time = '''
    [
      [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
      [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    ]
    ''';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextButton(
        child: Text('Ore?', style: buttonTextStyle),
        onPressed: () {
          showPickerArray(context);
        },
      ),
    );
  }

  showPickerArray(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: JsonDecoder().convert(time),
            isArray: true
        ),
        hideHeader: true,
        selectedTextStyle: TextStyle(color: Colors.blue.shade500),
        confirmText: 'Conferma',
        confirmTextStyle: TextStyle(fontSize: 17, color: Colors.blue.shade500),
        cancelTextStyle: TextStyle(fontSize: 17, color: Colors.blue.shade500),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [ Text('Ore'), Text(':'), Text('Minuti') ]
        ),
        onConfirm: (Picker picker, List value) {
          widget.finalAnswer[widget.index] = '${picker.getSelectedValues()[0]}:${picker.getSelectedValues()[1]}';
        }
    ).showDialog(context);
  }
}

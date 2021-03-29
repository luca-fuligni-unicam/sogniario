import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend/models/survey.dart';
import 'package:frontend/services/rest_api/suvery_api.dart';
import 'package:frontend/widgets/survey_card.dart';


class SurveyChronotype extends StatefulWidget {

  @override
  _SurveyChronotypeState createState() => _SurveyChronotypeState();
}

class _SurveyChronotypeState extends State<SurveyChronotype> {

  PageController controller = PageController();
  SurveyApi surveyApi;
  int currentIndex = 0;

  TextStyle _questionStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Colors.black87
  );

  List<int> answers = List.generate(40, (index) => 0);

  @override
  void initState() {
    surveyApi = SurveyApi();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text('Questionario sul Cronotipo', style: TextStyle(color: Colors.black54)),
        iconTheme: IconThemeData(color: Colors.black54),
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
                  clipper: WaveClipperTwo(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                    ),
                    height: 150,
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
                    height: 120,
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
                          child: Text('No Report!'),
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
                                            controller.animateToPage(controller.page.ceil() + 1,
                                                duration: Duration(milliseconds: 700),
                                                curve: Curves.easeIn);
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

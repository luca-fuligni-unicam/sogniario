import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';


class SurveyChronotype extends StatefulWidget {

  @override
  _SurveyChronotypeState createState() => _SurveyChronotypeState();
}

class _SurveyChronotypeState extends State<SurveyChronotype> {

  PageController controller = PageController();
  int currentIndex = 0, value = 0;

  TextStyle _questionStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Colors.black87
  );

  Map<String, List<String>> questions = {
    'A che ora preferiresti alzarti, più o meno, se fossi completamente libero di programmare la tua giornata?': ['5 - 6.30 del mattino.', '6.30 - 7.45 del mattino.', '7.45 - 9.45 del mattino.', '9.45 - 11 del mattino.', '11 - 12 del mattino.'],
    'A che ora preferiresti andare a letto, più o meno, se fossi completamente libero di programmare la tua serata?': ['8 - 9 di sera.', '9 - 10.15 di sera.', '10.15 - 00.30 di notte.', '00.30 - 1.45 di notte.', '1.45 - 3 di notte.'],
    'Se di solito ti devi alzare ad una certa ora del mattino, hai proprio bisogno di sentire la sveglia per svegliarti?': ['Per niente.', 'Poco.', 'Abbastanza.', 'Molto.'],
  };

  List<int> list = [0, 0, 0];


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

              /*
                    Text(
                      'Il Cronotipo è una qualità degli esseri umani che indica quando sono o preferiscono essere maggiormente attivi durante la giornata.\n'
                          'Vengono definite "Allodole" quelle persone che si alzano presto alla mattina e sono maggiormente attive nella prima parte del giorno, i "Gufi" quelle che sono maggiormente attive durante la sera e preferiscono andare a letto tardi.\n'
                          'Il sequente questionario permette di identificare a quale cronotipo appartieni.\nIl questionario può richiedere alcuni minuti.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87
                      ),
                    ),
               */

              PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                              questions.keys.toList()[index],
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

                        for (int count = 0; count < questions.values.toList()[index].length; count++)
                          RadioListTile(
                            value: count,
                            groupValue: list[index],
                            title: Text(questions.values.toList()[index][count]),
                            onChanged: (changed) => setState(() => list[index] = changed),
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
                                      '${currentIndex + 1}/3',
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
                itemCount: 3,
              )

            ]),
      ),
    );

  }
}

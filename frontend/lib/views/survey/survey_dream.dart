import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend/widgets/alert.dart';


class SurveyDream extends StatefulWidget {

  @override
  _SurveyDreamState createState() => _SurveyDreamState();
}

class _SurveyDreamState extends State<SurveyDream> {

  PageController controller = PageController();
  int currentIndex = 0;

  TextStyle _questionStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Colors.black87
  );

  Map<String, List<String>> questions = {
    'Come giudichi il contenuto emotivo del sogno?': ['Non emotivo.', 'Parzialmente emotivo.', 'Nella media.', 'Emotivo.', 'Molto emotivo.'],
    'Eri cosciente che stavi sognando?': ['Si.', 'No.'],
    'Avevi il controllo del sogno?': ['Nessun controllo.', 'Riuscivo a controllare solo alcune cose.', 'Controllo totale.'],
    'Quanto tempo pensi sia passato nel tuo sogno?': ['Pochi secondi.', 'Qualche minuto.', 'Qualche ora.', 'Qualche giorno.'],
    'Quanto hai dormito?': ['6 - 7 ore.', '7 - 8 ore.', '8 - 9 ore.', '9 - 10 ore.'],
    'Come giudichi la qualità del sonno?': ['Molto scarsa.', 'Scarsa.', 'Buona.', 'Molto buona.'],
  };

  List<int> answers = List.generate(6, (index) => 0);


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
                            groupValue: answers[index],
                            title: Text(questions.values.toList()[index][count]),
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
                                      '${currentIndex + 1}/6',
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
                                      if (currentIndex == 5) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SogniarioAlert(
                                                  content: "\nConfermi le risposte date?\n",
                                                  buttonLabel: 'Conferma',
                                                  onPressed: () {

                                                  });
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
                itemCount: 6,
              )
            ]),

      ),
    );
  }
}

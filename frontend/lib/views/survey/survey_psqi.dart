import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend/services/rest_api/suvery_api.dart';


class SurveyPSQI extends StatefulWidget {

  @override
  _SurveyPSQIState createState() => _SurveyPSQIState();
}

class _SurveyPSQIState extends State<SurveyPSQI> {

  PageController controller = PageController();
  SurveyApi surveyApi;
  int currentIndex = 0;
  Map<String, List<String>> questions = {
    'Nell\'ultimo mese, di solito, a che ora sei andato a dormire la sera?': [],
    'Nell\'ultimo mese, di solito, quanto tempo (in minuti) hai impiegato ad addormentarti?': [],
    'Nell\'ultimo mese, di solito, a che ora ti sei alzato al mattino?': [],
    'Nell\'ultimo mese, quante ore hai dormito effettivamente per notte?': [],
    'Quante ore hai passato nel letto?': [],

    // TODO titolo di un sacco di domande
    //'Nell\'ultimo mese, quanto spesso hai avuto problemi di sonno dovuti a?': [],

    'Non riuscire ad addormentarsi entro 30 minuti:': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],
    'Svegliarsi nel mezzo della notte o al mattino presto senza riaddormentarsi:': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],
    'Alzarsi nel mezzo della notte per andare in bagno:': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],
    'Non riuscire a respirare bene:': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],
    'Tossire o russare forte:': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],
    'Sentire troppo freddo:': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],
    'Sentire troppo caldo:': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],
    'Fare brutti sogni:': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],
    'Avere dolori:': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],

    'C\'è qualche altro problema che può aver disturbato il tuo sonno?': ['No.', 'Si.'],
    'Quanto spesso hai avuto problemi a dormire per questo motivo:': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],

    'Nell\'ultimo mese, come valuti complessivamente la qualità del suo sonno?': ['Molto buona.', 'Abbastanza buona.', 'Abbastanza cattiva.', 'Molto cattiva.'],
    'Nell\'ultimo mese, quanto spesso hai preso farmaci (prescritti dal medico o meno) per facilitare il sonno?': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],
    'Nell\'ultimo mese, quanto spesso hai avuto difficiotà a rimanere sveglio alla guida o nel corso di attività sociali?': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],
    'Nell\'ultimo mese, hai avuto problemi ad avere energie sufficienti per concludere le sue normali attività?': ['Per niente.', 'Poco.', 'Abbastanza.', 'Molto.']
  };

  TextStyle _questionStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Colors.black87
  );

  List<int> answers = List.generate(21, (index) => 0);

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
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text('Questionario sulla qualità del sonno', style: TextStyle(color: Colors.black87.withOpacity(0.8))),
        iconTheme: IconThemeData(color: Colors.black87.withOpacity(0.8)),
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
                  clipper: WaveClipperOne(),
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
                  clipper: WaveClipperTwo(reverse: true, flip: true),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                    ),
                    height: 100,
                  ),
                ),
              ),

              PageView.builder(
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

                        index > 4 ? returnAnswer(questions, index) : getHours(),

                        /*
                        for (int count = 0; count < questions.values.toList()[index].length; count++)
                          RadioListTile(
                            value: count,
                            groupValue: answers[index],
                            title: Text(questions.values.toList()[index].toList()[count].toString()),
                            onChanged: (changed) => setState(() => answers[index] = changed),
                          ),
                         */

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
                                      '${currentIndex + 1}/${questions.keys.length}',
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
                itemCount: questions.keys.length,
              )

            ]),
      )
    );
  }


  Widget returnAnswer(Map<String, List<String>> questions, int index) {
    return ListView(
      children: [
        for (int count = 0; count < questions.values.toList()[index].length; count++)
          RadioListTile(
            value: count,
            groupValue: answers[index],
            title: Text(questions.values.toList()[index].toList()[count].toString()),
            onChanged: (changed) => setState(() => answers[index] = changed),
          )
      ],
    );
  }

  Widget getHours() {
    return Container(
      child: TextField(
        decoration: InputDecoration(labelText: 'Ora?'),
      ),
    );
  }
}

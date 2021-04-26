import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool verified = false;
  Map<String, List<String>> questions = {
    'Nell\'ultimo mese, di solito, a che ora sei andato a dormire la sera?': ['21:30'],
    'Nell\'ultimo mese, di solito, quanto tempo (in minuti) hai impiegato ad addormentarti?': ['10'],
    'Nell\'ultimo mese, di solito, a che ora ti sei alzato al mattino?': ['08:30'],
    'Nell\'ultimo mese, quante ore hai dormito effettivamente per notte?': ['08:45'],
    'Quante ore hai passato nel letto?': ['09:00'],

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
    'Quanto spesso hai avuto problemi a dormire per questo motivo?': [null],

    'Nell\'ultimo mese, come valuti complessivamente la qualità del suo sonno?': ['Molto buona.', 'Abbastanza buona.', 'Abbastanza cattiva.', 'Molto cattiva.'],
    'Nell\'ultimo mese, quanto spesso hai preso farmaci (prescritti dal medico o meno) per facilitare il sonno?': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],
    'Nell\'ultimo mese, quanto spesso hai avuto difficiotà a rimanere sveglio alla guida o nel corso di attività sociali?': ['Non durante l\'ultimo mese.', 'Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'],
    'Nell\'ultimo mese, hai avuto problemi ad avere energie sufficienti per concludere le sue normali attività?': ['Per niente.', 'Poco.', 'Abbastanza.', 'Molto.']
  };
  List<String> bonus = ['Meno di una volta a settimana.', 'Una o due volte a settimana.', 'Tre o piu volte a settimana.'];

  TextStyle _questionStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Colors.black87
  );

  List<int> answers = List.generate(20, (index) => 0);
  List<String> finalAnswer;

  @override
  void initState() {
    surveyApi = SurveyApi();
    finalAnswer = List.generate(20, (index) => questions.values.toList()[index][0]);
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
        title: Text('PSQI', style: TextStyle(color: Colors.black87.withOpacity(0.8))),
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

              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: PageView.builder(
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
                                  questions.keys.toList()[index < 15 ? index : index + 1],
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

                            index == 1 ? getMinute(index) : index < 3 ? getTime(index) : index > 2 && index < 5 ? HourMinute(index, finalAnswer) : index == 14 ? doubleAnswer(index) : index > 4 && index < 15 ? returnAnswer(index) : returnAnswer(index + 1),

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
                                          FocusScope.of(context).unfocus();
                                          controller.animateToPage(controller.page.ceil() - 1,
                                              duration: Duration(milliseconds: 750),
                                              curve: Curves.easeInQuad
                                          );
                                        },
                                      ),

                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Text(
                                          '${currentIndex + 1}/${questions.keys.length - 1}',
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
                                          if (index == questions.keys.length - 2) {
                                            print(finalAnswer);
                                          }

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
                    itemCount: questions.keys.length - 1,
                  )
              )

            ]),
      )
    );
  }


  Widget returnAnswer(int index) {
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


  Widget getMinute(int index) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(labelText: 'Minuti?'),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (changed) {
          finalAnswer[index] = changed;
        },
      ),
    );
  }

  Widget getTime(int index) {
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
                  Text('Premi per selezionare l\'ora'),
                  SizedBox(height: 25)
                ]),
          ),

          SizedBox(height: 10)
        ]),
    );
  }



  Widget doubleAnswer(int index) {
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
                        title: Text(questions.values.toList()[index].toList()[count].toString()),
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
                  style: _questionStyle
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

  Map<int, String> hours = {0: '4', 1: '5', 2: '6', 3: '7', 4: '8', 5: '9', 6: '10', 7: '11', 8: '12', 9: '13', 10: '14'};
  Map<int, String> minutes = {0: '00', 1: '05', 2: '10', 3: '15', 4: '20', 5: '25', 6: '30', 7: '35', 8: '40', 9: '45', 10: '50', 11: '55'};
  int hour = 4, minute = 6;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            DropdownButton(
                value: hour,
                elevation: 2,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 28,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                    fontSize: 17
                ),
                items: [
                  for (int index = 0; index < hours.length; index++)
                    DropdownMenuItem(
                      child: Text('${hours[index]}'),
                      value: hours.keys.toList()[index],
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    hour = value;
                    widget.finalAnswer[widget.index] = '${hours[hour]}:${minutes[minute]}';
                  });
                }),

            SizedBox(width: 20),

            DropdownButton(
                value: minute,
                elevation: 2,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 28,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                    fontSize: 17
                ),
                items: [
                  for (int index = 0; index < minutes.length; index++)
                    DropdownMenuItem(
                      child: Text('${minutes[index]}'),
                      value: minutes.keys.toList()[index],
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    minute = value;
                    widget.finalAnswer[widget.index] = '${hours[hour]}:${minutes[minute]}';
                  });
                })

          ]),
    );
  }
}

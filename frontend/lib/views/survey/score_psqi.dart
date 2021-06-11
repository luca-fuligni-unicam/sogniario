import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend/common/constants.dart';


class ScorePage extends StatefulWidget {

  final List<String> score;

  ScorePage({
    this.score,
  });


  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {

  Map<String, int> component = {
    'Non durante l\'ultimo mese.': 0,
    'Meno di una volta a settimana.': 1,
    'Una o due volte a settimana.': 2,
    'Tre o piu volte a settimana.': 3
  };


  @override
  Widget build(BuildContext context) {
    int score = getScore(component, widget.score);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.blue.shade100.withOpacity(0.6),
          title: Text('Punteggio PSQI', style: titleTextStyle),
          iconTheme: IconThemeData(color: Colors.black87.withOpacity(0.8)),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.home, size: 30),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
                splashRadius: 1
            ),
            SizedBox(width: 4)
          ]),

      body: SafeArea(
        child: Stack(
            children: [

              Align(
                alignment: Alignment.topCenter,
                child: ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100.withOpacity(0.6),
                    ),
                    height: 120,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: WaveClipperOne(reverse: true, flip: true),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100.withOpacity(0.6),
                    ),
                    height: 120,
                  ),
                ),
              ),

              ListView(
                  padding: EdgeInsets.only(left: 14, right: 14),
                  children: [

                    Text('Punteggio\n$score', style: TextStyle(fontSize: 22)),

                    SizedBox(
                        height: 28
                    ),

                    score > 4 ? Text(
                        '''La qualità del tuo sonno potrebbe migliorare.\n\n
     Raccomandazioni dell'Associazione Italiana Medicina del Sonno.\n
1. La stanza in cui si dorme non dovrebbe ospitare altro che l'essenziale per domire. È da sconsigliare la collocazione nella camera da letto di televisore, computer, scrivanie per evitare di stabilire legami tra attività non rilassanti e l'ambiente in cui si deve invece stabilire una condizione di relax che favorisca l’inizio ed il mantenimento del sonno notturno.
2. La stanza in cui si dorme deve essere sufficientemente buia, silenziosa e di temperatura adeguata (evitare eccesso di caldo o di freddo).
3. Evitare di assumere, in particolare nelle ore serali, bevande a base di caffeina e simili (caffè, the, coca-cola, cioccolata)
4. Evitare di assumere nelle ore serali o, peggio, a scopo ipnoinducente , bevande alcoliche (vino, birra, superalcolici).
5. Evitare pasti serali ipercalorici o comunque abbondanti e ad alto contenuto di proteine (carne, pesce).
6. Evitare il fumo di tabacco nelle ore serali.
7. Evitare sonnellini diurni, eccetto un breve sonnellino post-prandiale. Evitare in particolare sonnellini dopo cena, nella fascia oraria prima di coricarsi.
8. Evitare, nelle ore prima di coricarsi, l’esercizio fisico di medio-alta intensità ( per es. palestra). L’esercizio fisico è invece auspicabile nel tardo pomeriggio.
9. Il bagno caldo serale non dovrebbe essere fatto nell’immediatezza di coricarsi ma a distanza di 1-2 ore.
10. Evitare, nelle ore prima di coricarsi, di impegnarsi in attività che risultano particolarmente coinvolgenti sul piano mentale e/o emotivo (studio; lavoro al computer; video-giochi, ecc.)
11. Cercare di coricarsi la sera e alzarsi al mattino in orari regolari e costanti e quanto più possibile consoni alla propria tendenza naturale al sonno.
12. Non protrarre eccessivamente il tempo trascorso a letto di notte, anticipando l’ora di coricarsi e/o posticipando l’ora di alzarsi al mattino.
                  ''', style: TextStyle(fontSize: 17.5)) : Text('La qualità del tuo sonno è eccellente!', style: TextStyle(fontSize: 18)),

                  ])
            ]),
      ),
    );
  }

}


int getScore(Map<String, int> component, List<String> list) {

  int scoreOne = componentOne(list);
  int scoreTwo = componentTwo(component, list);
  int scoreThree = componentThree(list);
  int scoreFour = componentFour(list);
  int scoreFive = componentFive(component, list);
  int scoreSix = componentSix(component, list);
  int scoreSeven = componentSeven(component, list);

  return scoreOne + scoreTwo + scoreThree + scoreFour + scoreFive + scoreSix + scoreSeven;
}


int componentOne(List<String> list) {
  switch (list[16]) {
    case 'Molto buona.':
      return 0;

    case 'Abbastanza buona.':
      return 1;
    case 'Abbastanza cattiva.':
      return 2;

    default:
      return 3;
  }
}

int componentTwo(Map<String, int> component, List<String> list) {
  int answerTwo = int.parse(list[1]);
  int scoreTwo = answerTwo > 60 ? 3 : answerTwo <= 60 && answerTwo > 30 ? 2 : answerTwo < 31 && answerTwo > 15 ? 1 : 0;
  int scoreFiveA = component[list[5]];

  switch (scoreTwo + scoreFiveA) {
    case 0:
      return 0;

    case 1:
    case 2:
      return 1;

    case 3:
    case 4:
      return 2;

    default:
      return 3;
  }
}

int componentThree(List<String> list) {
  String clean = list[3].replaceFirst(':', '.');
  double answerFourA = double.tryParse(clean.startsWith('0') ? clean.substring(1) : clean);
  return answerFourA > 7 ? 0 : answerFourA > 5 && answerFourA < 8 ? 1 : answerFourA > 4 && answerFourA < 7 ? 2 : 3;
}

int componentFour(List<String> list) {
  String cleanOne = list[3].replaceFirst(':', '.');
  String cleanTwo = list[4].replaceFirst(':', '.');
  double score = (double.parse(cleanOne) / double.parse(cleanTwo)) * 100;
  return score > 84 ? 0 : score > 74 && score < 85 ? 1 : score > 64 && score < 75 ? 2 : 3;
}

int componentFive(Map<String, int> component, List<String> list) {
  int score = 0;

  for (int index = 6; index < 14; index++) {
    score += component[list[index]];
  }

  if (list[14].startsWith('Si')) {
    score += component[list[15]];
  }

  return score == 0 ? 0 : score > 0 && score < 10 ? 1 : score > 9 && score < 19 ? 2 : 3;
}

int componentSix(Map<String, int> component, List<String> list) {
  return component[list[17]];
}

int componentSeven(Map<String, int> component, List<String> list) {
  int score = component[list[17]] + component[list[18]];
  switch (score) {
    case 0:
      return 0;

    case 1:
    case 2:
      return 1;

    case 3:
    case 4:
      return 2;

    default:
      return 3;
  }
}

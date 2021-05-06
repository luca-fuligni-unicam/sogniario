import 'package:flutter/material.dart';
import 'package:frontend/widgets/info_page.dart';


class InfoDream extends StatefulWidget {

  @override
  _InfoDreamState createState() => _InfoDreamState();
}

class _InfoDreamState extends State<InfoDream> {

  @override
  Widget build(BuildContext context) {
    return InfoPage(
      title: 'Quality Dream',
      content: '''
          Raccomandazioni dell'Associazione Italiana Medicina del Sonno.
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
          ''',
    );
  }
}

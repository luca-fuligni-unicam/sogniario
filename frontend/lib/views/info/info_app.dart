import 'package:flutter/material.dart';
import 'package:frontend/widgets/info_page.dart';


class InfoApp extends StatefulWidget {

  @override
  _InfoAppState createState() => _InfoAppState();
}

class _InfoAppState extends State<InfoApp> {

  @override
  Widget build(BuildContext context) {
    return InfoPage(
      title: 'App Info',
      content: "Sogniario è un'app creata per registrare e catalogare i tuoi sogni.\n\n" +
          "Prende nota della qualità del tuo sonno e delle caratteristiche dei tuoi sogni. Inoltre registra vocalmente la descrizione del tuo sogno.\n\n"+
          "Analizza la complessità del sogno attraverso tecniche di neurolinguistica e riporta grafi e nuvole di parole per una visualizzazione intuitiva del contenuto del sogno. Permette di tener traccia della qualità del tuo sonno e dei sogni mediante la funzione calendario.\n\n" +
          "Sogniario nasce da una collaborazione tra il Brain and Sleep Research Laboratory dell’Università di Camerino e il Molecular Mind Laboratory della Scuola IMT Alti Studi Lucca. Ha lo scopo di aiutare gli scienziati a comprendere il funzionamento del cervello alla base dell’esperienza cosciente durante il sonno.",
    );
  }
}

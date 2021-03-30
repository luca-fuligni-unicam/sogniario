import 'package:flutter/material.dart';
import 'package:frontend/widgets/info_page.dart';


class InfoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoPage(
      title: 'Info Internet',
      content: "Momentaneamente non sei connesso ad internet.\nNon sarà possibile:\n"+
          " - Inviare i sogni.\n"+
          " - Compilare questionari.\n"+
          " - Visualizzare la nuvola delle parole e i grafi dei sogni registrati precedentemente.\n"+
          "Tali azioni saranno disponibili appena verrà ripristinata la connessione.",
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/widgets/alert.dart';
import 'package:frontend/widgets/card.dart';
import 'package:frontend/widgets/circle_decoration.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
              children: [

                Positioned(
                  top: -50,
                  left: MediaQuery.of(context).size.width / 4 - 25,
                  child: CircleDecoration(
                    height: 250,
                    width: 250,
                    offset: Offset(2, 2),
                    shadow: Colors.teal.shade300,
                    gradientOne: Colors.teal.shade50,
                    gradientTwo: Colors.teal.shade100,
                  ),
                ),

                Positioned(
                  top: 10,
                  left: 15,
                  child: Text(
                    'Sogniario',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black87.withOpacity(0.7),
                        fontSize: 26
                    ),
                  ),
                ),

                Positioned(
                  bottom: -10,
                  right: -50,
                  child: CircleDecoration(
                    height: 150,
                    width: 200,
                    offset: Offset(1, 1),
                    shadow: Colors.teal.shade300,
                    gradientOne: Colors.teal.shade50,
                    gradientTwo: Colors.teal.shade100,
                  ),
                ),

                Positioned(
                  bottom: MediaQuery.of(context).size.height / 4,
                  left: -50,
                  child: CircleDecoration(
                    height: 200,
                    width: 200,
                    offset: Offset(2, 2),
                    shadow: Colors.teal.shade300,
                    gradientOne: Colors.teal.shade50,
                    gradientTwo: Colors.teal.shade100,
                  ),
                ),

                ListView(
                  padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                  children: [

                    SogniarioCard(
                      title: 'Sogni',
                      listTileTitleOne: 'I miei Sogni',
                      listTileIconOne: Icon(Icons.settings_system_daydream, color: Colors.blue.shade300),
                      listTileOnTapOne: () {

                      },
                      listTileTitleTwo: 'Racconta un Sogno',
                      listTileIconTwo: Icon(Icons.cloud_sharp, color: Colors.blue.shade100),
                      listTileOnTapTwo: () {
                        Navigator.pushNamed(context, '/add');
                      },
                    ),

                    SizedBox(
                      height: 10
                    ),

                    SogniarioCard(
                      title: 'Questionari',
                      listTileTitleOne: 'Questionario sul Cronotipo',
                      listTileIconOne: Icon(Icons.list_alt_rounded, color: Colors.black54),
                      listTileOnTapOne: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SogniarioAlert(
                              content: "Questionario usato per scoprire a quale cronotipo appartieni. Gufo o Allodola?\nNon è obbligatorio, puoi compilarlo in un secondo momento.",
                              buttonLabel: 'Compila',
                              onPressed: () async {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/chronotype');
                              });
                          });
                      },
                      listTileTitleTwo: 'Questionario sulla Qualita del Sonno',
                      listTileIconTwo: Icon(Icons.view_list_outlined, color: Colors.green.shade300),
                      listTileOnTapTwo: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SogniarioAlert(
                              content: "Questionario sulla qualità del sonno.\nNon è obbligatorio, puoi compilarlo in un secondo momento.\nÈ un questionario mensile, verrà richiesto ogni 30 giorni.",
                              buttonLabel: 'Compila',
                              onPressed: () {

                              });
                          });
                      },
                    ),

                    SizedBox(
                        height: 10
                    ),

                    SogniarioCard(
                      title: 'Info',
                      listTileTitleOne: 'App Info',
                      listTileIconOne: Icon(Icons.info, color: Colors.indigo.shade400),
                      listTileOnTapOne: () {
                        Navigator.pushNamed(context, '/info');
                      },
                      listTileTitleTwo: 'App Privacy',
                      listTileIconTwo: Icon(Icons.privacy_tip_outlined, color: Colors.teal.shade400),
                      listTileOnTapTwo: () {
                        Navigator.pushNamed(context, '/privacy');
                      },
                    ),

                  ])
              ]),
        ),
      ),
    );
  }

}

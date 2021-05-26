import 'package:flutter/material.dart';
import 'package:frontend/common/constants.dart';
import 'package:frontend/models/dreamer.dart';
import 'package:frontend/services/rest_api/dreamer_api.dart';
import 'package:frontend/services/utils.dart';
import 'package:frontend/widgets/alert.dart';
import 'package:frontend/widgets/card.dart';
import 'package:frontend/widgets/circle_decoration.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Utils utils = Utils();
  DreamerApi dreamerApi = DreamerApi();
  bool psqi, chronotype;

  @override
  void initState() {
    tokenIsExpired();
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      psqi = utils.getReminderPSQI();
      chronotype = utils.getReminderChronotype();

      if (psqi || chronotype) {
        String content = psqi && chronotype ? 'Hai dei questionari da compilare!' : psqi ? 'Ricordati di compilare il PSQI!' : chronotype ? 'Ricordati di compilare il questionario sul cronotipo!' : '';
        showDialog(
            context: context,
            builder: (context) {
              return SogniarioAlert(
                title: 'Promemoria',
                content: content,
                buttonLabelDx: 'Cronotipo',
                buttonLabelSx: 'PSQI',
                type: AlertDialogType.INFO,
                onPressedDx: () => chronotype ? Navigator.pushNamed(context, '/chronotype') : {},
                onPressedSx: () => psqi ? Navigator.pushNamed(context, '/psqi') : {},
              );
            });
      }
    });
  }

  void tokenIsExpired() async {
    if (JwtDecoder.isExpired(utils.getToken())) {
      await dreamerApi.login(
          Dreamer(id: dreamerApi.getId()).login(), true
      );
    }
  }


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
                    offset: Offset(-1, -1),
                    shadow: Colors.blue.shade600,
                    gradientOne: Colors.blue.shade200.withOpacity(0.4),
                    gradientTwo: Colors.blue.shade100,
                  ),
                ),

                Positioned(
                  bottom: -10,
                  right: -50,
                  child: CircleDecoration(
                    height: 150,
                    width: 200,
                    offset: Offset(1, 1),
                    shadow: Colors.blue.shade800,
                    gradientOne: Colors.blue.shade100,
                    gradientTwo: Colors.blue.shade200.withOpacity(0.6),
                  ),
                ),

                Positioned(
                  bottom: MediaQuery.of(context).size.height / 4,
                  left: -50,
                  child: CircleDecoration(
                    height: 200,
                    width: 200,
                    offset: Offset(2, 2),
                    shadow: Colors.blue.shade700,
                    gradientOne: Colors.blue.shade100,
                    gradientTwo: Colors.blue.shade100,
                  ),
                ),

                ListView(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  children: [

                    Text(
                      'Sogniario',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontSize: 26
                      ),
                    ),

                    SogniarioCard(
                      title: 'Sogni',
                      listTileTitleOne: 'I miei Sogni',
                      listTileIconOne: Icon(Icons.settings_system_daydream, color: Colors.blue.shade300),
                      listTileOnTapOne: () {
                        Navigator.pushNamed(context, '/dreams');
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
                        if (!chronotype) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SogniarioAlert(
                                  content: 'Questionario sul Cronotipo già compilato!',
                                  buttonLabelDx: 'Ok',
                                  onPressedDx: () => Navigator.pop(context),
                                  onPressedSx: () => Navigator.pop(context),
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SogniarioAlert(
                                  content: meqContent,
                                  buttonLabelDx: 'Compila',
                                  onPressedDx: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/chronotype');
                                  },
                                  onPressedSx: () => Navigator.pop(context),
                                );
                              });
                        }
                      },
                      listTileTitleTwo: 'Questionario sulla Qualita del Sonno',
                      listTileIconTwo: Icon(Icons.view_list_outlined, color: Colors.green.shade300),
                      listTileOnTapTwo: () {
                        if (!psqi) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SogniarioAlert(
                                  content: 'PSQI già compilato!',
                                  buttonLabelDx: 'Ok',
                                  onPressedDx: () => Navigator.pop(context),
                                  onPressedSx: () => Navigator.pop(context),
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SogniarioAlert(
                                  content: psqiContent,
                                  buttonLabelDx: 'Compila',
                                  onPressedDx: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/psqi');
                                  },
                                  onPressedSx: () => Navigator.pop(context),
                                );
                              });
                        }
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
                    )

                  ])
              ]),
        ),
      ),
    );
  }

}

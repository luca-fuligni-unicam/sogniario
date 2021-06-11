import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:frontend/models/dreamer.dart';
import 'package:frontend/services/rest_api/dreamer_api.dart';
import 'package:frontend/widgets/alert.dart';
import 'package:frontend/widgets/circle_decoration.dart';
import 'package:frontend/widgets/sogniario_button.dart';
import 'package:hive/hive.dart';

import 'dart:convert';


class GeneralInformation extends StatefulWidget {

  @override
  _GeneralInformationState createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {

  // 0 male, 1 female
  int gender = 0;
  int dreamerAge = 0;
  var box = Hive.box('data');
  DreamerApi dreamerApi;
  var age = '''[ ${List.generate(88, (index) => '${index + 14}')} ]''';

  @override
  void initState() {
    dreamerApi = DreamerApi();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            Positioned(
              top: -30,
              left: -80,
              child: CircleDecoration(
                width: 300,
                height: 250,
                shadow: Colors.blueAccent.shade100,
                gradientOne: Colors.blue.shade50,
                gradientTwo: Colors.blue.shade100,
              ),
            ),

            Positioned(
              top: 10,
              left: 10,
              child: Text(
                'Info\nGenerali',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700
                ),
              ),
            ),

            Positioned(
              right: 0,
              bottom: -30,
              child: CircleDecoration(
                width: 250,
                height: 250,
                offset: Offset(-2, -3),
                shadow: Colors.pinkAccent.shade100,
                gradientOne: Colors.pink.shade50,
                gradientTwo: Colors.pink.shade100,
              ),
            ),

            ListView(
              padding: EdgeInsets.fromLTRB(10, 120, 10, 10),
              children: [

                Text(
                  'Sesso?',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w500
                  ),
                ),

                SogniarioButton(
                    onPressed: () => setState(() => gender = 0),
                    child: Text('Uomo'),
                    gender: gender,
                    verified: 0,
                    background: Colors.blue.shade50,
                    overlay: Colors.blue.shade100
                ),

                SogniarioButton(
                    onPressed: () => setState(() => gender = 1),
                    child: Text('Donna'),
                    gender: gender,
                    verified: 1,
                    background: Colors.pink.shade50,
                    overlay: Colors.pink.shade100
                ),

                SizedBox(
                  height: 20,
                ),

                Text(
                  'Età?',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w500
                  ),
                ),

                SogniarioButton(
                    onPressed: () {
                      Picker(
                          adapter: PickerDataAdapter<String>(
                              pickerdata: JsonDecoder().convert(age),
                              isArray: true
                          ),
                          hideHeader: true,
                          selectedTextStyle: TextStyle(color: Colors.blue.shade500),
                          confirmText: 'Conferma',
                          confirmTextStyle: TextStyle(fontSize: 17, color: Colors.blue.shade500),
                          cancelTextStyle: TextStyle(fontSize: 17, color: Colors.blue.shade500),
                          title: Text('Età'),
                          onConfirm: (Picker picker, List value) {
                            setState(() {
                              dreamerAge = int.parse(picker.getSelectedValues()[0]);
                            });
                          }
                      ).showDialog(context);
                    },
                    child: Text('Seleziona'),
                    gender: 0,
                    verified: 0,
                    background: Colors.transparent,
                    overlay: Colors.grey.shade100
                ),

                dreamerAge != 0 ? Text(
                  'Età: $dreamerAge',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500
                  ),
                ) : Text(
                  'Nessun età selezionata!',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                SogniarioButton(
                    onPressed: () async {

                      if (dreamerAge == 0) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SogniarioAlert(
                                type: AlertDialogType.WARNING,
                                content: 'Inserire l\'età!',
                                buttonLabelDx: 'Ok',
                                onPressedDx: () => Navigator.pop(context),
                                onPressedSx: () => Navigator.pop(context),
                              );
                            });

                      } else {

                        bool registered = await dreamerApi.login(
                          Dreamer().firstLogin(), false
                        );

                        dreamerApi.setId();
                        registered = await dreamerApi.registered(
                            Dreamer(
                                id: dreamerApi.getId(),
                                sex: gender == 0 ? 'MALE' : 'FEMALE',
                                age: dreamerAge
                            )
                        );

                        registered = await dreamerApi.login(
                            Dreamer(id: dreamerApi.getId()).login(), false
                        );

                        if (registered) {
                          box.put('first_access', false);
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SogniarioAlert(
                                  type: AlertDialogType.ERROR,
                                  content: 'Problema con la registrazione!',
                                  buttonLabelDx: 'Ok',
                                  onPressedDx: () => Navigator.pop(context),
                                  onPressedSx: () => Navigator.pop(context),
                                );
                              });
                        }
                      }

                    },
                    child: Text('Conferma'),
                    gender: 0,
                    verified: 0,
                    background: Colors.transparent,
                    overlay: Colors.black12
                ),
              ]),

          ])
      ),
    );
  }

}

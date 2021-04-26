import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:frontend/models/dreamer.dart';
import 'package:frontend/services/rest_api/dreamer_api.dart';
import 'package:frontend/widgets/alert.dart';
import 'package:frontend/widgets/circle_decoration.dart';
import 'package:frontend/widgets/sogniario_button.dart';
import 'package:hive/hive.dart';


class GeneralInformation extends StatefulWidget {

  @override
  _GeneralInformationState createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {

  // 0 male, 1 female
  int gender = 0;
  DateTime year = DateTime.now();
  var box = Hive.box('data');
  DreamerApi dreamerApi;

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
                  'Data di nascita?',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w500
                  ),
                ),

                SogniarioButton(
                    onPressed: () async {
                      DateTime newDateTime = await showRoundedDatePicker(
                          context: context,
                          height: MediaQuery.of(context).size.height / 2 + 25,
                          initialDatePickerMode: DatePickerMode.year,
                          initialDate: DateTime(DateTime.now().year - 14),
                          firstDate: DateTime(DateTime.now().year - 80),
                          lastDate: DateTime(DateTime.now().year - 13),
                          theme: ThemeData(primarySwatch: Colors.grey),
                      );

                      setState(() => year = newDateTime);
                    },
                    child: Text('Seleziona'),
                    gender: 0,
                    verified: 0,
                    background: Colors.transparent,
                    overlay: Colors.grey.shade100
                ),

                year != null ? Text(
                  'Nato il: ${year.toString().substring(0, 10)}',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500
                  ),
                ) : Text(
                  'Nessuna data selezionata!',
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

                      if (year == null || year.year == DateTime.now().year) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SogniarioAlert(
                                content: 'Inserire la data di nascita!"',
                                buttonLabelDx: 'Ok',
                                onPressedDx: () => Navigator.pop(context),
                                onPressedSx: () => Navigator.pop(context),
                              );
                            });

                      } else {
                        box.put('first_access', false);
                        dreamerApi.setToken();

                        bool registered = await dreamerApi.registered(
                          Dreamer(
                            id: dreamerApi.getToken(),
                            sex: gender == 0 ? 'MALE' : 'FEMALE',
                            birthDate: year
                          )
                        );

                        if (registered) {
                          dreamerApi.setReminderChronotype();
                          dreamerApi.setReminderPSQI();
                          Navigator.pushNamed(context, '/home');

                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SogniarioAlert(
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

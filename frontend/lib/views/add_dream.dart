import 'package:flutter/material.dart';
import 'package:frontend/models/dream.dart';
import 'package:frontend/views/survey/survey_dream.dart';
import 'package:frontend/widgets/alert.dart';
import 'package:frontend/widgets/circle_decoration.dart';
import 'package:frontend/widgets/sogniario_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class AddDream extends StatefulWidget {

  @override
  _AddDreamState createState() => _AddDreamState();
}

class _AddDreamState extends State<AddDream> {

  TextEditingController dreamController;
  stt.SpeechToText speech;
  bool isListening = false;

  @override
  void initState() {
    dreamController = TextEditingController();
    speech = stt.SpeechToText();
    super.initState();
  }

  @override
  void dispose() {
    dreamController.dispose();
    super.dispose();
  }

  void listen() async {
    if (!isListening) {
      bool available = await speech.initialize();

      if (available) {
        setState(() => isListening = true);
        speech.listen(
          partialResults: false,
          onResult: (val) => setState(() {
            dreamController.text += val.recognizedWords;
            isListening = true;
          }),
        );
      }

    } else {
      setState(() => isListening = false);
      speech.stop();
    }
  }


  /*
  void listen() async {
    _available = await speech.initialize(
      onStatus: (val)=> print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );

    if(!_available) {
      setState(() {
      });
      return;
    }

    return speech.listen(
      listenFor: Duration(minutes: 10),
      pauseFor: Duration(seconds: 5),
      partialResults: false,
      onResult: (val) async {
        setState(() {
          isListening = true;
          dreamController.text += val.recognizedWords;
        });

        if (val.finalResult) {
          return await speech.stop();
        }

      },
    );
  }
   */

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [

              Positioned(
                top: -50,
                left: -30,
                child: CircleDecoration(
                  height: 200,
                  width: 200,
                  offset: Offset(2, 2),
                  shadow: Colors.green.shade300,
                  gradientOne: Colors.green.shade50,
                  gradientTwo: Colors.green.shade100,
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height / 3 + 30,
                right: 0,
                child: CircleDecoration(
                  height: 200,
                  width: 200,
                  offset: Offset(0, 0),
                  shadow: Colors.green.shade300,
                  gradientOne: Colors.green.shade50,
                  gradientTwo: Colors.green.shade100,
                ),
              ),

              ListView(
                  padding: EdgeInsets.all(10),
                  children: [

                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, size: 25),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                    SizedBox(
                        height: 10
                    ),

                    Text(
                      'Sogno',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500
                      ),
                    ),

                    SizedBox(height: 10),

                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: listen,
                      child: ListTile(
                        title: !isListening ? Text('Premi per parlare') : Text('In ascolto...'),
                        leading: Icon(
                          isListening ? Icons.mic_none_sharp : Icons.mic_off_rounded,
                          color: Colors.black87,
                          size: 26,
                        ),
                      ),
                    ),

                    SizedBox(height: 4),

                    TextField(
                      maxLines: 8,
                      controller: dreamController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87, width: 1.5),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          hintText: 'Cosa hai sognato?'
                      ),
                    ),

                    SogniarioButton(
                      child: Text('Salva'),
                      background: Colors.green.shade50.withOpacity(0.5),
                      overlay: Colors.green.shade50,
                      onPressed: () {

                        if (dreamController.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SogniarioAlert(
                                    content: "Non hai raccontato nessun sogno!",
                                    buttonLabel: 'Ok',
                                    type: AlertDialogType.INFO,
                                    onPressed: () => Navigator.pop(context));
                              });

                        } else {
                          FocusScope.of(context).unfocus();
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: SurveyDream(dream: Dream(dream: dreamController.text))
                              )
                          );
                        }

                      },
                    ),

                  ])
            ]),

        ),
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:frontend/common/constants.dart';
import 'package:frontend/models/dream.dart';
import 'package:frontend/views/survey/survey_dream.dart';
import 'package:frontend/widgets/alert.dart';
import 'package:frontend/widgets/circle_decoration.dart';
import 'package:frontend/widgets/sogniario_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'dart:async';
import 'dart:math';


class AddDream extends StatefulWidget {

  @override
  _AddDreamState createState() => _AddDreamState();
}

class _AddDreamState extends State<AddDream> {

  TextEditingController dreamController = TextEditingController();
  final SpeechToText speech = SpeechToText();

  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String _currentLocaleId = '';
  int resultListened = 0;

  @override
  void initState() {
    initSpeechState();
    super.initState();
  }

  @override
  dispose() {
    dreamController.dispose();
    super.dispose();
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0));
    if (hasSpeech) {
      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale?.localeId ?? '';
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
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
                top: -20,
                left: -20,
                child: CircleDecoration(
                  height: 200,
                  width: 200,
                  offset: Offset(2, 2),
                  shadow: Colors.blue.shade600,
                  gradientOne: Colors.blue.shade100,
                  gradientTwo: Colors.blue.shade200.withOpacity(0.8),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 20,
                right: -10,
                child: CircleDecoration(
                  height: 200,
                  width: 200,
                  offset: Offset(0, 0),
                  shadow: Colors.blue.shade700,
                  gradientOne: Colors.blue.shade50,
                  gradientTwo: Colors.blue.shade100,
                ),
              ),

              ListView(
                  padding: EdgeInsets.all(12),
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

                    SizedBox(
                      height: 18,
                    ),

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

                    SizedBox(
                      height: 2,
                    ),

                    SogniarioButton(
                      child: Text('Salva'),
                      background: Colors.blue.shade50.withOpacity(0.4),
                      overlay: Colors.blue.shade50.withOpacity(0.8),
                      onPressed: () {

                        if (dreamController.text.isEmpty || dreamController.text.split(' ').length < 3) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SogniarioAlert(
                                  content: dreamController.text.split(' ').length < 3 ? "Sogno troppo corto!" : "Non hai raccontato nessun sogno!",
                                  buttonLabelDx: 'Ok',
                                  type: AlertDialogType.INFO,
                                  onPressedDx: () => Navigator.pop(context),
                                  onPressedSx: () => Navigator.pop(context),
                                );
                              });

                        } else {
                          FocusScope.of(context).unfocus();
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: SurveyDream(dream: Dream(dream: deleteAccent(dreamController.text.trim())))
                              )
                          );
                        }

                      },
                    ),
                  ]),

              Positioned(
                bottom: 76,
                left: 12,
                right: 12,
                child: Center(
                  child: Text(
                    'Premi "Racconta" ed inizia a parlare!',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 18),
                  child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          TextButton(
                            onPressed: speech.isListening ? cancelListening : null,
                            child: Text('Cancella', style: TextStyle(fontSize: 17)),
                          ),

                          TextButton(
                            onPressed: !_hasSpeech || speech.isListening ? null : startListening,
                            child: Text(speech.isListening ? 'In ascolto..' : 'Racconta', style: TextStyle(fontSize: 17)),
                          ),

                        ]),
                  ),
                )
              )

            ]),
        )
      ),
    );
  }


  void startListening() {
    speech.listen(
        onResult: resultListener,
        listenFor: const Duration(seconds: 30),
        pauseFor: Duration(seconds: 5),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation
    );

    setState(() {});
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    ++resultListened;

    if (result.finalResult) {
      setState(() {
        if (dreamController.text.endsWith(' ')) {
          dreamController.text += result.recognizedWords;
        } else {
          dreamController.text += ' ' + result.recognizedWords;
        }
      });
    }
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);

    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    try {

    } catch (Exception) {
      speech.stop();
    }
  }

  void statusListener(String status) {

  }

}

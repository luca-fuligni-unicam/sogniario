import 'package:flutter/material.dart';
import 'package:frontend/widgets/circle_decoration.dart';
import 'package:frontend/widgets/sogniario_button.dart';
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

                    SizedBox(
                        height: 10
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

                    SogniarioButton(
                      child: Text('Salva'),
                      background: Colors.green.shade50.withOpacity(0.5),
                      overlay: Colors.green.shade50,
                      onPressed: () {

                      },
                    ),

                  ])
            ]),

        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [
            !isListening ? Text('Premi per parlare') : Text('In ascolto...'),
            SizedBox(width: 10),
            Icon(
              isListening ? Icons.mic_none_sharp : Icons.mic_off_rounded,
              color: Colors.black87,
              size: 26,
            ),

          ],
        ),
        backgroundColor: Colors.green.shade50,
        foregroundColor: Colors.black87,
        elevation: 2,
        onPressed: listen,
      )
    );
  }

}

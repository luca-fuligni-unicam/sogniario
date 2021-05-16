import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend/common/constants.dart';


class ScorePage extends StatefulWidget {

  final double score;

  ScorePage({
    this.score,
  });


  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100.withOpacity(0.6),
        title: Text('Punteggio MEQ', style: titleTextStyle),
        iconTheme: IconThemeData(color: Colors.black87.withOpacity(0.8)),
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.home, size: 30),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
              splashRadius: 1
          ),
          SizedBox(width: 4)
        ]),
      body: SafeArea(
        child: Stack(
          children: [

            Align(
              alignment: Alignment.topCenter,
              child: ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100.withOpacity(0.6),
                  ),
                  height: 120,
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: WaveClipperOne(reverse: true, flip: true),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100.withOpacity(0.6),
                  ),
                  height: 120,
                ),
              ),
            ),

            ListView(
              padding: EdgeInsets.only(left: 14, right: 14),
              children: [

                Text(
                  'I punteggi variano tra 16 - 86.\n'
                      'Punteggi minori di 41 indicano gufo, maggiori di 59 allodola, tra 42 e 58 fenotipo intermedio.',
                  style: TextStyle(fontSize: 17),
                ),

                SizedBox(
                    height: 16
                ),

                Text('Punteggio\n${widget.score}', style: TextStyle(fontSize: 22)),

                SizedBox(
                    height: 28
                ),

                Text(widget.score >= 42 && widget.score <= 58 ? '' : widget.score <= 41 ? 'Sei un gufo!' :
                        'Sei un allodola!',
                  style: TextStyle(fontSize: 18),
                ),

                SizedBox(
                    height: 6
                ),

                if (widget.score <= 41)
                  Center(
                    child: Image.asset('assets/owl.png', height: 160),
                  ),

                if (widget.score >= 42 && widget.score <= 58)
                  Text(
                    'Sei risultato un fenotipo intermedio.',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400)
                  ),

                if (widget.score >= 59)
                  Center(
                    child: Image.asset('assets/lark.jpg', height: 150),
                  ),

              ])
          ]),
      ),
    );
  }
}

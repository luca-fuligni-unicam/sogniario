import 'package:flutter/material.dart';
import 'package:widget_arrows/widget_arrows.dart';


class SmallGraph extends StatefulWidget {

  final Map<dynamic, dynamic> graph;

  SmallGraph({
    @required this.graph
  });


  @override
  _SmallGraphState createState() => _SmallGraphState();
}

class _SmallGraphState extends State<SmallGraph> {

  List<Color> colors = [
    Colors.deepOrange.shade200, Colors.deepOrange.shade700,
    Colors.green.shade200, Colors.green.shade600,
    Colors.red.shade200, Colors.red.shade700,
    Colors.yellow.shade200, Colors.yellowAccent.shade700,
    Colors.blue.shade200, Colors.blue.shade700,
  ];


  @override
  Widget build(BuildContext context) {

    return ArrowContainer(
      child: Scaffold(
          backgroundColor: Colors.white,

          body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [

                        for (int index = 0; index < widget.graph.keys.length; index++)
                          ArrowElement(
                            id: widget.graph.keys.toList()[index].toString(),
                            targetIds: List<String>.from(widget.graph[widget.graph.keys.toList()[index].toString()]),
                            color: (colors..shuffle()).first,
                            bow: 0.2,
                            child: Padding(
                                padding: EdgeInsets.only(top: 12, bottom: 12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black54, width: 1.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: EdgeInsets.all(2),
                                  child: Text('  ${widget.graph.keys.toList()[index]}  '),
                                )
                            ),
                            tipAngleOutwards: 0.6,
                          ),

                      ]),
                )
            ),
          )
      ),
    );
  }
}

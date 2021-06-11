import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/views/graph/report_graph.dart';
import 'package:widget_arrows/widget_arrows.dart';
import 'package:lazy_data_table/lazy_data_table.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:fluttericon/typicons_icons.dart';


class ReportGraphPage extends StatefulWidget {

  final ReportGraph _reportGraph;

  ReportGraphPage(this._reportGraph);

  ReportGraphPageState createState()=> ReportGraphPageState(_reportGraph);
}

class ReportGraphPageState extends State<ReportGraphPage>{

  LazyDataTable lazyTable;
  ReportGraph _reportGraph;
  double height = 30, width = 100, _s = 16;
  List<Color> colors = [
    Colors.deepOrange.shade200, Colors.deepOrange.shade700,
    Colors.green.shade200, Colors.green.shade600,
    Colors.red.shade200, Colors.red.shade700,
    Colors.yellow.shade200 , Colors.yellowAccent.shade700,
    Colors.blue.shade200, Colors.blue.shade700,
  ];

  ReportGraphPageState(this._reportGraph) {
    lazyTable = buildTable();
  }

  LazyDataTable buildTable() {
    return LazyDataTable(
        rows: _reportGraph.getCircle().getRows(),
        columns: _reportGraph.getCircle().getColumns(),
        tableDimensions: LazyDataTableDimensions(
          cellHeight: height,
          cellWidth: width,
        ),
        tableTheme: LazyDataTableTheme(
            alternateRow: false,
            alternateColumn: false,
            cellColor: Colors.white,
            cellBorder: Border.fromBorderSide(BorderSide(color: Colors.white)),
        ),
        dataCellBuilder: (row, column) {
          ReportGraphNode current = _reportGraph
              .getNodes()
              .firstWhere(
                  (n) => n.getCoordinate().getRow() == row && n.getCoordinate().getColumn() == column, orElse: () => null
          );

          return current == null ? Container() : createArrow(current);
        }
    );
  }


  ArrowElement createArrow(ReportGraphNode node) {
    List<ReportGraphNode> nodes = _reportGraph.getNodes();
    List<ReportGraphNode> list = [];
    node.getAdj().forEach((adj) {
      list.add(nodes.firstWhere((n) => n.getText() == adj));
    });

    return buildArrow(node, list, 0, null);
  }


  ArrowElement buildArrow(ReportGraphNode node, List<ReportGraphNode> list, int index, ArrowElement widget) {
    String from = node.getText() + (index == 0 ? '' : index.toString());

    if (index == list.length) {
      return ArrowElement(
          id: from,
          child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.all(2),
              child: buildNode(node)
          )
      );
    }

    ReportGraphNode to = list[index];
    List<Alignment> al = calculate(node.getCoordinate(), to.getCoordinate());

    return ArrowElement(
      id: from,
      color: (colors..shuffle()).first,
      bow: 0.2,
      sourceAnchor: al[0],
      targetId: to.getText(),
      targetAnchor: al[1],
      child: buildArrow(node, list, index + 1, widget),
    );
  }

  Widget buildNode(ReportGraphNode node) {
    return CentralText(node.getText(), _s, false);
  }

  List<Alignment> calculate(Coordinates node, Coordinates other) {
    int r = node.getRow();
    int c = node.getColumn();
    int rt = other.getRow();
    int ct = other.getColumn();

    // caso 1: stessa riga
    if (r == rt) {
      return c < ct ? [Alignment.centerRight, Alignment.centerLeft]
        : [
            Alignment.centerLeft,
            Alignment.centerRight
            ];
    }

    if (c == ct) {
      return r < rt ? [Alignment.bottomCenter, Alignment.topCenter]
        : [
            Alignment.topCenter,
            Alignment.bottomCenter
            ];
    }

    List<Alignment> align = [];
    if (r < rt)
      align.add(Alignment.bottomCenter);
    else
      align.add(Alignment.topCenter);

    if (c < ct)
      align.add(Alignment.centerLeft);
    else
      align.add(Alignment.centerRight);

    return align;
  }

  void _zoom(int index){
    if (index == 0) {
      if (height > 20)
        height -= 1;

      if (width > 40)
        width -= 5;

      if (_s > 8)
        _s -= 0.5;

    } else if (index == 2) {
      if (height < 30)
        height += 1;

      if (width < 110)
        width += 5;

      if (_s < 16)
        _s += 1;
    }

    setState(() {
      lazyTable = buildTable();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ArrowContainer(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
                height: MediaQuery.of(context).size.height - 200,
                child: lazyTable
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black54,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                label: "Diminuisci",
                icon: Icon(ModernPictograms.zoom_out, size: 30),
              ),
              BottomNavigationBarItem(
                label: "Riallinea",
                icon: Icon(Typicons.arrows_cw, size: 30),
              ),
              BottomNavigationBarItem(
                label: "Ingrandisci",
                icon: Icon(ModernPictograms.zoom_in, size: 30),
              )
            ],
            onTap: (index) => _zoom(index)
        )
    );
  }
}


class CentralText extends Text {
  CentralText(String text, double size, bool bold) : super(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: size, fontWeight: bold ? FontWeight.w600 : FontWeight.normal)
  );
}

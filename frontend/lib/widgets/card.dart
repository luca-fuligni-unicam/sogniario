import 'package:flutter/material.dart';
import 'divider.dart';


// ignore: must_be_immutable
class SogniarioCard extends StatelessWidget {

  String title;
  String listTileTitleOne;
  Icon listTileIconOne;
  GestureTapCallback listTileOnTapOne;

  String listTileTitleTwo;
  Icon listTileIconTwo;
  GestureTapCallback listTileOnTapTwo;

  SogniarioCard({
    this.title,
    this.listTileTitleOne,
    this.listTileIconOne,
    this.listTileOnTapOne,
    this.listTileTitleTwo,
    this.listTileIconTwo,
    this.listTileOnTapTwo,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.fromLTRB(15, 8, 15, 16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
          children: [

            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),

            SogniarioDivider(),

            ListTile(
              leading: listTileIconOne,
              title: Text(listTileTitleOne),
              onTap: listTileOnTapOne,
            ),

            SogniarioDivider(),

            ListTile(
              leading: listTileIconTwo,
              title: Text(listTileTitleTwo),
              onTap: listTileOnTapTwo,
            ),

          ]),
    );
  }
}

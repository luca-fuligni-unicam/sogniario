import 'package:flutter/material.dart';
import 'package:frontend/common/constants.dart';


class SogniarioAlert extends StatelessWidget {

  final String title;
  final String content;
  final AlertDialogType type;
  final String buttonLabelDx;
  final String buttonLabelSx;
  final VoidCallback onPressedDx;
  final VoidCallback onPressedSx;

  SogniarioAlert({
    this.title = "Info",
    @required this.content,
    this.type = AlertDialogType.INFO,
    this.buttonLabelDx = "Ok",
    this.buttonLabelSx = "Close",
    @required this.onPressedDx,
    @required this.onPressedSx
  });


  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        title,
                        style: titleTextStyle,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(width: 10.0),

                      Icon(
                        _getIconForType(type),
                        color: _getColorForType(type),
                        size: 35,
                      ),
                    ]),

                  SizedBox(height: 5),

                  Text(
                    content,
                    style: questionTextStyle,
                    textAlign: TextAlign.center,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3 + 10,
                        child: TextButton(
                          child: Text(buttonLabelSx),
                          onPressed: onPressedSx,
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3 + 10,
                        child: TextButton(
                          child: Text(buttonLabelDx),
                          onPressed: onPressedDx,
                        ),
                      ),

                    ])

                ]),
          ),
        )
    );
  }


  IconData _getIconForType(AlertDialogType type) {

    switch (type) {

      case AlertDialogType.WARNING:
        return Icons.warning;

      case AlertDialogType.SUCCESS:
        return Icons.check_circle;

      case AlertDialogType.ERROR:
        return Icons.error;

      case AlertDialogType.INFO:
      default:
        return Icons.info_outline;
    }
  }


  Color _getColorForType(AlertDialogType type) {

    switch (type) {

      case AlertDialogType.WARNING:
        return Colors.orange;

      case AlertDialogType.SUCCESS:
        return Colors.green;

      case AlertDialogType.ERROR:
        return Colors.red;

      case AlertDialogType.INFO:
      default:
        return Colors.blue.shade300;
    }
  }

}


enum AlertDialogType {
  SUCCESS,
  ERROR,
  WARNING,
  INFO,
}

import 'package:flutter/material.dart';


class SogniarioAlert extends StatelessWidget {

  final AlertDialogType type;
  final String title;
  final String content;
  final String buttonLabel;
  final VoidCallback onPressed;

  SogniarioAlert({
    this.title = "Info",
    @required this.content,
    this.type = AlertDialogType.INFO,
    this.buttonLabel = "Ok",
    @required this.onPressed
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
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600
                        ),
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
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3 + 10,
                        child: TextButton(
                          child: Text('Chiudi'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3 + 10,
                        child: TextButton(
                          child: Text(buttonLabel),
                          onPressed: onPressed,
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

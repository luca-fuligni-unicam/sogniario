import 'package:flutter/material.dart';


class Alert extends StatelessWidget {

  final AlertDialogType type;
  final String title;
  final String content;
  final String buttonLabel;

  Alert({
    this.title = "Info",
    required this.content,
    this.type = AlertDialogType.INFO,
    this.buttonLabel = "Ok"
  });

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.all(5.0),
  );

  
  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            constraints: BoxConstraints(maxWidth: 280),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Icon(
                    _getIconForType(type),
                    color: _getColorForType(type),
                    size: 40,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 4),

                  Text(
                    content,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: flatButtonStyle,
                      child: Text(buttonLabel),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ),

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
        return Colors.blue;
    }
  }

}



enum AlertDialogType {
  SUCCESS,
  ERROR,
  WARNING,
  INFO,
}

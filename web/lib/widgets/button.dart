import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class CustomButton extends StatelessWidget {

  final Widget child;
  final Icon icon;
  final GestureTapCallback onPressed;
  final Color color;

  const CustomButton({
    @required this.onPressed,
    @required this.child,
    @required this.icon,
    this.color = Colors.black,
  });


  @override
  Widget build(BuildContext context) {
    bool over = false;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MouseRegion(
            onHover: (event) => setState(() => over = true),
            onExit: (event) => setState(() => over = false),
            child: Container(
              decoration: BoxDecoration(
                  color: !over ? Colors.transparent : Colors.blue.shade50,
                  border: Border.all(color: Colors.blue.shade100, width: 1.5),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)
                  ),
              ),
              child: ListTile(
                trailing: icon,
                title: child,
                onTap: onPressed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          );
        }
    );
  }
}

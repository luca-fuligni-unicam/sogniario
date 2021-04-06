import 'package:flutter/material.dart';
import 'package:frontend/views/intro/intro_page.dart';
import 'package:hive/hive.dart';

import 'views/home.dart';


class InitialPage extends StatefulWidget {

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  @override
  Widget build(BuildContext context) {

    var box = Hive.box('data');
    bool firstAccess = box.get('first_access') ?? true;


    if (firstAccess) {
      return IntroPage();

    } else {
      return Home();
    }

    /*return StreamBuilder(
      builder: (context, snapshot) {

        /*if (snapshot.hasError)
          // TODO schermata di errore.
          return Text('Error');

        switch (snapshot.connectionState) {

          case ConnectionState.none:
            // TODO schermata di mancanza di accesso ad internet.

          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );

          case ConnectionState.active:
          case ConnectionState.done:
            return
        }

         */

        return IntroPage();
      },
    );*/

  }
}

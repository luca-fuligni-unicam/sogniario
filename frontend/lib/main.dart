import 'package:flutter/material.dart';
import 'package:frontend/services/routes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox('data');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sogniario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

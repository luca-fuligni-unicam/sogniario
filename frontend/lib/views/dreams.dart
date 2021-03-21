import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class Dreams extends StatefulWidget {

  @override
  _DreamsState createState() => _DreamsState();
}

class _DreamsState extends State<Dreams> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                labelPadding: EdgeInsets.all(10),
                indicatorColor: Colors.blue.shade300,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                tabs: [
                  text('Sogni'),
                  text('Nuvola dei Sogni'),
                ])
            ]),
        ),
        body: TabBarView(
          children: [
            MyDreams(),
            //Icon(Icons.home),
            Icon(Icons.settings_system_daydream),
          ]),
      ),
    );
  }


  Text text(String text) {
    return Text(
        text,
        style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            fontWeight: FontWeight.w600
        )
    );
  }

}


class MyDreams extends StatefulWidget {

  @override
  _MyDreamsState createState() => _MyDreamsState();
}

class _MyDreamsState extends State<MyDreams> {

  CalendarController _calendarController;


  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
    );
  }
}

/*
var time = await showTimePicker(
  context: context,
  initialTime: TimeOfDay(hour: 7, minute: 15),
);
*/

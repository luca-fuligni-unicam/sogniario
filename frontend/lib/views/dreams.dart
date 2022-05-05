import 'package:flutter/material.dart';
import 'package:frontend/common/constants.dart';
import 'package:frontend/models/dream.dart';
import 'package:frontend/services/rest_api/dream_api.dart';
import 'package:frontend/services/rest_api/report_api.dart';
import 'package:frontend/views/cloud/dream_cloud.dart';
import 'package:frontend/views/graph/graph_page.dart';
import 'package:frontend/views/graph/report_graph.dart';
import 'package:frontend/widgets/survey_card.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          elevation: 0,
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
              DreamsCloud()
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

  DateTime _dreamsDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    //_calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    //_calendarController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          TableCalendar(
            //calendarController: _calendarController,
            headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
                formatButtonTextStyle: TextStyle(color: Colors.white, fontSize: 16),
                formatButtonDecoration: BoxDecoration(color: Colors.white),
                leftChevronIcon: Icon(Icons.chevron_left_outlined, size: 28),
                rightChevronIcon: Icon(Icons.chevron_right_outlined, size: 28)
            ),
            //calendarStyle: CalendarStyle(
            //    weekdayStyle: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6)),
            //    selectedColor: Colors.blue[100],
            //    selectedStyle: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 17),
            //    todayColor: Colors.blue.shade300.withOpacity(0.8)
            // ),
            firstDay: DateTime.utc(2010,10,16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(_dreamsDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _dreamsDate = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),

          DreamsList(
            date: _dreamsDate.toString().substring(0, 10),
          )

        ]);
  }
}



// ignore: must_be_immutable
class DreamsList extends StatefulWidget {

  String date;

  DreamsList({
    this.date
  });


  @override
  _DreamsListState createState() => _DreamsListState();
}

class _DreamsListState extends State<DreamsList> {

  DreamApi dreamApi = DreamApi();
  ReportApi reportApi = ReportApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dreamApi.getDreams(widget.date),
        builder: (context, AsyncSnapshot<List<Dream>> data) {

          if (data.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );

          } else {

            if (data.data.isEmpty || data.data[0].id == null) {
              return Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                height: 170,
                child: NoSurvey(
                  child: Text(
                      data.data.isEmpty ? 'Nessun sogno registrato!' : 'Problemi nel vedere i sogni!',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.blue.shade300.withOpacity(0.8),
                      )
                  ),
                ),
              );
            }

            return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (var dreams in data.data)
                    dream(dreams)
                ]);

          }
        }
    );
  }

  Container dream(Dream dream) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              dream.registered.toString().substring(0, 19),
              style: TextStyle(
                  letterSpacing: 1.2,
                  color: Colors.black87.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
            ),

            SizedBox(height: 4),

            Text(
              insertAccent(dream.dream),
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54
              ),
            ),

            TextButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ReportGraphPage(ReportGraph(deleteAccent(dream.dream))))
                );
              },
              child: Text('Dettagli'),
            )

          ]),
    );
  }
}

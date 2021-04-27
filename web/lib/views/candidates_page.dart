import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


class CandidatesPage extends StatefulWidget {

  @override
  _CandidatesPageState createState() => _CandidatesPageState();
}

class _CandidatesPageState extends State<CandidatesPage> {

  final List<Map> candidates = [
    {
      'name': 'Flavio',
      'motivation': 'I want to participate in this initiative to study my patients.',
    },

    {
      'name': 'Giorgio',
      'motivation': 'I want to participate in this initiative to study my patients. I think is so cool! Can i partecipate pls?',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          SingleChildScrollView(
            child:Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                        "Candidates",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400
                        )
                    ),

                    Divider(
                      color: Colors.black54,
                      thickness: 1,
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: candidates.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildList(context, index);
                          }),
                    ),
                  ])
            ),
          ),

        ])
    );
  }


  Widget buildList(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 36),
                    children: [
                      TextSpan(text: 'Name: ', style: TextStyle(color: Colors.black87, fontSize: 14)),
                      TextSpan(text: candidates[index]['name'], style: TextStyle(fontSize: 14)),
                    ]),
                ),

                RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 36),
                      children: [
                        TextSpan(text: 'Motivation: ', style: TextStyle(color: Colors.black87, fontSize: 14)),
                        TextSpan(text: candidates[index]['motivation'], style: TextStyle(fontSize: 14)),
                      ]),
                ),

                SizedBox(height: 12),

                Container(
                  child: InkWell(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: IconButton(
                            icon: Icon(
                              Icons.check,
                              color: Colors.blue,
                              size: 18,
                            ),
                            onPressed: () {},
                          )
                        ),

                        SizedBox(width: 24),

                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.blue,
                              size: 18,
                            ),
                            onPressed: () {},
                          ),
                        ),

                      ]),
                  ),
                ),
              ]),
          )
        ]),
    );
  }

}

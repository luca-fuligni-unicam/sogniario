import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:web/models/nomination.dart';
import 'package:web/services/rest_api/nomination_api.dart';
import 'package:web/widgets/alert.dart';


class CandidatesPage extends StatefulWidget {

  @override
  _CandidatesPageState createState() => _CandidatesPageState();
}

class _CandidatesPageState extends State<CandidatesPage> {

  NominationApi nominationApi = NominationApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                      child: FutureBuilder(
                        future: nominationApi.nominations(),
                        builder: (context, data) {

                          if (data.data == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          else {

                            if (data.data.isEmpty) {
                              return Center(
                                child: SizedBox(
                                  height: 120,
                                  width: 360,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50.withOpacity(0.6),
                                      border: Border.all(color: Colors.blue.shade100, width: 1.5),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'No candidate!',
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    )
                                  ),
                                )
                              );
                            }

                            return ListView.builder(
                                itemCount: data.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Candidate(
                                    nomination: data.data[index],
                                    nominationApi: nominationApi,
                                  );
                                });
                          }

                        },
                      )
                    ),
                  ])
          ),
        ),
    );
  }
}



class Candidate extends StatefulWidget {

  final Nomination nomination;
  final NominationApi nominationApi;

  Candidate({
    this.nomination,
    this.nominationApi
  });


  @override
  _CandidateState createState() => _CandidateState();
}

class _CandidateState extends State<Candidate> {

  bool accept = false;

  @override
  Widget build(BuildContext context) {
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
                            TextSpan(text: widget.nomination.name, style: TextStyle(fontSize: 14)),
                          ]),
                    ),

                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 36),
                          children: [
                            TextSpan(text: 'Motivation: ', style: TextStyle(color: Colors.black87, fontSize: 14)),
                            TextSpan(text: widget.nomination.motivation, style: TextStyle(fontSize: 14)),
                          ]),
                    ),

                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 36),
                          children: [
                            TextSpan(text: 'Date: ', style: TextStyle(color: Colors.black87, fontSize: 13)),
                            TextSpan(text: widget.nomination.data.toString(), style: TextStyle(fontSize: 13)),
                          ]),
                    ),

                    SizedBox(height: 8),

                    !accept ? Container(
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
                                    onPressed: () async  {

                                      bool accepted = await widget.nominationApi.accept(widget.nomination.email);

                                      if (accepted) {
                                        setState(() => accept = true);
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return Alert(
                                                  type: AlertDialogType.SUCCESS,
                                                  content: 'Candidate accepted successfully!'
                                              );
                                            }
                                        );
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return Alert(
                                                  type: AlertDialogType.ERROR,
                                                  content: 'Problem with the candidate!'
                                              );
                                            }
                                        );
                                      }

                                    },
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
                                  onPressed: () async {

                                    bool rejected = await widget.nominationApi.reject(widget.nomination.email);

                                    if (rejected) {
                                      setState(() => accept = true);
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return Alert(
                                                type: AlertDialogType.SUCCESS,
                                                content: 'Candidate deleted successfully!'
                                            );
                                          }
                                      );

                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return Alert(
                                                type: AlertDialogType.ERROR,
                                                content: 'Problem with the candidate!'
                                            );
                                          }
                                      );
                                    }
                                  },
                                ),
                              ),
                            ]),
                      ),
                    ) : SizedBox(),
                  ]),
            )
          ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:frontend/services/rest_api/dreamer_api.dart';
import 'package:frontend/widgets/survey_card.dart';


class DreamsCloud extends StatefulWidget {

  @override
  _DreamsCloudState createState() => _DreamsCloudState();
}

class _DreamsCloudState extends State<DreamsCloud> {

  DreamerApi dreamerApi = DreamerApi();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: FutureBuilder(
        future: dreamerApi.getCloud(),
        builder: (context, AsyncSnapshot<Map<String, int>> data) {

          if (data.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (data.data.isEmpty) {
            return Center(
              child: NoSurvey(
                child: Text(
                    'Nuvola delle parole non presente!',
                    style: TextStyle(fontSize: 20, color: Colors.black54)
                ),
              ),
            );
          }

          return Center(
            child: Scatter(
                fillGaps: true,
                delegate: FermatSpiralScatterDelegate(
                  a: 2,
                  b: 2,
                ),
                children: [
                  for (int index = 0; index < data.data.keys.length; index++)
                    Text(
                        data.data.keys.toList()[index],
                        style: wordCloud(data.data.values.toList()[index])
                    ),
                ]),
          );
        },
      ),
    );
  }


  TextStyle wordCloud(int number) {
    switch (number) {
      case 1:
        return TextStyle(color: Colors.black54, fontSize: 17);

      case 2:
        return TextStyle(color: Colors.teal.shade400, fontSize: 18);

      case 3:
        return TextStyle(color: Colors.green.shade500, fontSize: 19);

      case 4:
        return TextStyle(color: Colors.indigoAccent.shade700, fontSize: 20);

      case 5:
        return TextStyle(color: Colors.deepOrangeAccent.shade400, fontSize: 21);

      default:
        return TextStyle(color: Colors.red.shade700, fontSize: 22);
    }
  }

}

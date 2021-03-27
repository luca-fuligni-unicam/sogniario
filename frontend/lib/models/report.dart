import 'completed_survey.dart';
import 'dream.dart';


class Report {

  final String id;
  final String dreamerId;
  final Dream dream;
  final CompletedSurvey completedSurvey;

  Report({
    this.id,
    this.dreamerId,
    this.dream,
    this.completedSurvey
  });


  Map<String, dynamic> dreamReport() => {
    'dreamerId': dreamerId,
    'dream': dream.dreamReport(),
    'completedSurvey': completedSurvey.completedSurvey()
  };

}


class CompletedSurvey {

  final String id;
  final List<String> answers;
  final String surveyId;
  final String dreamId;

  CompletedSurvey({
    this.id,
    this.answers,
    this.surveyId,
    this.dreamId
  });


  Map<String, dynamic> completedSurvey() => {
    'surveyId': surveyId,
    'answers': answers,
  };

}

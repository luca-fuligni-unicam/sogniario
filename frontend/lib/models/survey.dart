
class Survey {

  final String id;
  final Map<String, dynamic> questions;

  Survey({
    this.id,
    this.questions
  });


  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
        id: json['id'],
        questions: json['questions']
    );
  }

}

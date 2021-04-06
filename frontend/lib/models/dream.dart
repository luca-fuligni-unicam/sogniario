
class Dream {

  final String id;
  final String dream;
  final DateTime registered;

  Dream({
    this.id,
    this.dream,
    this.registered,
  });


  // TODO vedere se inserire completedSurvey per vedere il questionario compilato per quel sogno.
  factory Dream.fromJson(Map<String, dynamic> json) {
    return Dream(
      id: json['id'],
      dream: json['dream']['text'],
      registered: DateTime.parse(json['dream']['data'])
    );
  }

  Map<String, dynamic> dreamReport() => {
    'text': dream,
    'data': DateTime.now().toString().substring(0, 19)
  };

}

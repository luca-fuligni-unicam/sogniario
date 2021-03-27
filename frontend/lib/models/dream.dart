
class Dream {

  final String id;
  final String dream;
  final DateTime registered;

  Dream({
    this.id,
    this.dream,
    this.registered,
  });


  factory Dream.fromJson(Map<String, dynamic> json) {
    return Dream(
      id: json['id'],
      dream: json['text'],
      registered: DateTime.parse(json['registered'])
    );
  }

  Map<String, dynamic> dreamReport() => {
    'text': dream,
  };

}

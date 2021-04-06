
class Dreamer {

  final String id;
  final String sex;
  final DateTime birthDate;

  Dreamer({
    this.id,
    this.sex,
    this.birthDate
  });


  Map<String, dynamic> registered() => {
    'id': id,
    'completedSurveys': [],
    'nascita': birthDate.toString().substring(0, 10),
    'sesso': sex,
  };

}

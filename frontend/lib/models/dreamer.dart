
class Dreamer {

  final String id;
  final String sex;
  final DateTime birthDate;

  Dreamer({
    this.id,
    this.sex,
    this.birthDate
  });


  Map<String, dynamic> login() => {
    'username': id,
    'password': id,
  };

  Map<String, dynamic> firstLogin() => {
    'username': 'guest_dreamer',
    'password': 'guest_dreamer',
  };

  Map<String, dynamic> registered() => {
    'username': id,
    'password': id,
    'nascita': birthDate.toString().substring(0, 10),
    'sesso': sex,
  };

}

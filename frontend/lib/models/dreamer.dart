
class Dreamer {

  final String id;
  final String sex;
  final int age;

  Dreamer({
    this.id,
    this.sex,
    this.age
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
    'eta': age.toString(),
    'sesso': sex,
  };

}

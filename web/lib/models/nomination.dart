
class Nomination {

  final String name;
  final String email;
  final String? password;
  final String motivation;
  final DateTime? data;

  Nomination({
    required this.name,
    required this.email,
    this.password,
    required this.motivation,
    this.data,
  });


  factory Nomination.fromJson(Map<String, dynamic> json) {
    return Nomination(
      name: json['name'],
      email: json['email'],
      motivation: json['motivazione'],
      data: DateTime.parse(json['data'])
    );
  }

  Map<String, dynamic> login() => {
    'username': email,
    'password': password,
  };
  
  Map<String, String> registered() => {
    'name': name,
    'email': email,
    'password': password!,
    'motivazione': motivation
  };

}

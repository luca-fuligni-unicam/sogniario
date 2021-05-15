
class Researcher {

  final String name;
  final String email;

  Researcher({
    this.name,
    this.email,
  });


  Map<String, String> firstLogin() => {
    'username': 'guest_researcher',
    'password': 'guest_researcher',
  };

}

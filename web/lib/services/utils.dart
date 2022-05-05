import 'package:crypt/crypt.dart';
import 'package:hive/hive.dart';

class Utils {
  final String server = 'http://193.205.92.106:8080/';
  //final String server = 'http://localhost:8080/';
  var box = Hive.box('data');

  Map<String, String> header(String token) => {
        'Authorization': token,
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Cache-Control': 'no-cache',
        'Accept-Encoding': 'gzip, deflate, br',
      };

  Map<String, String> headerFirstAccess = {
    'Content-Type': 'application/json',
    'Access-Control-Expose-Headers': '*',
    'Accept': '*/*',
    'Access-Control-Allow-Origin': '*',
  };

  String getToken() {
    return box.get('token');
  }

  void setToken(String? token) {
    box.put('token', token);
  }

  String sha512Encrypt(String password) {
    return Crypt.sha512(password, rounds: 21841, salt: 'gg_m4n_g00d_g4m3!!')
        .toString()
        .substring(40);
  }
}

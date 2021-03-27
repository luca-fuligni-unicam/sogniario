import 'package:crypt/crypt.dart';
import 'package:hive/hive.dart';

import 'dart:convert';
import 'dart:math';


class Utils {

  final String server = 'http://193.205.92.106:8080/';
  var box = Hive.box('data');


  Map<String, String> header(String token) => {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept',
    'Access-Control-Allow-Methods': 'OPTIONS, DELETE, POST, GET, PUT',
    'token': token
  };


  String getToken() {
    return box.get('token');
  }

  void setToken() {
    var random = Random.secure();
    var values = List<int>.generate(20, (i) =>  random.nextInt(255));

    box.put('token', Crypt.sha512(base64UrlEncode(values), rounds: 8412, salt: 'b3st_s4lt_3v3r')
        .toString()
        .substring(30, 60));
  }

}

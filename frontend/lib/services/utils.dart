import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';


class Utils {

  final String server = 'http://193.205.92.106:8080/';
  var box = Hive.box('data');
  var uuid = Uuid();


  Map<String, String> header = {
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept',
    'Access-Control-Allow-Methods': 'OPTIONS, DELETE, POST, GET, PUT',
    'Access-Control-Allow-Origin': '*',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };


  String getToken() {
    return box.get('token');
  }

  void setToken() {
    box.put('token', uuid.v1());
  }

}

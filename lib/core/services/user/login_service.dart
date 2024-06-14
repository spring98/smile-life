import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

import 'common_service.dart';

class LoginService {
  final DatabaseReference _loginRef = FirebaseDatabase.instance.ref('users');

  Future<String> login() async {
    DatabaseEvent value = await _loginRef.child(Session.phone).once();

    print(value.snapshot.value);
    if (value.snapshot.value == null) {
      return 'fail';
    } else {
      Map<dynamic, dynamic> user = value.snapshot.value as Map;

      if (Session.pw == user['password'].toString()) {
        return 'success';
      } else {
        return 'fail';
      }
    }

    /// 계속 사용하게될 json (map)
    // Map<dynamic, dynamic> user = value.snapshot.value as Map;
    // List<dynamic> userKeyList = user.keys.toList();
    // for (int i = 0; i < user.length; i++) {
    //   print(user[userKeyList[i]]);
    // }

    // List<TestModel> _testModel = [];
    // _testModel.add(TestModel.fromJson(user));
    // print('22222222');
    // print(_testModel[0].phone2);

    if (value.snapshot.value == null) {
      return 'fail';
    } else {
      return 'success';
    }
  }

  Future<String> autoLogin(String id, String pw) async {
    DatabaseEvent value = await _loginRef.child(id).once();

    print(value.snapshot.value);
    Map<dynamic, dynamic> user = value.snapshot.value as Map;

    if (pw == user['password'].toString()) {
      return 'success';
    } else {
      return 'fail';
    }
  }

  Future<List<dynamic>> fetchUser() async {
    String url = Session.BASEURL + 'user-info';
    http.Response response = await http.get(
      Uri.parse(Uri.encodeFull(url)),
      headers: Session.headers,
    );
    print(jsonDecode(response.body));
    return jsonDecode(response.body)['result'];
  }
}

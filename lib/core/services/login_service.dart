import 'dart:convert';
import 'package:http/http.dart' as http;
import 'common_service.dart';

class LoginService {
  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      Session.headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  Future<String> login() async {
    /// id pw 는 getUserInfo 에서 모델에 넣기로 하고 로그인 할때는 Session.id/pw 사용하자.
    print('===================login IN====================');
    String url = Session.BASEURL + 'login';

    var data = {'user_id': Session.id, 'password': Session.pw};
    var body = json.encode(data);

    http.Response response = await http.post(
      Uri.parse(Uri.encodeFull(url)),
      headers: Session.headers,
      body: body,
    );

    updateCookie(response);
    print(response.body);
    return jsonDecode(response.body)['status'];
  }

  Future<String> autoLogin(String id, String pw) async {
    /// id pw 는 getUserInfo 에서 모델에 넣기로 하고 로그인 할때는 Session.id/pw 사용하자.
    print('===================login IN====================');
    String url = Session.BASEURL + 'login';

    var data = {'user_id': id, 'password': pw};
    var body = json.encode(data);

    http.Response response = await http.post(
      Uri.parse(Uri.encodeFull(url)),
      headers: Session.headers,
      body: body,
    );

    updateCookie(response);
    return jsonDecode(response.body)['status'];
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

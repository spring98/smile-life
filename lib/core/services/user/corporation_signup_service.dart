import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'common_service.dart';

class CorporationSignupService {
  Future<String> sendSMS(String phone) async {
    String url = Session.BASEURL + 'sms/send?phoneNumber=$phone';
    http.Response response = await http.get(
      Uri.parse(Uri.encodeFull(url)),
      headers: Session.headers,
    );

    print(jsonDecode(response.body));
    return jsonDecode(response.body)['status'];
  }

  Future<String> verifySMS(String phone, String phoneCode) async {
    String url =
        Session.BASEURL + 'sms/verify?phoneNumber=$phone&verifyCode=$phoneCode';

    http.Response response = await http.get(
      Uri.parse(Uri.encodeFull(url)),
      headers: Session.headers,
    );
    return jsonDecode(response.body)['status'];
  }

  Future<String> checkID(String id) async {
    String url = Session.BASEURL + 'check-id?userid=$id';
    http.Response response = await http.get(
      Uri.parse(Uri.encodeFull(url)),
      headers: Session.headers,
    );

    return jsonDecode(response.body)['status'];
  }

  Future<String> signup(
      String id, String pw, String name, String phone, String division) async {
    String url = Session.BASEURL + 'join';

    var data = {
      'userid': id,
      'password': pw,
      'username': name,
      'division': division,
      'phoneNumber': phone,
    };
    var body = json.encode(data);

    http.Response response = await http.post(
      Uri.parse(Uri.encodeFull(url)),
      headers: Session.headers,
      body: body,
    );

    print(response.body);
    print(response.request);
    return jsonDecode(response.body)['status'];
  }
}

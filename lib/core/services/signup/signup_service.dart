import 'dart:convert';
import 'package:http/http.dart' as http;
import '../common_service.dart';

class SignupService {
  Future<String> sendSMS(String phone) async {
    String url = Session.BASEURL + 'send/sms?phone_number=$phone';
    http.Response response = await http.get(
      Uri.parse(Uri.encodeFull(url)),
      headers: Session.headers,
    );
    print(jsonDecode(response.body));
    return jsonDecode(response.body)['status'];
  }

  Future<String> verifySMS(String phone, String phoneCode) async {
    String url = Session.BASEURL +
        'verify/sms?phone_number=$phone&verify_code=$phoneCode';

    http.Response response = await http.get(
      Uri.parse(Uri.encodeFull(url)),
      headers: Session.headers,
    );
    return jsonDecode(response.body)['status'];
  }

  Future<String> checkID(String id) async {
    String url = Session.BASEURL + 'check/id?user_id=$id';
    http.Response response = await http.get(
      Uri.parse(Uri.encodeFull(url)),
      headers: Session.headers,
    );
    print(jsonDecode(response.body));
    return jsonDecode(response.body)['status'];
  }

  Future<String> signup(String id, String pw, String name, String phone,
      String division, String position) async {
    String url = Session.BASEURL + 'join';

    var data = {
      'user_id': id,
      'password': pw,
      'user_name': name,
      'division': division,
      'position': position,
      'phone_number': phone,
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

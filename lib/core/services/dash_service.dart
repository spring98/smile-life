// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'common_service.dart';
//
// class DashService {
//   Future<List<dynamic>> fetchDash() async {
//     String url = Session.BASEURL + 'dash-info';
//     http.Response response = await http.get(
//       Uri.parse(Uri.encodeFull(url)),
//       headers: Session.headers,
//     );
//     print('dash-info : ${response.body}');
//     print(json.decode(response.body)['result']);
//     return json.decode(response.body)['result'];
//   }
// }

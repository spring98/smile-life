import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smile_life/core/view_model/login_view_model.dart';

final secureStorage = FlutterSecureStorage();
void setProfileUrl(String loginData) async {
  final String key = 'loginData';
  final String value = loginData;

  await secureStorage.write(
    key: key,
    value: value,
  );
}

Future<void> getProfileUrl() async {
  final getData = await secureStorage.read(key: 'loginData');
  if (getData != null) {
    String id = getData.split(' ')[0];
    String pw = getData.split(' ')[1];
    // state = getData.split(' ')[2];
    // state == 'login'
    LoginViewModel().autoLogin(id, pw);
  }
}

/// 로그아웃
/// setProfileUrl(Session.id + ' ' + Session.pw + ' ' + 'login');

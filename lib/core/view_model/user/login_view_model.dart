import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:smile_life/core/services/user/common_service.dart';
import 'package:smile_life/core/services/user/login_service.dart';
import 'package:smile_life/utils/login_secure.dart';
import 'package:smile_life/utils/constants/kAlert.dart';
import 'package:smile_life/view/02_Home/home.dart';

class LoginViewModel extends GetxController {
  final LoginService _loginService = LoginService();
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();

  int flex = 40;
  bool idFlag = false;
  bool pwFlag = false;
  bool finalFlag = false;
  bool autoLoginFlag = false;

  @override
  void onInit() {
    super.onInit();
    getProfileUrl();
    keyboardInit();
  }

  @override
  void onClose() {
    super.onClose();
    idController.dispose();
    pwController.dispose();
  }

  void keyboardInit() {
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (visible == false) {
        flex = 40;
      } else {
        flex = 0;
      }
      update();
    });
  }

  void setFlex(int value) {
    flex = value;
    update();
  }

  void idCheck(String id) {
    if (id.length > 3 && id.length < 16) {
      idFlag = true;
      Session.phone = id;
    } else {
      idFlag = false;
    }
    finalCheck();
    update();
  }

  void pwCheck(String pw) {
    if (pw.length > 7 && pw.length < 13) {
      pwFlag = true;
      Session.pw = pw;
    } else {
      pwFlag = false;
    }
    finalCheck();
    update();
  }

  void finalCheck() {
    if (idFlag && pwFlag) {
      finalFlag = true;
    } else {
      finalFlag = false;
    }
    update();
  }

  void autoLoginCheck() {
    autoLoginFlag = !autoLoginFlag;
    update();
  }

  Future<void> autoLogin(String id, String pw) async {
    String result = await _loginService.autoLogin(id, pw);

    if (result == 'success') {
      Get.to(() => Home());
    } else {}
    update();
  }

  Future<void> login() async {
    alertLoading();
    String result = await _loginService.login();
    Get.back();

    if (result == 'success') {
      if (autoLoginFlag == true) {
        setProfileUrl(Session.phone + ' ' + Session.pw + ' ' + 'login');
      }
      // Session.phone = '';
      // Session.pw = '';
      Get.to(() => const Home());
    } else {
      alert('로그인 실패');
    }

    update();
  }
}

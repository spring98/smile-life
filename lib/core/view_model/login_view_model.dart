import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:smile_life/core/services/common_service.dart';
import 'package:smile_life/core/services/login_service.dart';
import 'package:smile_life/utils/login_secure.dart';
import 'package:smile_life/utils/constants/kAlert.dart';

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
      Session.id = id;
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

  void autoLogin(String id, String pw) {
    _loginService.autoLogin(id, pw).then((value) {
      if (value == 'fail') {
        // alert();
        // alert('자동로그인에 실패하였습니다.');
      } else {
        // Get.to(Home());
        // Get.to(RegionList());
      }
      // _loading.value = false;
      update();
    });
  }

  void login() {
    _loginService.login().then((value) {
      if (value == 'fail') {
        alert('로그인 실패');
      } else {
        if (autoLoginFlag == true) {
          setProfileUrl(Session.id + ' ' + Session.pw + ' ' + 'login');
        }
        Session.id = '';
        Session.pw = '';
        // Get.to(Home());
        // Get.to(RegionList());
      }
      // _loading.value = false;
      update();
    });
  }
}

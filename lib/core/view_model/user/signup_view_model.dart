import 'package:get/get.dart';
import 'package:smile_life/core/services/user/signup_service.dart';
import 'package:smile_life/view/01_Login/login.dart';
import 'package:smile_life/utils/constants/kAlert.dart';

class SignupViewModel extends GetxController {
  /// Signup Service
  final SignupService _signupService = SignupService();

  /// 자리수 확인하는 임시 플래그
  bool phoneTempFlag = false;

  String pwCompared = '';

  /// 최종 플래그
  bool pwFlag = false;
  bool pwConfirmFlag = false;
  bool nameFlag = false;
  bool phoneFlag = false;
  bool finalFlag = false;

  /// 회원가입 멤버필드
  String pw = '';
  String name = '';
  String phone = '';

  /// 자리수 체크 메소드
  void pwCheck(String pw) {
    if (pw.length > 7 && pw.length < 13) {
      pwCompared = pw;
      pwFlag = true;

      // pwConfirm 에만 하기로 함.
    } else {
      pwFlag = false;
    }
    finalCheck();
    update();
  }

  void pwConfirmCheck(String pwConfirm) {
    if (pwConfirm.length > 7 &&
        pwConfirm.length < 13 &&
        pwConfirm == pwCompared) {
      pwConfirmFlag = true;

      // 정상값 멤버필드에 저장
      pw = pwConfirm;
      print(pw);
    } else {
      pwConfirmFlag = false;
    }
    finalCheck();
    update();
  }

  void nameCheck(String name) {
    if (name.isNotEmpty) {
      nameFlag = true;

      // 정상값 멤버필드에 저장
      this.name = name;
    } else {
      nameFlag = false;
    }
    finalCheck();
    update();
  }

  void phoneAvailable(String phone) {
    if (phone.isNum && phone.length == 11) {
      phoneTempFlag = true;

      // 정상값 멤버필드에 저장
      this.phone = phone;
    } else {
      phoneTempFlag = false;
    }
    finalCheck();
    update();
  }

  /// 전화번호 중복검사 메소드
  Future<void> checkPhone() async {
    alertLoading();
    String result = await _signupService.checkPhone(phone);
    Get.back();
    if (result == 'success') {
      phoneFlag = true;
      alert('사용가능한 전화번호 입니다.');
    } else {
      phoneFlag = false;
      alert('이미 사용중인 전화번호 입니다.');
    }

    update();
  }

  /// 최종 플래그 확인 메소드
  void finalCheck() {
    if (pwFlag && pwConfirmFlag && nameFlag && phoneFlag) {
      finalFlag = true;
    } else {
      finalFlag = false;
    }

    update();
  }

  /// 회원가입 메소드
  Future<void> signup() async {
    if (await alertYesOrNo('회원가입을 하시겠습니까?') == 'yes') {
      await _signupService.signup(pw, name, phone);
      if (await alert('회원가입에 성공하였습니다.') == 'yes') {
        Get.back();
      }
    }
    update();
  }
}

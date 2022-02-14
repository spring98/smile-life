import 'package:get/get.dart';
import 'package:smile_life/core/services/signup/signup_service.dart';
import 'package:smile_life/view/01_Login/login.dart';
import 'package:smile_life/utils/constants/kAlert.dart';

class SignupViewModel extends GetxController {
  /// Signup Service
  final SignupService _signupService = SignupService();

  /// 자리수 확인하는 임시 플래그
  bool idTempFlag = false;
  bool phoneTempFlag = false;
  bool codeTempFlag = false;

  String pwCompared = '';

  /// 최종 플래그
  bool idFlag = false;
  bool pwFlag = false;
  bool pwConfirmFlag = false;
  bool nameFlag = false;
  bool divisionFlag = false;
  bool rankFlag = false;
  bool codeFlag = false;
  bool finalFlag = false;

  bool sendSMSFlag = false;

  /// 회원가입 멤버필드
  bool isPersonalSignup = true;
  String id = '';
  String pw = '';
  String name = '';
  String phone = '';
  String division = '';
  String rank = '';
  String phoneCode = '';

  /// 자리수 체크 메소드
  void idAvailable(String id) {
    if (id.length > 3 && id.length < 16) {
      idTempFlag = true;

      // 정상값 멤버필드에 저장
      this.id = id;
    } else {
      idTempFlag = false;
    }
    finalCheck();
    update();
  }

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

  void divisionCheck(String division) {
    if (division.isNotEmpty) {
      divisionFlag = true;

      // 정상값 멤버필드에 저장
      this.division = division;
    } else {
      divisionFlag = false;
    }
    finalCheck();
    update();
  }

  void rankCheck(String rank) {
    if (rank.isNotEmpty) {
      rankFlag = true;

      // 정상값 멤버필드에 저장
      this.rank = rank;
    } else {
      rankFlag = false;
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

  void codeAvailable(String code) {
    if (code.isNum && code.length == 6) {
      codeTempFlag = true;

      // 정상값 멤버필드에 저장
      phoneCode = code;
    } else {
      codeTempFlag = false;
    }
    finalCheck();
    update();
  }

  /// 아이디 중복 검사 메소드
  Future<void> idCheck() async {
    String result = await _signupService.checkID(id);
    if (result == 'success') {
      idFlag = true;
      alert('사용가능한 아이디입니다.');
    } else {
      idFlag = false;
      alert('이미 사용중인 아이디입니다.');
    }
    finalCheck();
    update();
  }

  /// 전화번호 인증코드 발송 메소드
  Future<void> sendSMS() async {
    String result = await _signupService.sendSMS(phone);
    if (result == 'success') {
      sendSMSFlag = true;
      alert('인증코드를 발송했습니다.');
    } else {
      sendSMSFlag = false;
      alert('인증코드 발송에 실패하였습니다.');
    }

    update();
  }

  /// 전화번호 인증코드 검증 메소드
  Future<void> verifySMS() async {
    String result = await _signupService.verifySMS(phone, phoneCode);
    if (result == 'success') {
      codeFlag = true;
      alert('휴대폰 인증에 성공하였습니다.');
    } else {
      codeFlag = false;
      alert('휴대폰 인증에 실패하였습니다.');
    }

    finalCheck();
    update();
  }

  /// 전화번호 인증코드 검증 메소드
  Future<void> signup() async {
    String result =
        await _signupService.signup(id, pw, name, phone, division, rank);
    if (result == 'success') {
      String alertResponse = await alert('회원가입에 성공하였습니다.');
      if (alertResponse == 'yes') {
        Get.offAll(Login());
      }
    } else {
      alert('회원가입에 실패하였습니다.');
    }
    update();
  }

  /// 최종 플래그 확인 메소드
  void finalCheck() {
    if (idFlag &&
        pwFlag &&
        pwConfirmFlag &&
        nameFlag &&
        divisionFlag &&
        rankFlag &&
        codeFlag) {
      finalFlag = true;
    } else {
      finalFlag = false;
    }
    update();
  }

  /// 개인가입인지 법인가입인지 구분
  void setPersonal() {
    isPersonalSignup = true;
    update();
  }

  void setCorporation() {
    isPersonalSignup = false;
    update();
  }
}

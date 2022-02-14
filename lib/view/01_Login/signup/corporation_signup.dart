// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smile_life/core/view_model/corporation_signup_view_model.dart';
import 'package:smile_life/utils/constants/kButton.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:smile_life/utils/constants/kTextField.dart';

class CorporationSignup extends StatefulWidget {
  const CorporationSignup({Key? key}) : super(key: key);

  @override
  _CorporationSignupState createState() => _CorporationSignupState();
}

class _CorporationSignupState extends State<CorporationSignup> {
  final corporationSignupViewModel = Get.put(CorporationSignupViewModel());
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _titleLabel('아이디'),
        _textFieldAndButton(
          textFieldTag: '아이디',
          textFieldHint: '4~15자 영문, 숫자 조합으로 입력',
          buttonTag: '중복확인',
          buttonHint: '중복확인',
        ),
        SizedBox(height: 15.h),
        _titleLabel('비밀번호'),
        _textFieldAndButton(
          textFieldTag: '비밀번호',
          textFieldHint: '8~12자 영문, 숫자, 특수문자 조합으로 입력',
        ),
        SizedBox(height: 15.h),
        _titleLabel('비밀번호 확인'),
        _textFieldAndButton(
          textFieldTag: '비밀번호 확인',
          textFieldHint: '8~12자 영문, 숫자, 특수문자 조합으로 입력',
        ),
        SizedBox(height: 15.h),
        _titleLabel('상호명(법인명)'),
        _textFieldAndButton(
          textFieldTag: '상호명(법인명)',
          textFieldHint: '입력해주세요.',
        ),
        SizedBox(height: 15.h),
        _titleLabel('사업자 인증'),
        _textFieldAndButton(
            textFieldTag: '사업자 인증',
            textFieldHint: '사업자등록증을 첨부해주세요.',
            buttonTag: '사업자 인증',
            buttonHint: '사진등록'),
        SizedBox(height: 15.h),
        _titleLabel('전화번호'),
        _textFieldAndButton(
          textFieldTag: '전화번호',
          textFieldHint: '\'-\' 제외하고 입력',
        ),
        SizedBox(height: 50.h),
        _bottomButton('회원가입')
      ],
    );
  }

  Widget _titleLabel(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 25.w),
      child: Text(title, style: k14w500.copyWith(color: kColorPrimary)),
    );
  }

  Widget _textFieldAndButton({
    required String textFieldTag,
    required String textFieldHint,
    String? buttonTag,
    String? buttonHint,
  }) {
    return GetBuilder<CorporationSignupViewModel>(
      builder: (_) {
        bool _readOnly = false;
        bool _obscure = false;
        bool _showButton = false;
        var _onChanged = (text) => print('onChanged');
        var _onTap = () => print('onTap');
        Color _color = kColorHint;

        /// read only
        if ((buttonTag == '중복확인') && (_.idFlag)) {
          _readOnly = true;
        }

        if ((buttonTag == '인증번호 발송') && (_.sendSMSFlag)) {
          _readOnly = true;
        }

        /// onChanged + show button
        switch (textFieldTag) {
          case '아이디':
            _onChanged = (text) => _.idAvailable(text);
            _showButton = true;
            if (_.idTempFlag) {
              _onTap = () async => _.idCheck();
              _color = Colors.white;
            }
            break;
          case '비밀번호':
            _onChanged = (text) => _.pwCheck(text);
            _obscure = true;
            break;
          case '비밀번호 확인':
            _onChanged = (text) => _.pwConfirmCheck(text);
            _obscure = true;
            break;
          case '상호명(법인명)':
            _onChanged = (text) => _.nameCheck(text);
            break;
          case '사업자 인증':
            _showButton = true;
            _onTap = () async => getPicker();
            _color = Colors.white;
            break;
        }

        return SizedBox(
          height: 40.h,
          child: Row(
            children: [
              Expanded(
                child: GetBuilder<CorporationSignupViewModel>(
                  builder: (_) => Container(
                    margin: EdgeInsets.only(left: 25.w, right: 25.w),
                    height: 40.h,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: TextFormField(
                        readOnly: _readOnly,
                        onChanged: _onChanged,
                        obscureText: _obscure,
                        decoration: kTextFieldUnderLine(textFieldHint).copyWith(
                          hintStyle: k12w400.copyWith(color: kColorHint),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showButton) ...[
                GestureDetector(
                  onTap: _onTap,
                  child: Container(
                    margin: EdgeInsets.only(right: 25.w),
                    alignment: Alignment.center,
                    decoration: kButtonRound().copyWith(color: kColorPrimary),
                    height: 30.h,
                    width: 90.w,
                    child: Text(
                      buttonHint!,
                      style: k12w400.copyWith(color: _color),
                    ),
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }

  Widget _bottomButton(String buttonText) {
    return GetBuilder<CorporationSignupViewModel>(
      builder: (_) {
        var _onTap = () => print('onTap');
        Color _color = kColorHint;
        if (_.finalFlag) {
          // _onTap = () async => _.signup();
          _color = kColorPrimary;
        }
        return GestureDetector(
          onTap: _onTap,
          child: Container(
            height: 40.h,
            alignment: Alignment.center,
            color: kColorPrimary,
            child: Text(
              buttonText,
              style: k14w500.copyWith(color: _color),
            ),
          ),
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         _titleLabel('아이디'),
  //         _textFieldAndButton('4~15자 영문, 숫자 조합으로 입력', '중복확인'),
  //         SizedBox(height: 15.h),
  //         _titleLabel('비밀번호'),
  //         _textField('8~12자 영문, 숫자, 특수문자 조합으로 입력'),
  //         SizedBox(height: 15.h),
  //         _titleLabel('비밀번호 확인'),
  //         _textField('8~12자 영문, 숫자, 특수문자 조합으로 입력 '),
  //         SizedBox(height: 15.h),
  //         _titleLabel('상호명(법인명)'),
  //         _textField('입력해주세요'),
  //         SizedBox(height: 15.h),
  //         _titleLabel('사업자 인증'),
  //         _textFieldAndButton('사업자등록증을 첨부해주세요', '사진등록'),
  //         SizedBox(height: 15.h),
  //         _titleLabel('전화번호'),
  //         _textFieldAndButton('\'-\' 제외하고 입력', '인증번호 발송'),
  //         _textFieldAndButton('인증번호 6자리 입력', '인증'),
  //         SizedBox(height: 50.h),
  //         _bottomButton('회원가입'),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _titleLabel(String title) {
  //   return Container(
  //       margin: EdgeInsets.only(left: 25.w),
  //       child: Text(title, style: k14w500.copyWith(color: Color(0xFF51B263))));
  // }
  //
  // Widget _textField(String hint) {
  //   /// 아이디랑 전화번호 READ ONLY 로 바꿔주기위해 사용.
  //   String buttonText = '';
  //   switch (hint) {
  //     case '4~15자 영문, 숫자 조합으로 입력':
  //       buttonText = '중복확인';
  //       break;
  //     case '\'-\' 제외하고 입력':
  //       buttonText = '인증번호 발송';
  //       break;
  //     case '인증번호 6자리 입력':
  //       buttonText = '인증';
  //       break;
  //   }
  //   return GetBuilder<CorporationSignupViewModel>(
  //     builder: (_) => Container(
  //       margin: EdgeInsets.only(left: 25.w, right: 25.w),
  //       height: 40.h,
  //       child: Padding(
  //         padding: EdgeInsets.only(bottom: 8.h),
  //         child: TextField(
  //           readOnly: ((buttonText == '중복확인') && (_.idFlag))
  //               ? true
  //               : ((buttonText == '인증번호 발송') && (_.sendSMSFlag))
  //                   ? true
  //                   : false,
  //           onChanged: (text) {
  //             // print(text);
  //             switch (hint) {
  //               case '4~15자 영문, 숫자 조합으로 입력':
  //                 corporationSignupViewModel.idAvailable(text);
  //                 break;
  //               case '8~12자 영문, 숫자, 특수문자 조합으로 입력':
  //                 corporationSignupViewModel.pwCheck(text);
  //                 break;
  //               case '8~12자 영문, 숫자, 특수문자 조합으로 입력 ':
  //                 corporationSignupViewModel.pwConfirmCheck(text);
  //                 break;
  //               case '입력해주세요':
  //                 corporationSignupViewModel.nameCheck(text);
  //                 break;
  //               case '\'-\' 제외하고 입력':
  //                 corporationSignupViewModel.phoneAvailable(text);
  //                 break;
  //               case '인증번호 6자리 입력':
  //                 corporationSignupViewModel.codeAvailable(text);
  //                 break;
  //             }
  //           },
  //           obscureText: hint == '8~12자 영문, 숫자, 특수문자 조합으로 입력'
  //               ? true
  //               : hint == '8~12자 영문, 숫자, 특수문자 조합으로 입력 '
  //                   ? true
  //                   : false,
  //           decoration: InputDecoration(
  //             hintText: (hint == '사업자등록증을 첨부해주세요' && _.picture.isNotEmpty)
  //                 ? _.picture.split('/')[6]
  //                 : hint,
  //             hintStyle: k12w400.copyWith(color: Color(0xFF8D8D8D)),
  //             contentPadding: EdgeInsets.only(bottom: 5.h),
  //             focusedBorder: UnderlineInputBorder(
  //               borderSide: BorderSide(color: Color(0xFF51B263)),
  //             ),
  //             enabledBorder: UnderlineInputBorder(
  //               borderSide: BorderSide(color: Color(0xFF51B263)),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _button(String buttonText) {
  //   return GetBuilder<CorporationSignupViewModel>(
  //     builder: (_) => Container(
  //       height: 30.h,
  //       width: 90.w,
  //       child: TextButton(
  //         child: Text(buttonText, style: k12w400.copyWith(color: Colors.white)),
  //         onPressed: () async {
  //           switch (buttonText) {
  //             case '중복확인':
  //               _.idCheck();
  //               break;
  //             case '사진등록':
  //               _.pictureCheck(await getPicker());
  //               break;
  //             case '인증번호 발송':
  //               _.sendSMS();
  //               break;
  //             case '인증':
  //               _.verifySMS();
  //               break;
  //           }
  //         },
  //         style: TextButton.styleFrom(
  //             primary: Colors.white, backgroundColor: Color(0xFF51B263)),
  //       ),
  //     ),
  //   );
  // }
  //
  // /// 나중에 리액티브 버튼 색깔 다시 조절할때 회색으로 바꿔야 함
  // Widget _buttonFail(String buttonText) {
  //   return Container(
  //     height: 30.h,
  //     width: 90.w,
  //     child: TextButton(
  //       child:
  //           Text(buttonText, style: k12w400.copyWith(color: Color(0xFF51B263))),
  //       onPressed: null,
  //       style: TextButton.styleFrom(
  //           primary: Colors.white,
  //           backgroundColor: Color(0xFF51B263).withOpacity(0.15)),
  //     ),
  //   );
  // }
  //
  // Widget _textFieldAndButton(String title, String buttonText) {
  //   return GetBuilder<CorporationSignupViewModel>(
  //     builder: (_) => Container(
  //       margin: EdgeInsets.only(right: 25.w),
  //       height: 40.h,
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: _textField(title),
  //           ),
  //           if (buttonText == '중복확인') ...[
  //             _.idTempFlag ? _button(buttonText) : _buttonFail(buttonText)
  //           ],
  //           if (buttonText == '인증번호 발송') ...[
  //             _.phoneTempFlag ? _button(buttonText) : _buttonFail(buttonText)
  //           ],
  //           if (buttonText == '인증') ...[
  //             _.codeTempFlag ? _button(buttonText) : _buttonFail(buttonText)
  //           ],
  //           if (buttonText == '사진등록') ...[_button(buttonText)],
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _bottomButton(String buttonText) {
  //   return Container(
  //     height: 40.h,
  //     color: Color(0xFF5F7D65),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         if (buttonText == '회원가입') ...[
  //           GetBuilder<CorporationSignupViewModel>(builder: (_) {
  //             return _.finalFlag
  //                 ? TextButton(
  //                     child: Text(buttonText,
  //                         style: k14w500.copyWith(color: Colors.white)),
  //                     onPressed: () async {
  //                       // Session session = Session();
  //                       // String result = await session.signup();
  //                       // if (result == 'success') {
  //                       //   alert(context, '회원가입이 완료되었습니다.');
  //                       // } else {
  //                       //   alert(context, '회원가입에 실패하였습니다.');
  //                       // }
  //                     },
  //                   )
  //                 : TextButton(
  //                     child: Text(buttonText,
  //                         style: k14w500.copyWith(color: Colors.grey)),
  //                     onPressed: null,
  //                   );
  //           }),
  //         ],
  //       ],
  //     ),
  //   );
  // }

  Future<String> getPicker() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    print('======================= In getPicker()==================');
    String imagePath = '';
    if (image != null) {
      print('getPicker image not null entered ! ');
      print(image.path);
      imagePath = image.path;
    }
    print('===================== out getPicker()==================');
    return imagePath;
  }
}

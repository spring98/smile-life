// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smile_life/core/view_model/signup_view_model.dart';
import 'package:smile_life/utils/constants/kButton.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:get/get.dart';
import 'package:smile_life/utils/constants/kTextField.dart';

class PersonalSignup extends StatefulWidget {
  const PersonalSignup({Key? key}) : super(key: key);

  @override
  _PersonalSignupState createState() => _PersonalSignupState();
}

class _PersonalSignupState extends State<PersonalSignup> {
  final signupViewModel = Get.put(SignupViewModel());

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
        _titleLabel('이름'),
        _textFieldAndButton(
          textFieldTag: '이름',
          textFieldHint: '실명입력',
        ),
        SizedBox(height: 15.h),
        _titleLabel('전화번호'),
        _textFieldAndButton(
          textFieldTag: '인증번호 발송',
          textFieldHint: '\'-\' 제외하고 입력',
          buttonTag: '인증번호 발송',
          buttonHint: '인증번호 발송',
        ),
        _textFieldAndButton(
          textFieldTag: '인증번호 확인',
          textFieldHint: '인증번호 6자리 입력',
          buttonTag: '인증번호 확인',
          buttonHint: '인증번호 확인',
        ),
        SizedBox(height: 15.h),
        _titleLabel('소속'),
        _textFieldAndButton(
          textFieldTag: '소속',
          textFieldHint: '소속 입력',
        ),
        SizedBox(height: 15.h),
        _titleLabel('직급'),
        _textFieldAndButton(
          textFieldTag: '직급',
          textFieldHint: '직급 입력',
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
    return GetBuilder<SignupViewModel>(
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

        /// obscure
        if (textFieldTag == '비밀번호') {
          _obscure = true;
        }

        if (textFieldTag == '비밀번호 확인') {
          _obscure = true;
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
            break;
          case '비밀번호 확인':
            _onChanged = (text) => _.pwConfirmCheck(text);
            break;
          case '이름':
            _onChanged = (text) => _.nameCheck(text);
            break;
          case '인증번호 발송':
            _onChanged = (text) => _.phoneAvailable(text);
            _showButton = true;
            if (_.phoneTempFlag) {
              _onTap = () async => _.sendSMS();
              _color = Colors.white;
            }
            break;
          case '인증번호 확인':
            _onChanged = (text) => _.codeAvailable(text);
            _showButton = true;
            if (_.codeTempFlag) {
              _onTap = () async => _.verifySMS();
              _color = Colors.white;
            }
            break;
          case '소속':
            _onChanged = (text) => _.divisionCheck(text);
            break;
          case '직급':
            _onChanged = (text) => _.rankCheck(text);
            break;
        }

        return Container(
          height: 40.h,
          child: Row(
            children: [
              Expanded(
                child: GetBuilder<SignupViewModel>(
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
    return GetBuilder<SignupViewModel>(
      builder: (_) {
        var _onTap = () => print('onTap');
        Color _color = kColorHint;
        if (_.finalFlag) {
          _onTap = () async => _.signup();
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
}

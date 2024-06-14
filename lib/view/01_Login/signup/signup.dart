// ignore_for_file: prefer_const_constructors
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smile_life/core/view_model/user/signup_view_model.dart';
import 'package:smile_life/utils/constants/kButton.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:smile_life/utils/constants/kAppBar.dart';
import 'package:smile_life/utils/constants/kTextField.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final signupViewModel = Get.put(SignupViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupViewModel>(
      builder: (_) => Scaffold(
        appBar: kAppBar('회원가입'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15.h),
              _titleLabel('이름'),
              _textFieldAndButton(
                textFieldTag: '이름',
                textFieldHint: '실명입력',
              ),
              SizedBox(height: 15.h),
              _titleLabel('전화번호'),
              _textFieldAndButton(
                textFieldTag: '전화번호',
                textFieldHint: '\'-\' 제외하고 입력',
                buttonTag: '전화번호',
                buttonHint: '중복확인',
              ),
              SizedBox(height: 15.h),
              _titleLabel('비밀번호'),
              _textFieldAndButton(
                textFieldTag: '비밀번호',
                textFieldHint: '8자 ~ 12자 사이 입력',
              ),
              SizedBox(height: 15.h),
              _titleLabel('비밀번호 확인'),
              _textFieldAndButton(
                textFieldTag: '비밀번호 확인',
                textFieldHint: '8자 ~ 12자 사이 입력',
              ),
              SizedBox(height: 200.h),
              _bottomButton('회원가입')
            ],
          ),
        ),
      ),
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
        var _keyboardType = TextInputType.text;

        /// read only
        if ((buttonTag == '전화번호') && (_.phoneFlag)) {
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
          case '비밀번호':
            _onChanged = (text) => _.pwCheck(text);
            break;
          case '비밀번호 확인':
            _onChanged = (text) => _.pwConfirmCheck(text);
            break;
          case '이름':
            _onChanged = (text) => _.nameCheck(text);
            break;
          case '전화번호':
            _onChanged = (text) => _.phoneAvailable(text);
            _keyboardType = TextInputType.number;
            _showButton = true;
            if (_.phoneTempFlag) {
              _onTap = () async => _.checkPhone();
              _color = Colors.white;
            }
            break;
        }

        return SizedBox(
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
                        keyboardType: _keyboardType,
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

          _color = Colors.white;
        }
        return GestureDetector(
          onTap: _onTap,
          child: Container(
            height: 60.h,
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

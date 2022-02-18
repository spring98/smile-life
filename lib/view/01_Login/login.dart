// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:smile_life/core/view_model/user/login_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smile_life/utils/constants/kAlert.dart';
import 'package:smile_life/utils/constants/kButton.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:smile_life/utils/constants/kTextField.dart';
import 'package:smile_life/view/01_Login/signup/signup.dart';
import 'package:smile_life/view/02_Home/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginViewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<LoginViewModel>(
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 60.h),
                  _title(),
                  SizedBox(height: 10.h + _.flex),
                  _textField(tag: '아이디', hint: '전화번호'),
                  SizedBox(height: 13.h),
                  _textField(tag: '비밀번호', hint: '비밀번호'),
                  SizedBox(height: 5.5.h),
                  _loginMaintenance(),
                  SizedBox(height: 20.h),
                  _button(tag: '로그인', hint: '로그인'),
                  SizedBox(height: 13.h),
                  _button(tag: '회원가입', hint: '회원가입'),
                  SizedBox(height: 30.h),
                  _bottomSNS()
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 180.w,
          height: 90.w,
          child: Image.asset(
            'images/firebaseLogo.png',
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 13.h),
        Text('FireBase CRUD', style: k20w700.copyWith(color: kColorPrimary)),
      ],
    );
  }

  Widget _textField({required String tag, required String hint}) {
    return GetBuilder<LoginViewModel>(
      builder: (_) {
        var _onChanged = (text) => print('onChanged');
        var _onTap = () => print('onTap');
        var _onFieldSubmitted = (String str) => print('onFieldSubmitted');
        var _controller = _.idController;
        var _keyboardType = TextInputType.number;
        var _isObscure = false;

        switch (tag) {
          case '아이디':
            _onChanged = (text) => _.idCheck(text);
            _onTap = () => _.setFlex(0);
            _onFieldSubmitted = (String str) => _.setFlex(40);
            _controller = _.idController;
            _keyboardType = TextInputType.number;
            _isObscure = false;
            break;
          case '비밀번호':
            _onChanged = (text) => _.pwCheck(text);
            _onTap = () => _.setFlex(0);
            _onFieldSubmitted = (String str) => _.setFlex(40);
            _controller = _.pwController;
            _keyboardType = TextInputType.text;
            _isObscure = true;
            break;
        }

        return Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: TextFormField(
            onChanged: _onChanged,
            keyboardType: _keyboardType,
            onTap: _onTap,
            obscureText: _isObscure,
            onFieldSubmitted: _onFieldSubmitted,
            controller: _controller,
            // cursorHeight: 16.h,
            cursorColor: kColorPrimary,
            style: k14w400.copyWith(color: kColorPrimary),
            decoration: kTextFieldRound(hint),
          ),
        );
      },
    );
  }

  Widget _loginMaintenance() {
    return GetBuilder<LoginViewModel>(
      builder: (_) {
        Widget _icon = _.autoLoginFlag ? _checkedIcon() : _unCheckedIcon();
        return Container(
          margin: EdgeInsets.only(right: 20.w, left: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => _.autoLoginCheck(),
                child: _icon,
              ),
              SizedBox(width: 3.5.w),
              Text(
                '자동 로그인',
                style: k12w400.copyWith(
                  color: kColorPrimary,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _button({required String tag, required String hint}) {
    return GetBuilder<LoginViewModel>(
      builder: (_) {
        var _onTap = () => print('onTap');

        Color _color = Colors.black;
        BoxDecoration _decoration = kButtonRound();

        switch (tag) {
          case '로그인':
            _onTap = () async {
              if (_.finalFlag) _.login();
            };
            // _onTap = () async => Get.to(() => Home());
            _color = _.finalFlag ? Colors.white : kColorHint;
            _decoration = kButtonRound().copyWith(color: kColorPrimary);
            break;
          case '회원가입':
            _onTap = () => Get.to(() => Signup());
            _color = kColorPrimary;
            _decoration = kButtonRound().copyWith(color: Colors.white);
            break;
        }

        return GestureDetector(
          onTap: _onTap,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20.w, right: 20.w),
            height: 40.h,
            decoration: _decoration,
            child: Text(
              hint,
              style: k12w400.copyWith(color: _color),
            ),
          ),
        );
      },
    );
  }

  Widget _bottomSNS() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20.h),
        Text(
          'SNS 간편로그인',
          style: k12w500.copyWith(color: kColorPrimary),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                alert('준비중입니다.');
              },
              child: Image.asset('images/kakaoLogo.png'),
            ),
            SizedBox(width: 25.w),
            GestureDetector(
              onTap: () {
                alert('준비중입니다.');
              },
              child: Image.asset('images/naverLogo.png'),
            ),
          ],
        ),
      ],
    );
  }

  Icon _unCheckedIcon() {
    return Icon(
      Icons.check_box_outline_blank,
      color: kColorPrimary,
      size: 21.sp,
    );
  }

  Icon _checkedIcon() {
    return Icon(
      Icons.check_box_outlined,
      color: kColorPrimary,
      size: 21.sp,
    );
  }
}

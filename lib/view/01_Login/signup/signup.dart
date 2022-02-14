// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smile_life/core/view_model/signup_view_model.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:smile_life/utils/constants/kAppBar.dart';
import 'package:smile_life/view/01_Login/signup/personal_signup.dart';
import 'corporation_signup.dart';

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
            children: [
              SizedBox(height: 20.h),
              _topDoubleButton(),
              SizedBox(height: 15.h),
              if (_.isPersonalSignup) ...[
                PersonalSignup()
              ] else ...[
                CorporationSignup()
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _topDoubleButton() {
    return GetBuilder<SignupViewModel>(
      builder: (_) {
        Border? _personalBoxBorder;
        Border? _corporationBoxBorder;
        Color _personalColor = kColorPrimary;
        Color _corporationColor = kColorHint;

        if (_.isPersonalSignup) {
          _personalBoxBorder = Border.all(width: 1.25.sp, color: kColorPrimary);
          _personalColor = kColorPrimary;

          _corporationBoxBorder = null;
          _corporationColor = kColorHint;
        } else {
          _personalBoxBorder = null;
          _personalColor = kColorHint;

          _corporationColor = kColorPrimary;
          _corporationBoxBorder =
              Border.all(width: 1.25.sp, color: kColorPrimary);
        }

        return Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _.setPersonal(),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: _personalBoxBorder,
                      color: Color(0xFFECEEED),
                    ),
                    height: 30.h,
                    child: Text('개인 회원',
                        style: k14w700.copyWith(color: _personalColor)),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _.setCorporation(),
                  child: Container(
                    decoration: BoxDecoration(
                      border: _corporationBoxBorder,
                      color: Color(0xFFEEEEEE),
                    ),
                    alignment: Alignment.center,
                    height: 30.h,
                    child: Text('법인 회원',
                        style: k14w700.copyWith(color: _corporationColor)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

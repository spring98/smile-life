// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smile_life/core/services/common_service.dart';
import 'package:smile_life/core/view_model/user_view_model.dart';
import 'package:smile_life/models/user_model.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:smile_life/utils/login_secure.dart';
import 'package:smile_life/view/01_Login/login.dart';
import 'package:smile_life/utils/constants/kAlert.dart';
import 'package:smile_life/utils/constants/kAppBar.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final userViewModel = Get.put(UserViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('마이페이지'),
      body: SafeArea(
        child: FutureBuilder<List<UserModel>>(
          future: userViewModel.fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(child: SizedBox()),
                  _userIndicator(),
                  Expanded(child: SizedBox()),
                  _fourRowButton(),
                  Expanded(child: SizedBox()),
                  _fourColumnButton(),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _userIndicator() {
    return GetBuilder<UserViewModel>(
      builder: (_) => Column(
        children: [
          SizedBox(
            width: 70.w,
            height: 70.w,
            child: Image.asset('images/MyPageUserCircle.png'),
          ),
          Text(_.getUserModel[0].name,
              style: k20w700.copyWith(color: Color(0xFF3F3F3F))),
          Text(_.getUserModel[0].id,
              style: k14w500.copyWith(color: Color(0xFF3F3F3F))),
          Text(_.getUserModel[0].division,
              style: k12w400.copyWith(color: Color(0xFF3F3F3F))),
        ],
      ),
    );
  }

  Widget _fourRowButton() {
    return Row(
      children: [
        Expanded(child: SizedBox()),
        GestureDetector(
          onTap: () {
            // Get.to(UserModification());
          },
          child: Column(children: [
            SizedBox(
              width: 30.w,
              height: 30.w,
              child: Image.asset(
                'images/Eraser.png',
                color: Color(0xFF51B263),
              ),
            ),
            SizedBox(height: 3.h),
            Text('회원정보수정', style: k10w500)
          ]),
        ),
        Expanded(child: SizedBox()),
        GestureDetector(
          onTap: () {
            // Get.to(FAQ(inquiryHistoryFlag: true));
          },
          child: Column(
            children: [
              SizedBox(
                width: 30.w,
                height: 30.w,
                child: Image.asset(
                  'images/Inquiry.png',
                  color: Color(0xFF51B263),
                ),
              ),
              SizedBox(height: 3.h),
              Text('문의내역', style: k10w500)
            ],
          ),
        ),
        Expanded(child: SizedBox()),
        GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              SizedBox(
                width: 30.w,
                height: 30.w,
                child: Image.asset(
                  'images/Bell.png',
                  color: Color(0xFF51B263),
                ),
              ),
              SizedBox(height: 3.h),
              Text('알림', style: k10w500)
            ],
          ),
        ),
        Expanded(child: SizedBox()),
        GestureDetector(
          onTap: () {
            print('로그아웃');
            setProfileUrl(Session.id + ' ' + Session.pw + ' ' + 'login');
            Get.offAll(Login());
          },
          child: Column(
            children: [
              SizedBox(
                width: 30.w,
                height: 30.w,
                child: Image.asset(
                  'images/LockOpen.png',
                  color: Color(0xFF51B263),
                ),
              ),
              SizedBox(height: 3.h),
              Text('로그아웃', style: k10w500)
            ],
          ),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }

  Widget _fourColumnButton() {
    return Container(
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
      color: Color(0xFF51B263),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              // print('asdf');
              // Get.to(FAQ(inquiryHistoryFlag: false));
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.h),
              padding: EdgeInsets.only(left: 15.w),
              child: Text('자주묻는질문(FAQ)',
                  style: k14w500.copyWith(color: Color(0xFF51B263))),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: Colors.white,
              ),
              height: 45.h,
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () {
              alert('준비중입니다.');
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
              padding: EdgeInsets.only(left: 15.w),
              child: Text('앱 버전',
                  style: k14w500.copyWith(color: Color(0xFF51B263))),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: Colors.white,
              ),
              height: 45.h,
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () {
              alert('준비중입니다.');
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: 15.w, right: 15.w, top: 10.h, bottom: 25.h),
              padding: EdgeInsets.only(left: 15.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: Colors.white,
              ),
              child: Text('개인정보이용방침',
                  style: k14w500.copyWith(color: Color(0xFF51B263))),
              height: 45.h,
            ),
          ),
        ],
      ),
    );
  }
}

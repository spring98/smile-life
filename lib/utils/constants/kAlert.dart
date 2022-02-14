// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';

Future<dynamic> alert(String contents) {
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 145.h,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 39.h,
                child: Text('알림', style: k14w500),
              ),
              Container(
                  alignment: Alignment.center,
                  color: kColorPrimary,
                  height: 1.h),
              Container(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                alignment: Alignment.center,
                height: 70.h,
                child: Text(contents, style: k14w500),
              ),
              GestureDetector(
                onTap: () {
                  Get.back(result: 'yes');
                },
                child: Container(
                  color: kColorPrimary,
                  alignment: Alignment.center,
                  height: 35.h,
                  child:
                      Text('확인', style: k12w500.copyWith(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false);
}

Future<dynamic> alertYesOrNo(String contents) {
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 145.h,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 39.h,
                child: Text('알림', style: k14w500),
              ),
              Container(
                  alignment: Alignment.center,
                  color: kColorPrimary,
                  height: 1.h),
              Container(
                alignment: Alignment.center,
                height: 70.h,
                child: Text(contents, style: k14w500),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back(result: 'yes');
                      },
                      child: Container(
                        color: kColorPrimary,
                        alignment: Alignment.center,
                        height: 35.h,
                        child: Text('확인',
                            style: k12w500.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back(result: 'no');
                      },
                      child: Container(
                        color: Colors.grey,
                        alignment: Alignment.center,
                        height: 35.h,
                        child: Text('취소',
                            style: k12w500.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false);
}

Future<dynamic> alertBackPressed() {
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 155.h,
          width: 300.w,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 39.h,
                  width: 40.w,
                  child: Text('알림', style: k12w400)),
              Container(
                  alignment: Alignment.center,
                  color: kColorPrimary,
                  height: 1.h),
              Container(
                alignment: Alignment.center,
                height: 80.h,
                child: Text('정말로 종료 하시겠습니까?', style: k12w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      },
                      child: Container(
                        color: kColorPrimary,
                        alignment: Alignment.center,
                        width: 100.w,
                        height: 35.h,
                        child: Text('확인',
                            style: k12w500.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        color: Colors.grey,
                        alignment: Alignment.center,
                        width: 100.w,
                        height: 35.h,
                        child: Text('취소',
                            style: k12w500.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false);
}

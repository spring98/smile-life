// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smile_life/core/view_model/home/home_view_model.dart';
import 'package:smile_life/core/view_model/my_store/my_store_view_model.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:smile_life/utils/constants/kProgressIndicator.dart';
import 'package:smile_life/utils/constants/kTextField.dart';

import '../open_gallery.dart';

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

final myStoreVM = Get.put(MyStoreViewModel());

Future<dynamic> alertMakeStore(String contents) {
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 550.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 제목
                Container(
                  alignment: Alignment.center,
                  height: 39.h,
                  child: Text('상점 등록', style: k14w500),
                ),
                Container(
                    alignment: Alignment.center,
                    color: kColorPrimary,
                    height: 1.h),
                // 내용
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
                  height: 475.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: kTextFieldRound('상점의 이름을 정해보세요.'),
                        onChanged: (text) {
                          myStoreVM.setStoreName(text);
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextField(
                        decoration: kTextFieldRound('상점을 설명해보세요.'),
                        maxLines: 5,
                        onChanged: (text) {
                          myStoreVM.setStoreExplain(text);
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextField(
                        decoration: kTextFieldRound('소속을 입력해주세요.'),
                        onChanged: (text) {
                          myStoreVM.setDivision(text);
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextField(
                        decoration: kTextFieldRound('계좌번호를 입력해주세요.'),
                        onChanged: (text) {
                          myStoreVM.setAccountNumber(text);
                        },
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(() {
                            Widget _image = Container();
                            if (myStoreVM.productUrl.value.isEmpty) {
                              _image = _dottedBorderImage();
                            } else if (myStoreVM.productUrl.value
                                .contains('https')) {
                              _image = CachedNetworkImage(
                                imageUrl: myStoreVM.productUrl.value,
                                fit: BoxFit.fill,
                                placeholder: (context, take) =>
                                    CircularProgressIndicator(),
                              );
                            } else {
                              _image = Image.file(
                                File(myStoreVM.productUrl.value),
                                fit: BoxFit.fill,
                              );
                            }
                            return SizedBox(
                              child: _image,
                              width: 200.w,
                              height: 200.w,
                            );
                          }),
                          Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () async {
                              await myStoreVM.setProductUrl();
                            },
                            child: _cameraContainer(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 하단 버튼
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
      ),
      barrierDismissible: false);
}

Future<dynamic> alertAddCategory(String contents) {
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 475.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 제목
                Container(
                  alignment: Alignment.center,
                  height: 39.h,
                  child: Text('카테고리 등록', style: k14w500),
                ),
                Container(
                    alignment: Alignment.center,
                    color: kColorPrimary,
                    height: 1.h),
                // 내용
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
                  height: 400.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        cursorHeight: 16.h,
                        decoration: kTextFieldRound('카테고리를 추가하세요.'),
                        onChanged: (text) {
                          myStoreVM.setCategory(text);
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextField(
                        cursorHeight: 16.h,
                        decoration: kTextFieldRound('상품 이름을 입력하세요.'),
                        onChanged: (text) {
                          myStoreVM.setProductName(text);
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextField(
                        cursorHeight: 16.h,
                        decoration: kTextFieldRound('상품을 설명해주세요.'),
                        onChanged: (text) {
                          myStoreVM.setProductExplain(text);
                        },
                        maxLines: 3,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(() {
                            Widget _image = Container();
                            if (myStoreVM.productUrl.value.isEmpty) {
                              _image = _dottedBorderImage();
                            } else if (myStoreVM.productUrl.value
                                .contains('https')) {
                              _image = CachedNetworkImage(
                                imageUrl: myStoreVM.productUrl.value,
                                fit: BoxFit.fill,
                                placeholder: (context, take) =>
                                    CircularProgressIndicator(),
                              );
                            } else {
                              _image = Image.file(
                                File(myStoreVM.productUrl.value),
                                fit: BoxFit.fill,
                              );
                            }
                            return SizedBox(
                              child: _image,
                              width: 200.w,
                              height: 200.w,
                            );
                          }),
                          Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () async {
                              await myStoreVM.setProductUrl();
                            },
                            child: _cameraContainer(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 하단 버튼
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
                          myStoreVM.fieldClear();
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
      ),
      barrierDismissible: false);
}

Future<dynamic> alertAddProduct(String contents, {required String category}) {
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 475.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 제목
                Container(
                  alignment: Alignment.center,
                  height: 39.h,
                  child: Text('상품 등록', style: k14w500),
                ),
                Container(
                    alignment: Alignment.center,
                    color: kColorPrimary,
                    height: 1.h),
                // 내용
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
                  height: 400.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('카테고리 : $category'),
                      SizedBox(height: 10.h),
                      TextField(
                        cursorHeight: 16.h,
                        decoration: kTextFieldRound('상품 이름을 입력하세요.'),
                        onChanged: (text) {
                          myStoreVM.setProductName(text);
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextField(
                        cursorHeight: 16.h,
                        decoration: kTextFieldRound('상품을 설명해주세요.'),
                        onChanged: (text) {
                          myStoreVM.setProductExplain(text);
                        },
                        maxLines: 3,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(() {
                            Widget _image = Container();
                            if (myStoreVM.productUrl.value.isEmpty) {
                              _image = _dottedBorderImage();
                            } else if (myStoreVM.productUrl.value
                                .contains('https')) {
                              _image = CachedNetworkImage(
                                imageUrl: myStoreVM.productUrl.value,
                                fit: BoxFit.fill,
                                placeholder: (context, take) =>
                                    CircularProgressIndicator(),
                              );
                            } else {
                              _image = Image.file(
                                File(myStoreVM.productUrl.value),
                                fit: BoxFit.fill,
                              );
                            }
                            return SizedBox(
                              child: _image,
                              width: 200.w,
                              height: 200.w,
                            );
                          }),
                          Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () async {
                              await myStoreVM.setProductUrl();
                            },
                            child: _cameraContainer(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 하단 버튼
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
                          myStoreVM.fieldClear();
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
      ),
      barrierDismissible: false);
}

Future<dynamic> alertEditProduct(String contents, {required String id}) async {
  Map<dynamic, dynamic> result = await myStoreVM.fetchProductById(id: id);
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 490.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 제목
                Container(
                  alignment: Alignment.center,
                  height: 39.h,
                  child: Text('상품 편집', style: k14w500),
                ),
                Container(
                    alignment: Alignment.center,
                    color: kColorPrimary,
                    height: 1.h),
                // 내용
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
                  height: 415.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('상품 이름', style: k14w400),
                      SizedBox(height: 5.h),
                      TextFormField(
                        cursorHeight: 16.h,
                        decoration: kTextFieldRound('상품 이름을 입력하세요.'),
                        initialValue: result['name'],
                        onChanged: (text) {
                          myStoreVM.setProductName(text);
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text('상품 설명', style: k14w400),
                      SizedBox(height: 5.h),
                      TextFormField(
                        cursorHeight: 16.h,
                        decoration: kTextFieldRound('상품을 설명해주세요.'),
                        initialValue: result['explain'],
                        onChanged: (text) {
                          myStoreVM.setProductExplain(text);
                        },
                        maxLines: 3,
                      ),
                      SizedBox(height: 10.h),
                      Text('상품 사진', style: k14w400),
                      SizedBox(height: 5.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(() {
                            Widget _image = Container();
                            if (result['url'].isEmpty) {
                              _image = _dottedBorderImage();
                            } else if (myStoreVM.productUrl.value
                                .contains('https')) {
                              _image = CachedNetworkImage(
                                imageUrl: myStoreVM.productUrl.value,
                                fit: BoxFit.fill,
                                placeholder: (context, take) =>
                                    CircularProgressIndicator(),
                              );
                            } else {
                              _image = Image.file(
                                File(myStoreVM.productUrl.value),
                                fit: BoxFit.fill,
                              );
                            }
                            return SizedBox(
                              child: _image,
                              width: 200.w,
                              height: 200.w,
                            );
                          }),
                          Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () async {
                              await myStoreVM.setProductUrl();
                            },
                            child: _cameraContainer(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 하단 버튼
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
                          myStoreVM.fieldClear();
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
      ),
      barrierDismissible: false);
}

Future<dynamic> alertLoading() async {
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 150.h,
          child: Column(
            children: [
              // 제목
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 39.h,
                    child: Text('알림', style: k14w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back(result: 'cancel');
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 10.w),
                      alignment: Alignment.centerRight,
                      height: 39.h,
                      child: Icon(Icons.clear),
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.center,
                  color: kColorPrimary,
                  height: 1.h),
              // 내용
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
                height: 75.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10.h),
                    Text('잠시만 기다려 주세요.', style: k14w400),
                  ],
                ),
              ),
              // 하단 버튼
              // Row(
              //   children: [
              //     Expanded(
              //       child: GestureDetector(
              //         onTap: () {
              //           Get.back(result: 'yes');
              //         },
              //         child: Container(
              //           color: kColorPrimary,
              //           alignment: Alignment.center,
              //           height: 35.h,
              //           child: Text('잠시만',
              //               style: k12w500.copyWith(color: Colors.white)),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: GestureDetector(
              //         onTap: () {
              //           Get.back(result: 'no');
              //         },
              //         child: Container(
              //           color: Colors.grey,
              //           alignment: Alignment.center,
              //           height: 35.h,
              //           child: Text('기다려',
              //               style: k12w500.copyWith(color: Colors.white)),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
      barrierDismissible: false);
}

Future<dynamic> alertDeleteProduct(String contents,
    {required String id}) async {
  return Get.dialog(
      Dialog(
        child: SizedBox(
          height: 150.h,
          child: Column(
            children: [
              // 제목
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 39.h,
                    child: Text('알림', style: k14w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back(result: 'cancel');
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 10.w),
                      alignment: Alignment.centerRight,
                      height: 39.h,
                      child: Icon(Icons.clear),
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.center,
                  color: kColorPrimary,
                  height: 1.h),
              // 내용
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
                height: 75.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text('해당 상품을 삭제하시겠습니까?', style: k14w400),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
              // 하단 버튼
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
                        child: Text('삭제',
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
                        child: Text('편집하기',
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

Widget _dottedBorderImage() {
  return DottedBorder(
    padding: EdgeInsets.only(top: 90.w),
    color: Colors.black,
    strokeWidth: 1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '사진을 등록해주세요.',
          style: k14w400.copyWith(color: Colors.grey),
        ),
      ],
    ),
  );
}

Widget _cameraContainer() {
  return Container(
    child: Icon(Icons.camera_alt, color: Colors.white),
    width: 50.w,
    height: 50.w,
    color: Colors.black,
  );
}

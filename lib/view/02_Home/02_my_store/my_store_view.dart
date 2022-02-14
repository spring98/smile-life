// ignore_for_file: avoid_print

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smile_life/utils/constants/kButton.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';

class MyStore extends StatefulWidget {
  const MyStore({Key? key}) : super(key: key);

  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  int count = 0;
  int projectCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _storeExplain(),
        _storeCardList(),
      ],
    );
  }

  Widget _storeExplain() {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('상점 설명 : 동해물과 백두산이 마르고 닳도록 ',
              style: k14w400.copyWith(color: Colors.red)),
          SizedBox(height: 5.h),
          Text('전화번호 : 01030192029', style: k14w400),
          SizedBox(height: 5.h),
          Text('계좌번호 : 농협 09812791829345', style: k14w400),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            color: Colors.black.withOpacity(0.1),
            height: 1.h,
          )
        ],
      ),
    );
  }

  /// 카테고리 + 사진 + 상품설명 (가로로 한줄 전체의 묶음)
  Widget _storeCardList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < count; i++) ...[
          _storeCard(),
        ],
        SizedBox(height: 15.w),
        GestureDetector(
          onTap: () {
            print('카테고리 추가하기');
          },
          child: Container(
            margin: EdgeInsets.only(left: 15.w, right: 15.w),
            child: DottedBorder(
              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
              color: Colors.black,
              strokeWidth: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '카테고리 추가하기',
                    style: k14w400.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 15.w),
      ],
    );
  }

  /// 카테고리 + 사진 + 상품설명 (가로로 한줄 전체)
  Widget _storeCard() {
    return Container(
      // color: kColorPrimary,
      decoration: kButtonUnderLine(color: Colors.black.withOpacity(0.1)),
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('카테고리 : 중고물품', style: k14w400),
          SizedBox(height: 10.h),
          _productCardList()
        ],
      ),
    );
  }

  /// 사진 + 상품설명 (1개 카테고리에 대한 전체 상품)
  Widget _productCardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (int i = 0; i < projectCount; i++) ...[
                _productCard(),
              ],
              GestureDetector(
                onTap: () {
                  print('상품추가하기');
                },
                child: SizedBox(
                  height: 250.w,
                  child: DottedBorder(
                    padding: EdgeInsets.only(
                        top: 20.h, bottom: 20.h, right: 15.w, left: 15.w),
                    color: Colors.black,
                    strokeWidth: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '상품 추가하기',
                          style: k14w400.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 1개 카테고리에 대한 상품 리스트 중 1개의 상품
  Widget _productCard() {
    double dynamicSize = 200.w;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.black.withOpacity(0.1), width: 1),
        ),
      ),
      margin: EdgeInsets.only(left: 15.w),
      padding: EdgeInsets.only(right: 15.w),
      width: dynamicSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: dynamicSize,
            child: Image.asset(
              'images/firebaseLogo.png',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10.h),
          Text('상품 설명'),
          Text('하느님이 보우하사 우리나라 만세')
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smile_life/utils/constants/kButton.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';

class AllStore extends StatefulWidget {
  const AllStore({Key? key}) : super(key: key);

  @override
  _AllStoreState createState() => _AllStoreState();
}

class _AllStoreState extends State<AllStore> {
  int count = 10;

  @override
  Widget build(BuildContext context) {
    return _storeCardList();
  }

  Widget _storeCardList() {
    return Column(
      children: [
        SizedBox(height: 10.h),
        for (int i = 0; i < count; i++) ...[
          _storeCard(),
        ]
      ],
    );
  }

  Widget _storeCard() {
    return Container(
      // color: kColorPrimary,
      decoration: kButtonUnderLine(color: Colors.black.withOpacity(0.1)),
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      padding:
          EdgeInsets.only(top: 10.h, bottom: 10.h, left: 15.w, right: 15.w),
      child: Row(
        children: [
          SizedBox(
            width: 100.w,
            height: 100.w,
            child: Image.asset(
              'images/firebaseLogo.png',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('상점 이름', style: k14w400.copyWith(color: Colors.red)),
              SizedBox(height: 5.h),
              Text('상점 주인 이름', style: k14w400),
              SizedBox(height: 5.h),
              Text('소속', style: k14w400),
            ],
          )
        ],
      ),
    );
  }
}

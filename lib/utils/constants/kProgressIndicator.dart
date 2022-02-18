import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget kProgressIndicator() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20.h),
        // LinearProgressIndicator(),
        // RefreshProgressIndicator(),
        CircularProgressIndicator(),
      ],
    ),
  );
}

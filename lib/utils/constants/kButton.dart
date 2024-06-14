import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'kColor.dart';

BoxDecoration kButtonUnderLine({Color color = Colors.black, double width = 1}) {
  return BoxDecoration(
    border: Border(
      bottom: BorderSide(color: color, width: width),
    ),
  );
}

BoxDecoration kButtonPartialUnderLine() {
  return BoxDecoration(
    border: Border(
      right: BorderSide(color: Colors.black),
    ),
  );
}

BoxDecoration kButtonRect() {
  return BoxDecoration(
    border: Border.all(color: kColorButtonBorder),
    color: kColorButton,
  );
}

BoxDecoration kButtonRound() {
  return BoxDecoration(
    border: Border.all(color: kColorButtonBorder),
    borderRadius: BorderRadius.circular(10.sp),
    color: kColorButton,
  );
}

BoxDecoration kButtonPartialRound() {
  return BoxDecoration(
    border: Border.all(color: kColorButtonBorder),
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(10.sp),
      bottomRight: Radius.circular(10.sp),
    ),
    color: kColorButton,
  );
}

/// Gradient
BoxDecoration kButtonRectGradient() {
  return BoxDecoration(
    border: Border.all(color: kColorButtonBorder),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [kColorButtonGradientFirst, kColorButtonGradientSecond],
    ),
    color: kColorButton,
  );
}

BoxDecoration kButtonRoundGradient() {
  return BoxDecoration(
    border: Border.all(color: kColorButtonBorder),
    borderRadius: BorderRadius.circular(10.sp),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [kColorButtonGradientFirst, kColorButtonGradientSecond],
    ),
    color: kColorButton,
  );
}

BoxDecoration kButtonPartialRoundGradient() {
  return BoxDecoration(
    border: Border.all(color: kColorButtonBorder),
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(10.sp),
      bottomRight: Radius.circular(10.sp),
    ),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [kColorButtonGradientFirst, kColorButtonGradientSecond],
    ),
    color: kColorButton,
  );
}

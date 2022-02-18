import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smile_life/utils/constants/kAlert.dart';
import 'package:smile_life/utils/enum/home_enum.dart';

class HomeViewModel extends GetxController {
  /// 멤버 변수
  Rx<BottomNavigation> bottomNavigation = BottomNavigation.allStore.obs;

  /// 멤버변수 setter
  void setBottomNavigation(BottomNavigation navigation) {
    bottomNavigation.value = navigation;
    // update();
  }
}

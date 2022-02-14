import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smile_life/utils/enum/home_enum.dart';

class HomeViewModel extends GetxController {
  BottomNavigation bottomNavigation = BottomNavigation.allStore;

  void setBottomNavigation(BottomNavigation navigation) {
    bottomNavigation = navigation;
    update();
  }
}

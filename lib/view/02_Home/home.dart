// ignore_for_file: prefer_const_constructors, prefer_function_declarations_over_variables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smile_life/core/view_model/home/home_view_model.dart';
import 'package:smile_life/core/view_model/my_store/my_store_view_model.dart';
import 'package:smile_life/utils/constants/kButton.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:smile_life/utils/constants/kAlert.dart';
import 'package:smile_life/utils/constants/kAppBar.dart';
import 'package:smile_life/utils/enum/home_enum.dart';
import 'package:smile_life/view/02_Home/01_all_store/all_store.dart';
import 'package:smile_life/view/02_Home/02_my_store/my_store.dart';
import 'package:smile_life/view/02_Home/04_Crud/crud.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeVM = Get.put(HomeViewModel());
  final myStoreVM = Get.put(MyStoreViewModel());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        alertBackPressed();
        return Future(() => false);
      },
      child: Scaffold(
        appBar: kAppBarHome('Home'),
        body: RefreshIndicator(
          onRefresh: () => Future(() {
            setState(() {
              print('refresh');
            });
          }),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [_homeView()],
            ),
          ),
        ),
        floatingActionButton: _floatingButton(),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }

  Widget _homeView() {
    return Obx(
      () {
        return Column(
          children: [
            if (homeVM.bottomNavigation.value == BottomNavigation.allStore) ...[
              AllStore(),
            ] else if (homeVM.bottomNavigation.value ==
                BottomNavigation.myStore) ...[
              MyStore(),
            ] else
              ...[],
          ],
        );
      },
    );
  }

  Widget _floatingButton() {
    return Obx(() {
      var _onTap = () => print('onTap');
      IconData _iconData = Icons.add;

      if (homeVM.bottomNavigation.value == BottomNavigation.myStore) {
        // 나의 상점에 진입했다면

        if (myStoreVM.haveStore.value) {
          // 나의 상점을 만든적이 있다면

          if (myStoreVM.isEditMode.value) {
            // 나의 상점이 지금 편집모드라면
            _iconData = Icons.check;
            _onTap = () => myStoreVM.setCompleteMode();
          } else {
            // 나의 상점이 지금 편집모드가 아니라면
            _iconData = Icons.edit;
            _onTap = () => myStoreVM.setEditMode();
          }
        } else {
          // 나의 상점을 아직 안만들었다면
          _iconData = Icons.add;
          _onTap = () async {
            await myStoreVM.makeMyStore();
            await Future.delayed(Duration(seconds: 3));
            setState(() {});
          };
        }
        return GestureDetector(
          onTap: _onTap,
          child: Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kColorPrimary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(4, 4),
                  blurRadius: 3.sp,
                ),
              ],
            ),
            child: Icon(_iconData, color: Colors.white, size: 28.sp),
          ),
        );
      } else {
        return SizedBox();
      }
    });
  }

  Widget _bottomNavigationBar() {
    return Container(
      alignment: Alignment.center,
      height: 60.h,
      decoration: kButtonUnderLine().copyWith(
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1.sp)],
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bottomNavigationCard('모든 상점', tag: '모든 상점'),
          _bottomNavigationCard('나의 상점', tag: '나의 상점'),
          _bottomNavigationCard('설정', tag: '설정'),
        ],
      ),
    );
  }

  Widget _bottomNavigationCard(String hint, {required String tag}) {
    return Obx(
      () {
        var _onTap = () => print('onTap');
        IconData _iconData = Icons.bookmark;
        Color _color = Colors.black.withOpacity(0.3);

        switch (tag) {
          case '모든 상점':
            _onTap =
                () => homeVM.setBottomNavigation(BottomNavigation.allStore);
            _iconData = Icons.bookmarks_rounded;
            if (homeVM.bottomNavigation.value == BottomNavigation.allStore) {
              _color = Colors.black;
            }
            break;
          case '나의 상점':
            _onTap = () => homeVM.setBottomNavigation(BottomNavigation.myStore);
            _iconData = Icons.bookmark;
            if (homeVM.bottomNavigation.value == BottomNavigation.myStore) {
              _color = Colors.black;
            }
            break;
          case '설정':
            _onTap = () {
              homeVM.setBottomNavigation(BottomNavigation.setting);
              Get.to(() => Crud());
            };
            _iconData = Icons.settings;
            if (homeVM.bottomNavigation.value == BottomNavigation.setting) {
              _color = Colors.black;
            }
            break;
        }
        return GestureDetector(
          onTap: _onTap,
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_iconData, color: _color),
                Text(tag, style: k14w400.copyWith(color: _color)),
              ],
            ),
            width: 70.w,
          ),
        );
      },
    );
  }
}

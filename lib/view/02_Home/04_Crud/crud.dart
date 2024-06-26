// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:smile_life/utils/constants/kAlert.dart';
import 'package:smile_life/utils/constants/kAppBar.dart';

import '01_Create/01_create.dart';
import '02_Read/01_read.dart';
import '03_Update/01_update.dart';
import '04_Delete/01_delete.dart';

class Crud extends StatefulWidget {
  const Crud({Key? key}) : super(key: key);

  @override
  _CrudState createState() => _CrudState();
}

class _CrudState extends State<Crud> {
  // final dashViewModel = Get.put(DashViewModel());

  @override
  void initState() {
    super.initState();
    // dashViewModel.fetchDash();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        alertBackPressed();
        return Future(() => false);
      },
      child: Scaffold(
        appBar: kAppBar('CRUD'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.h),
            _fourButton(),
          ],
        ),
      ),
    );
  }

  Widget _fourButton() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Row(
            children: [
              _createButton(),
              SizedBox(width: 20.w),
              _readButton(),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Row(
            children: [
              _updateButton(),
              SizedBox(width: 20.w),
              _deleteButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _createButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Get.to(() => Create());
        },
        child: Container(
          height: 90.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 1.25),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'images/HomeSensor.png',
              //   fit: BoxFit.fill,
              // ),
              SizedBox(height: 10.h),
              Text('Create', style: k16w500)
            ],
          ),
        ),
      ),
    );
  }

  Widget _readButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Get.to(() => Read());
        },
        child: Container(
          height: 90.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 1.25),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'images/HomeGallery.png',
              //   fit: BoxFit.fill,
              // ),
              SizedBox(height: 10.h),
              Text('Read', style: k16w500)
            ],
          ),
        ),
      ),
    );
  }

  Widget _updateButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Get.to(() => Update());
        },
        child: Container(
          height: 90.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 1.25),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   width: 40.w,
              //   height: 40.w,
              //   child: Image.asset(
              //     'images/HomeMyPage.png',
              //     fit: BoxFit.fill,
              //   ),
              // ),
              SizedBox(height: 10.h),
              Text('Update', style: k16w500)
            ],
          ),
        ),
      ),
    );
  }

  Widget _deleteButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Get.to(() => Delete());
        },
        child: Container(
          height: 90.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 1.25),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //     width: 40.w,
              //     height: 40.w,
              //     child: Image.asset(
              //       'images/HomeQnA.png',
              //       fit: BoxFit.fill,
              //     ),),
              SizedBox(height: 10.h),
              Text('Delete', style: k16w500)
            ],
          ),
        ),
      ),
    );
  }
}

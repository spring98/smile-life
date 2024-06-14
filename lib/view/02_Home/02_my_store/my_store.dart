// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smile_life/core/services/user/common_service.dart';
import 'package:smile_life/core/view_model/home/home_view_model.dart';
import 'package:smile_life/core/view_model/my_store/my_store_view_model.dart';
import 'package:smile_life/models/product_model.dart';
import 'package:smile_life/models/user_model.dart';
import 'package:smile_life/utils/constants/kButton.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:smile_life/utils/constants/kProgressIndicator.dart';

class MyStore extends StatefulWidget {
  const MyStore({Key? key}) : super(key: key);

  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  final homeVM = Get.put(HomeViewModel());
  final myStoreVM = Get.put(MyStoreViewModel());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      future: myStoreVM.fetchMyStore(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (myStoreVM.getUserModel[0].isHaveStore) ...[
                _storeExplain(),
                _storeCardList(),
              ] else ...[
                SizedBox(height: 20.h),
                const Text('상점을 개설해 보세요.')
              ]
            ],
          );
        } else {
          return kProgressIndicator();
        }
      },
    );
  }

  Widget _storeExplain() {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('상점 설명 : ${myStoreVM.getUserModel[0].storeExplain}',
              style: k14w400.copyWith(color: Colors.red)),
          SizedBox(height: 5.h),
          Text('전화번호 : ${Session.phone}', style: k14w400),
          SizedBox(height: 5.h),
          Text('계좌번호 : ${myStoreVM.getUserModel[0].account}', style: k14w400),
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
    return FutureBuilder<List<List<ProductModel>>>(
      future: myStoreVM.fetchProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// 카테고리의 개수를 가져오면 되겠다.
              for (int categoryIndex = 0;
                  categoryIndex < myStoreVM.getCategoryModelList.length;
                  categoryIndex++) ...[
                _storeCard(categoryIndex),
              ],
              SizedBox(height: 15.w),
              GestureDetector(
                onTap: () async {
                  await myStoreVM.addCategory();
                  // setState(() {});
                  stateUpdate();
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
        } else {
          return GestureDetector(
            onTap: () async {
              await myStoreVM.addCategory();
              // setState(() {});
              stateUpdate();
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
          );
          // SizedBox(height: 15.w),
        }
      },
    );
  }

  /// 카테고리 + 사진 + 상품설명 (가로로 한줄 전체)
  Widget _storeCard(int categoryIndex) {
    return Container(
      // color: kColorPrimary,
      decoration: kButtonUnderLine(color: Colors.black.withOpacity(0.1)),
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              '카테고리 : ${myStoreVM.getCategoryModelList[categoryIndex][0].category}',
              style: k14w400),
          SizedBox(height: 10.h),
          _productCardList(categoryIndex)
        ],
      ),
    );
  }

  /// 사진 + 상품설명 (1개 카테고리에 대한 전체 상품)
  Widget _productCardList(int categoryIndex) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (int productIndex = 0;
                  productIndex <
                      myStoreVM.getCategoryModelList[categoryIndex].length;
                  productIndex++) ...[
                _productCard(categoryIndex, productIndex),
              ],
              GestureDetector(
                onTap: () async {
                  print('상품추가하기');
                  print('지금 몇번째 카테고리? $categoryIndex');
                  await myStoreVM.addProduct(categoryIndex);

                  // setState(() {});
                  stateUpdate();
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
  Widget _productCard(int categoryIndex, int productIndex) {
    return Stack(
      children: [
        _productCompleteCard(categoryIndex, productIndex),
        Obx(() {
          if (myStoreVM.isEditMode.value) {
            return Container(
              alignment: Alignment.topRight,
              width: 200.w,
              height: 200.w,
              child: GestureDetector(
                onTap: () async {
                  await myStoreVM.editProduct(
                      categoryIndex: categoryIndex,
                      id: myStoreVM
                          .getCategoryModelList[categoryIndex][productIndex]
                          .id);
                  // setState(() {});
                  stateUpdate();
                },
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  color: Colors.black.withOpacity(0.6),
                  child: Icon(Icons.clear, size: 25.sp, color: Colors.white),
                ),
              ),
            );
          } else {
            return Container();
          }
        }),
      ],
    );
  }

  Widget _productCompleteCard(int categoryIndex, int productIndex) {
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
            width: dynamicSize,
            child: CachedNetworkImage(
              imageUrl: myStoreVM
                  .getCategoryModelList[categoryIndex][productIndex].url,
              placeholder: (context, url) => CircularProgressIndicator(),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
              myStoreVM.getCategoryModelList[categoryIndex][productIndex].name),
          Text(myStoreVM
              .getCategoryModelList[categoryIndex][productIndex].explain)
        ],
      ),
    );
  }

  Future<void> stateUpdate() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {});
    });
  }
}

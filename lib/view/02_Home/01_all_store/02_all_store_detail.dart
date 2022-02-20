// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smile_life/core/services/user/common_service.dart';
import 'package:smile_life/core/view_model/all_store/all_store_view_model.dart';
import 'package:smile_life/core/view_model/home/home_view_model.dart';
import 'package:smile_life/core/view_model/my_store/my_store_view_model.dart';
import 'package:smile_life/models/product_model.dart';
import 'package:smile_life/models/user_model.dart';
import 'package:smile_life/utils/constants/kAppBar.dart';
import 'package:smile_life/utils/constants/kButton.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:smile_life/utils/constants/kProgressIndicator.dart';
import 'package:smile_life/view/02_Home/01_all_store/03_picture_list.dart';

class AllStoreDetail extends StatefulWidget {
  const AllStoreDetail({Key? key, required this.phone}) : super(key: key);

  final String phone;
  @override
  _AllStoreDetailState createState() => _AllStoreDetailState();
}

class _AllStoreDetailState extends State<AllStoreDetail> {
  final allStoreVM = Get.put(AllStoreViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('All Store Detail'),
      body: FutureBuilder<List<UserModel>>(
        future: allStoreVM.fetchAllStoreDetail(phone: widget.phone),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _storeExplain(),
                    _storeCardList(),
                  ],
                ),
              ),
            );
          } else {
            return kProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _storeExplain() {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('상점 설명 : ${allStoreVM.getUserDetailModel[0].storeExplain}',
              style: k14w400),
          SizedBox(height: 5.h),
          Text('전화번호 : ${allStoreVM.getUserDetailModel[0].phoneNumber}',
              style: k14w400),
          SizedBox(height: 5.h),
          Text('계좌번호 : ${allStoreVM.getUserDetailModel[0].account}',
              style: k14w400),
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
      future: allStoreVM.fetchAllStoreDetailProduct(phone: widget.phone),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (allStoreVM.getCategoryModelList.isEmpty) ...[
                Column(
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                        '${allStoreVM.getUserDetailModel[0].name} 님은 아직 상품을 등록하지 않았습니다.')
                  ],
                )
              ] else ...[
                /// 카테고리의 개수를 가져오면 되겠다.
                for (int categoryIndex = 0;
                    categoryIndex < allStoreVM.getCategoryModelList.length;
                    categoryIndex++) ...[
                  _storeCard(categoryIndex),
                ],
              ],
              SizedBox(height: 15.w),
            ],
          );
        } else {
          return kProgressIndicator();
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
              '카테고리 : ${allStoreVM.getCategoryModelList[categoryIndex][0].category}',
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
                      allStoreVM.getCategoryModelList[categoryIndex].length;
                  productIndex++) ...[
                _productCard(categoryIndex, productIndex),
              ],
            ],
          ),
        ],
      ),
    );
  }

  /// 1개 카테고리에 대한 상품 리스트 중 1개의 상품
  Widget _productCard(int categoryIndex, int productIndex) {
    return _productCompleteCard(categoryIndex, productIndex);
  }

  Widget _productCompleteCard(int categoryIndex, int productIndex) {
    // print('categoryIndex : $categoryIndex');
    // print('productIndex : $productIndex');
    double dynamicSize = 200.w;
    return GestureDetector(
      onTap: () {
        print('categoryIndex : $categoryIndex');
        print('productIndex : $productIndex');

        /// Photo view 적용 한 클래스
        Get.to(
            () => PictureList(
                categoryIndex: categoryIndex, productIndex: productIndex),
            transition: Transition.noTransition);
      },
      child: Container(
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
                imageUrl: allStoreVM
                    .getCategoryModelList[categoryIndex][productIndex].url,
                placeholder: (context, url) => Container(
                    // margin: EdgeInsets.only(
                    //     left: 80.w, right: 80.w, top: 80.h, bottom: 80.h),
                    // width: 30.w,
                    // height: 30.w,
                    child: CircularProgressIndicator()),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 10.h),
            Text(allStoreVM
                .getCategoryModelList[categoryIndex][productIndex].name),
            Text(allStoreVM
                .getCategoryModelList[categoryIndex][productIndex].explain)
          ],
        ),
      ),
    );
  }

  Future<void> stateUpdate() async {
    await Future.delayed(const Duration(seconds: 5), () {
      setState(() {});
    });
  }
}

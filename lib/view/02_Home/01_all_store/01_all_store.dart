import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smile_life/core/view_model/all_store/all_store_view_model.dart';
import 'package:smile_life/utils/constants/kButton.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:smile_life/utils/constants/kProgressIndicator.dart';
import 'package:smile_life/view/02_Home/01_all_store/02_all_store_detail.dart';

class AllStore extends StatefulWidget {
  const AllStore({Key? key}) : super(key: key);

  @override
  _AllStoreState createState() => _AllStoreState();
}

class _AllStoreState extends State<AllStore> {
  final allStoreVM = Get.put(AllStoreViewModel());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: allStoreVM.fetchAllUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _storeCardList();
        } else {
          return kProgressIndicator();
        }
      },
    );
  }

  Widget _storeCardList() {
    return Column(
      children: [
        SizedBox(height: 10.h),
        if (allStoreVM.getUserModel.isEmpty) ...[
          Column(
            children: [
              SizedBox(height: 20.h),
              Text('상점을 등록한 사람이 없습니다.'),
            ],
          )
        ] else ...[
          for (int i = 0; i < allStoreVM.getUserModel.length; i++) ...[
            _storeCard(i),
          ]
        ]
      ],
    );
  }

  Widget _storeCard(int index) {
    return GestureDetector(
      onTap: () {
        Get.to(() =>
            AllStoreDetail(phone: allStoreVM.getUserModel[index].phoneNumber));
      },
      child: Container(
        decoration: kButtonUnderLine(color: Colors.black.withOpacity(0.1)),
        padding:
            EdgeInsets.only(top: 10.h, bottom: 10.h, left: 15.w, right: 15.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100.w,
              height: 100.w,
              child: CachedNetworkImage(
                imageUrl: allStoreVM.getUserModel[index].userPhoto,
                fit: BoxFit.fill,
                placeholder: (context, s) => kProgressIndicator(),
              ),
            ),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(allStoreVM.getUserModel[index].storeName, style: k16w400),
                SizedBox(height: 5.h),
                Text(allStoreVM.getUserModel[index].name,
                    style:
                        k14w400.copyWith(color: Colors.black.withOpacity(0.8))),
                SizedBox(height: 5.h),
                Text(allStoreVM.getUserModel[index].division,
                    style:
                        k14w400.copyWith(color: Colors.black.withOpacity(0.8))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

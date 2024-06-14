import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smile_life/core/view_model/all_store/all_store_view_model.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PictureList extends StatefulWidget {
  const PictureList(
      {Key? key, required this.categoryIndex, required this.productIndex})
      : super(key: key);
  final int categoryIndex;
  final int productIndex;
  @override
  _PictureListState createState() => _PictureListState();
}

class _PictureListState extends State<PictureList> {
  final allStoreVM = Get.put(AllStoreViewModel());
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.productIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.w),
              child: _productCardList(widget.categoryIndex),
            ),
            Container(
              alignment: Alignment.centerRight,
              // color: Colors.yellow,
              height: 50.w,
              width: 360.w,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: EdgeInsets.only(right: 5.w),
                  color: Colors.black.withOpacity(0.5),
                  width: 50.w,
                  height: 50.w,
                  child: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _productCardList(int categoryIndex) {
    return PhotoViewGallery.builder(
      pageController: pageController,
      scrollDirection: Axis.horizontal,
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int productIndex) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(
              allStoreVM.getCategoryModelList[categoryIndex][productIndex].url),

          // initialScale: PhotoViewComputedScale.contained * 0.8,
          minScale: PhotoViewComputedScale.contained * 1.0,
          // maxScale: PhotoViewComputedScale.covered * 1.1,
          // heroAttributes: HeroAttributes(tag: galleryItems[index].id),
        );
      },
      itemCount: allStoreVM.getCategoryModelList[categoryIndex].length,
      loadingBuilder: (context, _progress) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: _progress == null
                ? null
                : (_progress.cumulativeBytesLoaded /
                        _progress.expectedTotalBytes!)
                    .toDouble(),
          ),
        ),
      ),
      // backgroundDecoration: widget.backgroundDecoration,
      // pageController: widget.pageController,
      // onPageChanged: onPageChanged,
    );
  }
}

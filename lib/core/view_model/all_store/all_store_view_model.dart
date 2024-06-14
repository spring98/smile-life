import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smile_life/core/services/all_store/all_store_service.dart';
import 'package:smile_life/models/product_model.dart';
import 'package:smile_life/models/user_model.dart';

class AllStoreViewModel extends GetxController {
  final AllStoreService _allStoreService = AllStoreService();

  // store info
  RxString storeName = ''.obs;
  RxString storeExplain = ''.obs;
  RxString accountNumber = ''.obs;
  RxString division = ''.obs;
  RxBool haveStore = false.obs;
  RxString userPhoto = ''.obs;

  List<UserModel> _userModel = [];
  List<UserModel> get getUserModel => _userModel;

  Future<List<UserModel>> fetchAllUser() async {
    List<dynamic> result = await _allStoreService.fetchAllUser();
    _userModel = [];
    for (int i = 0; i < result.length; i++) {
      if (result[i].value['isHaveStore']) {
        _userModel.add(UserModel.fromJson(result[i].value));
      }
    }

    return getUserModel;
  }

  List<UserModel> _userDetailModel = [];
  List<UserModel> get getUserDetailModel => _userDetailModel;

  Future<List<UserModel>> fetchAllStoreDetail({required String phone}) async {
    Map<dynamic, dynamic> result =
        await _allStoreService.fetchAllStoreDetail(phone: phone);

    _userDetailModel = [];
    if (result.isNotEmpty) {
      _userDetailModel.add(UserModel.fromJson(result));
    }

    return getUserModel;
  }

  ///
  ///
  ///

  List<String> _categoryList = [];
  final List<int> _idList = [];

  List<ProductModel> _productModel = [];

  List<ProductModel> _categoryModel = [];
  List<List<ProductModel>> _categoryModelList = [];
  List<List<ProductModel>> get getCategoryModelList => _categoryModelList;

  int categoryCount = 0;
  int productMaxCount = 0;

  Future<List<List<ProductModel>>> fetchAllStoreDetailProduct(
      {required String phone}) async {
    List<dynamic> result =
        await _allStoreService.fetchAllStoreDetailProduct(phone: phone);

    _productModel = [];
    _categoryModelList = [];
    _categoryModel = [];
    _categoryList = [];

    for (int i = 0; i < result.length; i++) {
      _productModel.add(ProductModel.fromJson(result[i].value));
      _categoryList.add(_productModel[i].category);
      _idList.add(int.parse(_productModel[i].id));
    }

    _categoryList = _categoryList.toSet().toList();
    // 카테고리의 개수(중복 없이)
    categoryCount = _categoryList.length;
    // 물건의 갯수(카테고리 중복 포함)
    productMaxCount = _idList.reduce(max) + 1;

    for (var category in _categoryList) {
      for (int i = 0; i < _productModel.length; i++) {
        if (category == _productModel[i].category) {
          _categoryModel.add(_productModel[i]);
        }
      }
      _categoryModelList.add(_categoryModel);
      _categoryModel = [];
    }

    // for (var tmps in tmpList) {
    //   for (var tmp in tmps) {
    //     print(tmp.category);
    //   }
    // }

    return _categoryModelList;
  }
}

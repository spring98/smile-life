// ignore_for_file: avoid_print

import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_life/core/services/my_store/my_store_service.dart';
import 'package:smile_life/models/product_model.dart';
import 'package:smile_life/models/user_model.dart';
import 'package:smile_life/utils/constants/kAlert.dart';
import 'package:smile_life/utils/open_gallery.dart';

class MyStoreViewModel extends GetxController {
  final MyStoreService _myStoreService = MyStoreService();

  // store info
  RxString storeName = ''.obs;
  RxString storeExplain = ''.obs;
  RxString accountNumber = ''.obs;
  RxString division = ''.obs;
  RxBool haveStore = false.obs;
  RxBool isEditMode = false.obs;

  // product info
  RxString productCategory = ''.obs;
  RxString productName = ''.obs;
  RxString productExplain = ''.obs;
  RxString productUrl = ''.obs;

  String imageURL = '';

  void setEditMode() {
    isEditMode.value = true;
  }

  void setCompleteMode() {
    isEditMode.value = false;
  }

  /// Store TextField
  void setStoreName(String storeName) {
    this.storeName.value = storeName;
  }

  /// Store TextField
  void setStoreExplain(String storeExplain) {
    this.storeExplain.value = storeExplain;
  }

  /// Store TextField
  void setAccountNumber(String accountNumber) {
    this.accountNumber.value = accountNumber;
  }

  /// Store TextField
  void setDivision(String division) {
    this.division.value = division;
  }

  /// Category 추가 TextField Setter
  void setCategory(String category) {
    productCategory.value = category;
  }

  /// Product TextField
  void setProductName(String productName) {
    this.productName.value = productName;
  }

  /// Product TextField
  void setProductExplain(String productExplain) {
    this.productExplain.value = productExplain;
  }

  /// Product TextField
  Future<void> setProductUrl() async {
    String url = await getPicker();
    productUrl.value = url;
  }

  /// Test 용 삭제할꺼
  void setStoreDisable() {
    haveStore.value = false;
  }

  Future<void> makeMyStore() async {
    if (await alertMakeStore('') == 'yes') {
      if (await alertYesOrNo('상점을 개설하시겠습니까?') == 'yes') {
        alertLoading();
        await _myStoreService.makeMyStore(
          storeName.value,
          storeExplain.value,
          division.value,
          accountNumber.value,
          productUrl.value,
        );
        haveStore.value = true;
        fieldClear();
        Get.back();
        alert('성공적으로 상점을 개설했습니다.');
      }
    }
  }

  void fieldClear() {
    productUrl.value = '';
    productName.value = '';
    productExplain.value = '';
    productCategory.value = '';
  }

  Future<void> addCategory() async {
    if (await alertAddCategory('') == 'yes') {
      // 입력한 카테고리가 이미 있는지 확인
      if (_categoryList.contains(productCategory.value)) {
        // 입력한 카테고리가 이미 존재
        alert('해당 카테고리가 이미 존재합니다.');
      } else {
        // 입력한 카테고리 사용가능
        if (await alertYesOrNo('카테고리를 등록하시겠습니까?') == 'yes') {
          alertLoading();
          await _myStoreService.addCategory(
              category: productCategory.value,
              explain: productExplain.value,
              name: productName.value,
              url: productUrl.value,
              index: productMaxCount);
          haveStore.value = true;
          fieldClear();
          Get.back();
          alert('성공적으로 카테고리를 등록하였습니다.');
        }
      }
    }
  }

  Future<void> addProduct(int categoryIndex) async {
    if (await alertAddProduct('', category: _categoryList[categoryIndex]) ==
        'yes') {
      if (await alertYesOrNo('상품을 등록하시겠습니까?') == 'yes') {
        alertLoading();
        await _myStoreService.addProduct(
          category: _categoryList[categoryIndex],
          explain: productExplain.value,
          name: productName.value,
          url: productUrl.value,
          index: productMaxCount,
        );
        fieldClear();
        Get.back();
        alert('성공적으로 상품을 등록하였습니다.');
      }
    }
  }

  List<UserModel> _userModel = [];
  List<UserModel> get getUserModel => _userModel;

  Future<List<UserModel>> fetchMyStore() async {
    Map<dynamic, dynamic> result = await _myStoreService.fetchMyStore();
    print(result);
    // print(result['isHaveStore']);
    _userModel = [];
    _userModel.add(UserModel.fromJson(result));

    haveStore.value = _userModel[0].isHaveStore;
    print('------------');
    print(_userModel);
    print(_userModel[0].isHaveStore);

    return getUserModel;
  }

  Future<void> editProduct(
      {required int categoryIndex, required String id}) async {
    String deleteResult = await alertDeleteProduct('', id: id);
    if (deleteResult == 'yes') {
      // 삭제하기 눌렀을 때
      if (await alertYesOrNo('정말로 삭제하시겠습니까?') == 'yes') {
        await _myStoreService.deleteProduct(id: id);
        alert('성공적으로 삭제되었습니다.');
      }
    } else if (deleteResult == 'no') {
      // 편집하기 눌렀을 때
      if (await alertEditProduct('', id: id) == 'yes') {
        // 정말로 편집하기 눌렀을 때
        if (await alertYesOrNo('정말로 편집하시겠습니까?') == 'yes') {
          alertLoading();
          await _myStoreService.editProduct(
            category: _categoryList[categoryIndex],
            explain: productExplain.value,
            name: productName.value,
            url: productUrl.value,
            id: id,
          );
          fieldClear();
          Get.back();
          alert('성공적으로 편집되었습니다.');
        }
      }
    }
    isEditMode.value = false;
  }

  Future<Map<dynamic, dynamic>> fetchProductById({required String id}) async {
    Map<dynamic, dynamic> result =
        await _myStoreService.fetchProductById(id: id);
    productName.value = result['name'];
    productExplain.value = result['explain'];
    productUrl.value = result['url'];

    return result;
  }

  RxMap<String, String> idImageMap = <String, String>{}.obs;
  Future<Map<String, String>> fetchProductImage() async {
    idImageMap.value = await _myStoreService.fetchProductImage();
    // _myStoreService.fetchProductImage().then((value) {
    //   idImageMap.value = value;
    // });

    return idImageMap;
  }

  /// ================================= ///
  /// 삭제하면 안되는 원본
  // List<ProductModel> _productModel = [];
  // List<ProductModel> get getProductModel => _productModel;
  //
  // /// 뷰에서 이놈을 호춣하면 여기서 Title, Sub, Detail 순서대로 부를 것이다.
  // Future<List<ProductModel>> fetchProduct() async {
  //   List<dynamic> result = await _myStoreService.fetchProduct();
  //
  //   // List<String> a = ['a', 'b', 'a', 'c'];
  //   // print(a.toSet().toList());
  //
  //   _productModel = [];
  //
  //   for (int i = 0; i < result.length; i++) {
  //     _productModel.add(ProductModel.fromJson(result[i].value));
  //   }
  //
  //   return getProductModel;
  // }
  /// ================================= ///

  /// ================================= ///
  /// 원본에 실험적 기능 추가해서 테스트

  List<String> _categoryList = [];
  final List<int> _idList = [];

  List<ProductModel> _productModel = [];

  List<ProductModel> _categoryModel = [];
  List<List<ProductModel>> _categoryModelList = [];
  List<List<ProductModel>> get getCategoryModelList => _categoryModelList;

  int categoryCount = 0;
  int productMaxCount = 0;

  Future<List<List<ProductModel>>> fetchProduct() async {
    List<dynamic> result = await _myStoreService.fetchProduct();

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

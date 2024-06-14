import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:smile_life/core/services/user/common_service.dart';

class MyStoreService {
  final DatabaseReference _myStoreRef = FirebaseDatabase.instance.ref('users');
  final FirebaseStorage _imageStorage = FirebaseStorage.instance;

  Future<void> makeMyStore(String storeName, String storeExplain,
      String division, String account, String userPhotoUrl) async {
    String downLoadUrl = '';
    if (userPhotoUrl.isNotEmpty) {
      await _imageStorage
          .ref('${Session.phone}/userPhoto.png')
          .putFile(File(userPhotoUrl));

      downLoadUrl = await _imageStorage
          .ref('${Session.phone}/userPhoto.png')
          .getDownloadURL();
    }
    _myStoreRef.child(Session.phone).update({
      'storeName': storeName,
      'storeExplain': storeExplain,
      'division': division,
      'account': account,
      'isHaveStore': true,
      'userPhoto': downLoadUrl,
      'phoneNumber': Session.phone,
    });
  }

  Future<void> addCategory(
      {required String category,
      required String explain,
      required String name,
      required String url,
      required int index}) async {
    String downLoadUrl = '';
    if (url.isNotEmpty) {
      await _imageStorage
          .ref('${Session.phone}/${index.toString()}.png')
          .putFile(File(url));

      downLoadUrl = await _imageStorage
          .ref('${Session.phone}/${index.toString()}.png')
          .getDownloadURL();
    }
    _myStoreRef
        .child(Session.phone)
        .child('product')
        .child(index.toString())
        .update({
      'category': category,
      'explain': explain,
      'name': name,
      'url': downLoadUrl,
      'id': index.toString(),
    });
  }

  Future<void> addProduct(
      {required String category,
      required String explain,
      required String name,
      required String url,
      required int index}) async {
    String downLoadUrl = '';
    if (url.isNotEmpty) {
      await _imageStorage
          .ref('${Session.phone}/${index.toString()}.png')
          .putFile(File(url));

      downLoadUrl = await _imageStorage
          .ref('${Session.phone}/${index.toString()}.png')
          .getDownloadURL();
    }

    _myStoreRef
        .child(Session.phone)
        .child('product')
        .child(index.toString())
        .update({
      'category': category,
      'explain': explain,
      'name': name,
      'url': downLoadUrl,
      'id': index.toString(),
    });
  }

  Future<void> editProduct(
      {required String category,
      required String explain,
      required String name,
      required String url,
      required String id}) async {
    String downLoadUrl = '';
    if (url.isNotEmpty) {
      print('**');
      print(Session.phone);
      print(id);
      await _imageStorage.ref('${Session.phone}/${id.toString()}.png').delete();
      await _imageStorage
          .ref('${Session.phone}/${id.toString()}.png')
          .putFile(File(url));

      downLoadUrl = await _imageStorage
          .ref('${Session.phone}/${id.toString()}.png')
          .getDownloadURL();
    }

    _myStoreRef.child(Session.phone).child('product').child(id).update({
      'category': category,
      'explain': explain,
      'name': name,
      'url': downLoadUrl,
    });
    // 이미지 저장
  }

  Future<void> deleteProduct({required String id}) async {
    await _myStoreRef.child(Session.phone).child('product').child(id).remove();
    await _imageStorage.ref('${Session.phone}/${id.toString()}.png').delete();
  }

  Future<dynamic> fetchMyStore() async {
    DatabaseEvent value = await _myStoreRef.child(Session.phone).once();
    // print(value.snapshot.value);
    Map<dynamic, dynamic> user = value.snapshot.value as Map;

    return user;
  }

  /// 카테고리 fetch 메소드
  Future<List<dynamic>> fetchProduct() async {
    DatabaseEvent value =
        await _myStoreRef.child(Session.phone).child('product').once();
    // print(value.snapshot.children.length);

    // Map<dynamic, dynamic> user =
    //     value.snapshot.children.toList()[0].value as Map;

    List<dynamic> users = value.snapshot.children.toList();

    // print(users);

    return users;
  }

  Future<dynamic> fetchProductById({required String id}) async {
    DatabaseEvent value = await _myStoreRef
        .child(Session.phone)
        .child('product')
        .child(id)
        .once();

    Map<dynamic, dynamic> users = value.snapshot.value as Map;

    return users;
  }

  Future<Map<String, String>> fetchProductImage() async {
    // String imagePath =
    //     await _imageStorage.ref('${Session.phone}/$id.png').getDownloadURL();

    ListResult imageList = await _imageStorage.ref('01030192029').listAll();
    Map<String, String> idImageMap = {};
    for (var element in imageList.items) {
      String id = element.fullPath.split('/')[1].split('.')[0];
      idImageMap[id] =
          await _imageStorage.ref(element.fullPath).getDownloadURL();
      // urlList.add(
      //     await storage.ref(element.fullPath).getDownloadURL());
      // print(element.fullPath);

    }

    return idImageMap;
  }
}

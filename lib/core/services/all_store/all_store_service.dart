import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:smile_life/core/services/user/common_service.dart';

class AllStoreService {
  final DatabaseReference _myStoreRef = FirebaseDatabase.instance.ref('users');
  final FirebaseStorage _imageStorage = FirebaseStorage.instance;

  Future<List<dynamic>> fetchAllUser() async {
    DatabaseEvent value = await _myStoreRef.once();
    List<dynamic> users = value.snapshot.children.toList();

    return users;
  }

  Future<dynamic> fetchAllStoreDetail({required String phone}) async {
    DatabaseEvent value = await _myStoreRef.child(phone).once();
    // print(value.snapshot.value);
    Map<dynamic, dynamic> user = value.snapshot.value as Map;

    return user;
  }

  /// 카테고리 fetch 메소드
  Future<List<dynamic>> fetchAllStoreDetailProduct(
      {required String phone}) async {
    DatabaseEvent value =
        await _myStoreRef.child(phone).child('product').once();
    List<dynamic> users = value.snapshot.children.toList();

    return users;
  }
}

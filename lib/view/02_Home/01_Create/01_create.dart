// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smile_life/utils/constants/kAppBar.dart';
import 'package:smile_life/utils/constants/kColor.dart';
import 'package:smile_life/utils/constants/kFonts.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  String name = 'Gandi';
  bool isDownLoad = false;
  String url = '';
  String imagePath = '';

  final ImagePicker _picker = ImagePicker();

  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('Create'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _textCreate(),
            SizedBox(height: 10.w),
            GestureDetector(
              onTap: () async {
                print('사진등록 선택');

                String url = await getPicker();
                if (url.isNotEmpty) {
                  print(url);
                  File file = File(url);

                  try {
                    await storage
                        .ref('uploads/file-to-upload2.png')
                        .putFile(file);
                    print('성공적으로 입력');
                  } catch (e) {
                    print('실패 했고 밑에는 에러메세지');
                    print(e);
                    print('=-===========');
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: 100.w,
                height: 100.w,
                color: kColorSub,
                child: Text(
                  '사진 등록하기',
                  style: k14w400.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textCreate() {
    return Column(
      children: [
        Text('현재 이름 : $name'),
        SizedBox(height: 10.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                final DatabaseReference _messagesRef =
                    FirebaseDatabase.instance.ref('users').child(name);
                _messagesRef.set({
                  '내용': '배고파',
                  '나이': 20,
                  '시간': DateTime.now().toString().split(' ')[0],
                });
              },
              child: Container(
                width: 100.w,
                height: 100.w,
                color: kColorPrimary,
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  name = 'Bob';
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: 100.w,
                height: 100.w,
                color: kColorPrimary,
                child: Text(
                  'Bob',
                  style: k14w400.copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  name = 'Powl';
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: 100.w,
                height: 100.w,
                color: kColorPrimary,
                child: Text(
                  'Powl',
                  style: k14w400.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<String> getPicker() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    print('======================= In getPicker()==================');
    if (image != null) {
      // print('getPicker image not null entered ! ');
      // print(image.path);
      return image.path;
    } else {
      return '';
    }
  }
}

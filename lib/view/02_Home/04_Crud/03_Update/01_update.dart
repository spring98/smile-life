import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smile_life/utils/constants/kAppBar.dart';
import 'package:smile_life/utils/constants/kColor.dart';

class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('Update'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                final DatabaseReference _messagesRef =
                    FirebaseDatabase.instance.ref('users').child('Powl');
                _messagesRef.update({
                  '내용': '배불러',
                  '나이': 25,
                  '시간': DateTime.now().toString().split(' ')[0],
                });
              },
              child: Container(
                width: 100.w,
                height: 100.w,
                color: kColorPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

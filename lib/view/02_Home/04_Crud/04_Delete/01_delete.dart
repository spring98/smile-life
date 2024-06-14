import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smile_life/utils/constants/kAppBar.dart';
import 'package:smile_life/utils/constants/kColor.dart';

class Delete extends StatefulWidget {
  const Delete({Key? key}) : super(key: key);

  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('Delete'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                final DatabaseReference _messagesRef =
                    FirebaseDatabase.instance.ref('users');
                _messagesRef.child('Powl').remove();
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

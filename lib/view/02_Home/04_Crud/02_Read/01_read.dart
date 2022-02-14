// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smile_life/utils/constants/kAppBar.dart';
import 'package:smile_life/utils/constants/kColor.dart';

class Read extends StatefulWidget {
  const Read({Key? key}) : super(key: key);

  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  FirebaseStorage storage = FirebaseStorage.instance;
  List<String> urlList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar('Read'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                final DatabaseReference _messagesRef =
                    FirebaseDatabase.instance.ref('users').child('Powl');
                DatabaseEvent value = await _messagesRef.once();
                print(value.snapshot.value);

                print('======================');

                // String pngURL = await storage.ref('test.png').getDownloadURL();
                // print(pngURL);
                // setState(() {
                //   url = pngURL;
                // });

                // print(await storage.ref().list() );
                // await storage.ref('uploads').listAll().then((value) {
                //   for (var element in value.items) {
                //     print(element);
                //   }
                // });

                ListResult imageList = await storage.ref('uploads').listAll();
                for (var element in imageList.items) {
                  urlList.add(
                      await storage.ref(element.fullPath).getDownloadURL());
                  print(element.fullPath);
                }
                setState(() {});
              },
              child: Container(
                width: 100.w,
                height: 100.w,
                color: kColorPrimary,
              ),
            ),
            SizedBox(height: 10.h),
            for (var url in urlList) ...[
              SizedBox(
                width: 100.w,
                height: 100.w,
                child: Image.network(
                  url,
                  fit: BoxFit.fill,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smile_life/view/01_Login/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    fadeIn();
    fadeOut();
    loginPage();
  }

  void fadeIn() {
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        _visible = true;
      });
    });
  }

  void fadeOut() {
    Timer(Duration(milliseconds: 2000), () {
      setState(() {
        _visible = false;
      });
    });
  }

  void loginPage() {
    Timer(Duration(milliseconds: 2500), () {
      Get.to(() => Login());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: SizedBox(
                  width: 150.w,
                  height: 80.w,
                  child: Image.asset(
                    'images/firebaseLogo.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

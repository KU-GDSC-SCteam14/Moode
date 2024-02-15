import 'package:mind_care/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/launch_screen.dart';
import 'package:mind_care/login_page.dart';
import 'dart:async';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 앱의 런치 스크린을 나타내는 위젯
      home: LaunchScreen(),
    );
  }
}

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    // 타이머를 사용하여 2초 후에 홈 화면으로 이동
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'asset/img/logo.png',
          width: 86,
        ),

      ),
    );
  }
}


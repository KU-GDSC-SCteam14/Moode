import 'package:flutter/material.dart';

void main(){
  runApp(LaunchScreen()); // SplashScreen 위젯을 첫 화면으로 지정
}

class LaunchScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){ // 위젯의 UI 구현
    return MaterialApp( // 항상 최상단에 입력되는 위젯
      home: Scaffold( // 항상 두 번째로 입력되는 위젯
        body: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/img/logo.png',
                    width: 86,
                  ),
                  //CircularProgressIndicator(
                   // valueColor: AlwaysStoppedAnimation(
                 //     Colors.white,
                 //   ),
                ],
              ),
            ] ,
          ),
        ),
      ),
    );
  }
}


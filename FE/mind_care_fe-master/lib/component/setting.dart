import 'package:flutter/material.dart';
import 'package:mind_care/screen/home_screen.dart';

// 알림 설정이라도 넣어야 함

class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  State<Setting> createState() => _Setting();
}

class _Setting extends State<Setting> {
  // 계정 설정
  var _accountSetting = Container(
    //alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
    child: Column(
      children: [
        Text(
          '계정 설정',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xff555555),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          '연결된 계정',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          '데이터 백업',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          '데이터 복원',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          '데이터 초기화',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    ),
  );

  // 알림 설정
  var _alarmSetting = Container(
    //alignment: Alignment.left,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
    child: Column(
      children: [
        Text(
          '알림 설정',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xff555555),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          '우울한 날 긍정일기 알림',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          '주간 긍정일기 알림',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          '알림 받을 시간',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    ),
  );

  // 테마 설정
  var _themeSetting = Container(
    //alignment: Alignment.left,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
    child: Column(
      children: [
        Text(
          '테마 설정',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xff555555),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          '테마',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    ),
  );

  var _langaugeSetting = Container(
    //alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
    child: Column(
      children: [
        Text(
          '언어 설정',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xff555555),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          '언어',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(42.0),
          child: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back), // 아이콘
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }),
            title: Text(
              '설정',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
        ),
        // 리스트뷰를 생성
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  _accountSetting,
                  _alarmSetting,
                  _themeSetting,
                  _langaugeSetting
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}

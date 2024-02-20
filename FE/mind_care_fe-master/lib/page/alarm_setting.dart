import 'package:flutter/material.dart';
import 'package:mind_care/component/setting.dart';

class AlarmSetting extends StatefulWidget {
  const AlarmSetting({Key? key}) : super(key: key);

  @override
  State<AlarmSetting> createState() => _AlarmSetting();
}

class _AlarmSetting extends State<AlarmSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(42.0),
        child: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back), // 아이콘
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Setting()),
                );
              }),
          title: Text(
            '알림 설정',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('긍정일기 알림 받기'),

                    // 토글 버튼
                  ]),
            ),

            // 데이터 피커
          ],
        ),
      ),
    );
  }
}

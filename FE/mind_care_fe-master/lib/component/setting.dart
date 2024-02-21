import 'package:flutter/material.dart';
import 'package:mind_care/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

bool _dummy = false;
bool _isChecked = false;
final _days = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
String _selectedDay = '';
TimeOfDay pick_time = TimeOfDay.now();

Future<void> saveNotificationSetting(String userId, TimeOfDay notifyTime) async {
  // 서버 URL
  final Uri serverUrl = Uri.parse('http://34.64.250.30:3000/schedule-notification');
  // 로컬 데이터베이스에 알림 정보 저장 로직 (생략)

  // 서버에 알림 설정 정보 전송
  final response = await http.post(
    serverUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'User_ID': userId,
      'NotifyTime': '${notifyTime.hour}:${notifyTime.minute}:00', // 예: '9:00:00'
    }),
  );

  if (response.statusCode == 201) {
    print('알림 설정 정보가 서버에 성공적으로 저장되었습니다.');
  } else {
    print('서버에 알림 설정 정보를 저장하는 데 실패했습니다: ${response.body}');
  }
}

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _Setting();
}

class _Setting extends State<Setting> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedDay = _days[0];
    });
  }

  // 계정 설정
  final _accountSetting = Container(
    //alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
    child: const Column(
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

  // 테마 설정
  final _themeSetting = Container(
    //alignment: Alignment.left,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
    child: const Column(
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

  // 언어 설정
  final _langaugeSetting = Container(
    //alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
    child: const Column(
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
          preferredSize: const Size.fromHeight(42.0),
          child: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back), // 아이콘
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                }),
            title: const Text(
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
                  Container(
                    //alignment: Alignment.left,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 28),
                    child: Column(
                      children: [
                        const Text(
                          '알림 설정',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff555555),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              '우울한 날 긍정일기 알림',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            CupertinoSwitch(
                              value: _dummy,
                              activeColor: CupertinoColors.activeBlue,
                              onChanged: (bool? value) {
                                setState(() {
                                  _dummy = value ?? false;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              '주간 긍정일기 알림',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            CupertinoSwitch(
                              value: _isChecked,
                              activeColor: CupertinoColors.activeBlue,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value ?? false;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              '알림 받을 시간',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            // 요일 드롭다운 버튼
                            DropdownButton(
                              value: _selectedDay,
                              items: _days
                                  .map((e) => DropdownMenuItem(
                                        value:
                                            e, // 선택 시 onChanged 를 통해 반환할 value
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                // items 의 DropdownMenuItem 의 value 반환
                                setState(() {
                                  _selectedDay = value!;
                                });
                              },
                            ),
                            // time picker
                            // 버튼 누르면 요일/시간/분 선택 피커
                            TextButton(
                              onPressed: () async {
                                final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: pick_time,
                                );
                                if (timeOfDay != null) {
                                  setState(() {
                                    pick_time = timeOfDay;
                                  });
                                }
                              },
                              child:
                                  Text('${pick_time.hour}:${pick_time.minute}'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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

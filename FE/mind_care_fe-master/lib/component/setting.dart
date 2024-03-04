// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mind_care/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _dummy = false;
  bool _isChecked = false;
  final _days = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
  String _selectedDay = '월요일';
  TimeOfDay pick_time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
  }

  Future<void> saveNotificationSetting() async {
    final prefs = await SharedPreferences.getInstance();
    final int? userId =
        prefs.getInt('userid'); // SharedPreferences에서 userid 불러오기
    String? fcmToken =
        prefs.getString('fcmtoken'); // SharedPreferences에서 FCM 토큰 불러오기

    final String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String formattedTime =
        '$formattedDate ${pick_time.hour}:${pick_time.minute}:00';

    if (fcmToken == null) {
      // FCM 토큰이 저장되어 있지 않은 경우 다시 불러오기 시도
      fcmToken = await FirebaseMessaging.instance.getToken();
      // 새로 얻은 FCM 토큰을 다시 SharedPreferences에 저장
      await prefs.setString('fcmToken', fcmToken!);
    }

    print(fcmToken);
    print(userId);
    if (userId != null) {
      final Uri serverUrl =
          Uri.parse('http://34.22.109.189:3000/schedule-notification');

      final response = await http.post(
        serverUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'User_ID': userId,
          'Notifyday': _selectedDay,
          'NotifyTime': formattedTime,
          'FCM_Token': fcmToken,
        }),
      );

      if (response.statusCode == 201) {
        print('알림 설정 정보가 서버에 성공적으로 저장되었습니다.');
      } else {
        print('서버에 알림 설정 정보를 저장하는 데 실패했습니다: ${response.body}');
      }
    } else {
      print('Empty token or user ID');
    }
  }

  // 계정 설정
  final accountSetting = Container(
    //alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
    color: Colors.white,

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '계정 설정',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xffABB0BC),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '연결된 계정',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff555555),
                ),
              ),
              Text(
                'gdsc_sc_team14@gmail.com',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffABB0BC),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '데이터 백업',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff555555),
                ),
              ),
              Text(
                '>',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffABB0BC),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '데이터 복원',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff555555),
                ),
              ),
              Text(
                '>',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffABB0BC),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '데이터 초기화',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff555555),
                ),
              ),
              Text(
                '>',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffABB0BC),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // 테마 설정
  final themeSetting = Container(
    //alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
    color: Colors.white,

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '테마 설정',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xffABB0BC),
          ),
        ),
        Container(
          height: 24,
        ),
        Container(
            child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '테마',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(0xff555555),
              ),
            ),
            Text(
              '시스템 설정',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
                color: Color(0xffABB0BC),
              ),
            ),
          ],
        )),
      ],
    ),
  );

  // 언어 설정
  final langaugeSetting = Container(
    //alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
    color: Colors.white,

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '언어 설정',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xffABB0BC),
          ),
        ),
        Container(
          height: 24,
        ),
        Container(
            child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '언어',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(0xff555555),
              ),
            ),
            Text(
              '한국어',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
                color: Color(0xffABB0BC),
              ),
            ),
          ],
        )),
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
            backgroundColor: Colors.white,
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
                  Container(
                    color: Colors.white,
                    height: 29,
                  ),
                  accountSetting,
                  Container(
                    height: 8,
                    color: const Color(0xffD9D9D9),
                  ),
                  Container(
                    //alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 28),
                    color: Colors.white,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '알림 설정',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffABB0BC),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '우울한 날 긍정일기 알림',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff555555),
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
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '주간 긍정일기 알림',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff555555),
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
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '알림받을 시간',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff555555),
                                ),
                              ),
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
                                child: Text(
                                    '${pick_time.hour}:${pick_time.minute}'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                              ),
                              onPressed: saveNotificationSetting,
                              child: const Text('저장'),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                  Container(
                    height: 8,
                    color: const Color(0xffD9D9D9),
                  ),
                  themeSetting,
                  Container(
                    height: 8,
                    color: const Color(0xffD9D9D9),
                  ),
                  langaugeSetting
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}

import 'package:flutter/material.dart';
import 'package:mind_care/component/body_calendar.dart';
import 'package:mind_care/component/footer_diary_list.dart';
import 'package:mind_care/page/write_diary_pg1.dart';
import 'package:mind_care/component/search_keyword_pg1.dart';
//import 'package:mind_care/page/show_selectedfromlist_diary.dart';
//import 'package:intl/intl.dart';
import 'package:mind_care/component/setting.dart';
import 'package:mind_care/screen/happy_screen.dart';
import 'package:provider/provider.dart';
import 'package:mind_care/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:slider_button/slider_button.dart';
import 'dart:math';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 선택된 날짜를 관리할 변수
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe2e3e4),
      appBar: AppBar(
        title: Image.asset(
          'asset/img/logo_text.png',
          width: 100,
        ),
        centerTitle: true,
        leading: IconButton(
            // 간단한 위젯이나 타이틀들을 앱바의 왼쪽에 위치시키는 것을 말함
            icon: const Icon(Icons.menu, size: 30), // 아이콘
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
            }),
        actions: [
          IconButton(
              icon: const Icon(Icons.search, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchKeyword()),
                );
              }),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          ListView(
            children: [
              // 주간 긍정일기 확인버튼 배너
              Container(
                color: Color(0xfff8f9f9),
                width: 390,
                height: 77,
                padding: EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '주간 긍정일기를 확인해보세요.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xff626262)),
                        ),
                        Container(
                          width: 73,
                          height: 41,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(12)),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Color.fromRGBO(49, 200, 201, 0.15),
                                ),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                )),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HappyDiaryScreen()),
                                );
                              },
                              child: Text(
                                '확인하기',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xff007AFF)),
                              )),
                        )
                      ]),
                ),
              ),

              BodyCalendar(
                selectedDate: selectedDate, // 날짜 전달하기
                onDaySelected: onDaySelected, // 날짜 선택됐을 때 실행할 함수
              ),
              SizedBox(
                height: 4,
              ),
              SelectedDiaryList(
                selectedDate: selectedDate,
              ),
            ],
          ),
          Positioned(
            right: 8,
            left: 8,
            bottom: 50,
            child: SliderButton(
              width: 374,
              height: 74,
              action: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WriteExperience()));

                return true;
              },
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "                슬라이드 해 오늘의 일기를 작성하세요.    ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  Icon(
                    Icons.keyboard_double_arrow_right,
                    color: Colors.white,
                    size: 40,
                  ),
                ],
              ),
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
              backgroundColor: Color.fromRGBO(30, 30, 30, 0.75),
              buttonColor: Color(0xff0A84FF),
              shimmer: false,
              buttonSize: 58,
            ),
          ),
        ],
      )),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    // 날짜 선택될 때마다(탭할 때마다) 실행할 함수
    print(selectedDate);
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}

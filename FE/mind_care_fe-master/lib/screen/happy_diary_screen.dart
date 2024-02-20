import 'package:mind_care/component/happy_week_calendar.dart';
import 'package:mind_care/component/happy_week_diary.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/screen/home_screen.dart';
import 'package:intl/intl.dart';

class HappyDiaryScreen extends StatefulWidget {
  const HappyDiaryScreen({Key? key}) : super(key: key);

  @override
  State<HappyDiaryScreen> createState() => _HappyDiaryScreen();
}

class _HappyDiaryScreen extends State<HappyDiaryScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

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
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }),
          title: Text(
            '주간 긍정일기',
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
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 24,
              ),
              child: Text(
                '${selectedDate.month}월 2주의 행복했던 순간들을\n되돌아보세요.',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            WeekCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
            ShowDiaryfromList(
              selectedDate: selectedDate,
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    // 날짜 선택될 때마다(탭할 때마다) 실행할 함수
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}

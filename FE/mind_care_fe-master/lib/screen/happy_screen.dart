import 'package:mind_care/component/happy_calendar.dart';
import 'package:mind_care/component/happy_diary_list.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/screen/home_screen.dart';
import 'package:intl/intl.dart';

DateTime today = DateTime.now();

int weekOfMonthForSimple(DateTime date) {
  // 월의 첫번째 날짜.
  DateTime _firstDay = DateTime(date.year, date.month, 1);

  // 월중에 첫번째 월요일인 날짜.
  DateTime _firstMonday = _firstDay
      .add(Duration(days: (DateTime.monday + 7 - _firstDay.weekday) % 7));

  // 첫번째 날짜와 첫번째 월요일인 날짜가 동일한지 판단.
  // 동일할 경우: 1, 동일하지 않은 경우: 2 를 마지막에 더한다.
  final bool isFirstDayMonday = _firstDay == _firstMonday;

  final _different = calculateDaysBetween(from: _firstMonday, to: date);

  // 주차 계산.
  int _weekOfMonth = (_different / 7 + (isFirstDayMonday ? 1 : 2)).toInt();
  return _weekOfMonth;
}

int calculateDaysBetween({required DateTime from, required DateTime to}) {
  return (to.difference(from).inHours / 24).round();
}

bool isSameWeek(DateTime dateTime1, DateTime dateTime2) {
  final int _dateTime1WeekOfMonth = weekOfMonthForSimple(dateTime1);
  final int _dateTime2WeekOfMonth = weekOfMonthForSimple(dateTime2);
  return _dateTime1WeekOfMonth == _dateTime2WeekOfMonth;
}

int weekOfMonthForStandard(DateTime date) {
  // 월 주차.
  late int _weekOfMonth;

  // 선택한 월의 첫번째 날짜.
  final _firstDay = DateTime(date.year, date.month, 1);

  // 선택한 월의 마지막 날짜.
  final _lastDay = DateTime(date.year, date.month + 1, 0);

  // 첫번째 날짜가 목요일보다 작은지 판단.
  final _isFirstDayBeforeThursday = _firstDay.weekday <= DateTime.thursday;

  // 선택한 날짜와 첫번째 날짜가 같은 주에 위치하는지 판단.
  if (isSameWeek(date, _firstDay)) {
    // 첫번째 날짜가 목요일보다 작은지 판단.
    if (_isFirstDayBeforeThursday) {
      // 1주차.
      _weekOfMonth = 1;
    }

    // 저번달의 마지막 날짜의 주차와 동일.
    else {
      final _lastDayOfPreviousMonth = DateTime(date.year, date.month, 0);

      // n주차.
      _weekOfMonth = weekOfMonthForStandard(_lastDayOfPreviousMonth);
    }
  } else {
    // 선택한 날짜와 마지막 날짜가 같은 주에 위치하는지 판단.
    if (isSameWeek(date, _lastDay)) {
      // 마지막 날짜가 목요일보다 큰지 판단.
      final _isLastDayBeforeThursday = _lastDay.weekday >= DateTime.thursday;
      if (_isLastDayBeforeThursday) {
        // 주차를 단순 계산 후 첫번째 날짜의 위치에 따라서 0/-1 결합.
        // n주차.
        _weekOfMonth =
            weekOfMonthForSimple(date) + (_isFirstDayBeforeThursday ? 0 : -1);
      }

      // 다음달 첫번째 날짜의 주차와 동일.
      else {
        // 1주차.
        _weekOfMonth = 1;
      }
    }

    // 첫번째주와 마지막주가 아닌 날짜들.
    else {
      // 주차를 단순 계산 후 첫번째 날짜의 위치에 따라서 0/-1 결합.
      // n주차.
      _weekOfMonth =
          weekOfMonthForSimple(date) + (_isFirstDayBeforeThursday ? 0 : -1);
    }
  }

  return _weekOfMonth;
}

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
      backgroundColor: Color(0xffe2e3e4),
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
              color: Colors.white,
              height: 29,
            ),
            Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 24,
                ),
                child: RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${selectedDate.month}월 ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff007AFF),
                      ),
                    ),
                    TextSpan(
                      text: '${weekOfMonthForStandard(today)}주',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff007AFF),
                      ),
                    ),
                    TextSpan(
                      text: '의 행복했던 순간들을',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff555555),
                      ),
                    ),
                    TextSpan(
                      text: '\n되돌아보세요.',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff555555),
                      ),
                    ),
                  ],
                ))),
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

  // (selectedDay, focusedDay) {
  //                 widget.onDaySelected(selectedDay,
  //                     _getEventsForDay(selectedDay, events) as DateTime);
  //                 setState(() {
  //                   //widget.showDate = selectedDay;
  //                 });
  //               },
}

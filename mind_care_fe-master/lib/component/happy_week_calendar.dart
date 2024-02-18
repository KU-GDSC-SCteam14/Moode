import 'package:flutter/material.dart';
//import 'package:flutter_calendar_week/flutter_calendar_week.dart';
//import 'package:weekly_date_picker/weekly_date_picker.dart';
//import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// class WeekCalendar extends StatefulWidget {
//   const WeekCalendar({super.key});
//   @override
//   _WeekCalendar createState() => _WeekCalendar();
// }

class WeekCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected; // 날짜 선택 시 실행할 함수
  final DateTime selectedDate; // 선택된 날짜

  WeekCalendar({
    super.key,
    required this.onDaySelected,
    required this.selectedDate,
  });

  //DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: TableCalendar(
          calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
            _calendarFormat = format;
          },
          onDaySelected: onDaySelected,
          // 날짜 선택 시 실행할 함수
          selectedDayPredicate: (date) =>
              date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day,
          focusedDay: DateTime.now(), // 화면에 보여지는 날
          firstDay: DateTime(1900, 1, 1), // 첫째 날
          lastDay: DateTime(2999, 12, 31), // 마지막 날
          headerStyle: const HeaderStyle(
            // 달력 최상단 스타일
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          calendarStyle: CalendarStyle(
            // 캘린더 스타일
            isTodayHighlighted: false,
            defaultDecoration: BoxDecoration(
              // 기본 평일 날짜 스타일
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffEAEAF0),
            ),
            weekendDecoration: BoxDecoration(
              // 주말 날짜 스타일
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffEAEAF0),
            ),
            selectedDecoration: BoxDecoration(
              // 선택한 날짜 스타일
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xff007AFF),
            ),
            defaultTextStyle: const TextStyle(
              // 기본 평일 글꼴
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            weekendTextStyle: const TextStyle(
              // 주말 날짜 글꼴
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            selectedTextStyle: const TextStyle(
              // 선택한 날짜 글꼴
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        // child: WeeklyDatePicker(
        //   selectedDay: _selectedDay,
        //   changeDay: (value) => setState(() {
        //     _selectedDay = value;
        //   }),
        //   enableWeeknumberText: false,
        //   weeknumberColor: Colors.black,
        //   weeknumberTextColor: Colors.black,
        //   backgroundColor: const Color(0xffEAEAF0),
        //   weekdayTextColor: Colors.black,
        //   digitsColor: Colors.black,
        //   selectedDigitBackgroundColor: Colors.blue,
        //   weekdays: const ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
        //   daysInWeek: 7,
        // ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

class BodyCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected; // 날짜 선택 시 실행할 함수
  final DateTime selectedDate; // 선택된 날짜

  const BodyCalendar({
    super.key,
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    // Use the CalendarData instance to get the selected date
    //DateTime selectedDate = Provider.of<CalendarData>(context).selectedDate;


    return SingleChildScrollView(
      child: Center(
        child: TableCalendar(

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
      ),
    );

    //return YourCalendarWidgetImplementation(selectedDate);
  }
}

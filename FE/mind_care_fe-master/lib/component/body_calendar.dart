import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';
import 'package:mind_care/page/write_diary_pg4.dart';
import 'package:mind_care/component/happy_week_calendar.dart';

class Event {
  int diaryID;

  // String title;
  // bool complete;
  Event(this.diaryID);

  // @override
  // String toString() => title;
}

// 로컬 불러오기
// 일기 쓴 모든 날짜 : [그 날의 모든 diaryIds] 식으로
// 아래는 불러오는 형식 예시
// 시간이 된다면 감정도 불러오기
Map<DateTime, List<Event>> eventSource = {
  DateTime(2024, 2, 3): [
    // Event(1561),
    // Event(1563),
  ],
  DateTime(2024, 2, 8): [
    Event(1568),
    Event(1593),
  ],
  DateTime(2024, 2, 6): [
    Event(1534),
    Event(1555),
  ],
};

class BodyCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected; // 날짜 선택 시 실행할 함수
  final DateTime selectedDate; // 선택된 날짜

  BodyCalendar({
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final events = LinkedHashMap(
      equals: isSameDay,
    )..addAll(eventSource);
    List<Event> getEventsForDay(DateTime day) {
      return events[day] ?? [];
    }

    return SingleChildScrollView(
      child: Center(
        child: TableCalendar(
          eventLoader: (day) {
            return getEventsForDay(day);
          },
          calendarBuilders:
              CalendarBuilders(markerBuilder: (context, date, dynamic event) {
            if (event.isNotEmpty) {
              return Container(
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0),
                  //shape: BoxShape.circle
                ),
              );
            }
          }),
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
              color: Color(0xffEAEAF0),
            ),
            weekendDecoration: BoxDecoration(
              // 주말 날짜 스타일
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xffEAEAF0),
            ),
            selectedDecoration: BoxDecoration(
              // 선택한 날짜 스타일
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xff007AFF),
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
  }
}

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

class Event {
  String title;
  bool complete;
  Event(this.title, this.complete);

  @override
  String toString() => title;
}

class BodyCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected; // 날짜 선택 시 실행할 함수
  final DateTime selectedDate; // 선택된 날짜

  BodyCalendar({
    required this.onDaySelected,
    required this.selectedDate,
  });

  Map<DateTime, dynamic> eventSource = {
    DateTime(2022, 1, 3): [
      Event('5분 기도하기', false),
      Event('교회 가서 인증샷 찍기', true),
      Event('QT하기', true),
      Event('셀 모임하기', false),
    ],
    DateTime(2022, 1, 5): [
      Event('5분 기도하기', false),
      Event('치킨 먹기', true),
      Event('QT하기', true),
      Event('셀 모임하기', false),
    ],
    DateTime(2022, 1, 8): [
      Event('5분 기도하기', false),
      Event('자기 셀카 올리기', true),
      Event('QT하기', false),
      Event('셀 모임하기', false),
    ],
    DateTime(2022, 1, 11): [
      Event('5분 기도하기', false),
      Event('가족과 저녁식사 하기', true),
      Event('QT하기', true)
    ],
    DateTime(2022, 1, 13): [
      Event('5분 기도하기', false),
      Event('교회 가서 인증샷 찍기', true),
      Event('QT하기', false),
      Event('셀 모임하기', false),
    ],
    DateTime(2022, 1, 15): [
      Event('5분 기도하기', false),
      Event('치킨 먹기', false),
      Event('QT하기', true),
      Event('셀 모임하기', false),
    ],
    DateTime(2022, 1, 18): [
      Event('5분 기도하기', false),
      Event('자기 셀카 올리기', true),
      Event('QT하기', false),
      Event('셀 모임하기', false),
    ],
    DateTime(2022, 1, 20): [
      Event('5분 기도하기', true),
      Event('자기 셀카 올리기', true),
      Event('QT하기', true),
      Event('셀 모임하기', true),
    ],
    DateTime(2022, 1, 21): [
      Event('5분 기도하기', false),
      Event('가족과 저녁식사 하기', true),
      Event('QT하기', false)
    ]
  };

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

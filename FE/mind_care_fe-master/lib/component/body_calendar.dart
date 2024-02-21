import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';
import 'package:mind_care/db.dart';
import 'package:mind_care/page/write_diary_pg4.dart';
import 'package:mind_care/component/happy_week_calendar.dart';

class BodyCalendar extends StatefulWidget {
  final OnDaySelected onDaySelected; // 날짜 선택 시 실행할 함수
  final DateTime selectedDate; // 선택된 날짜

  const BodyCalendar({super.key, 
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  _BodyCalendarState createState() => _BodyCalendarState();
}

class _BodyCalendarState extends State<BodyCalendar> {
  late Future<Map<DateTime, List<Event>>> eventSourceFuture;

  @override
  void initState() {
    super.initState();
    eventSourceFuture = DatabaseService.getDiariesByDateForEvents();
  }


  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<Map<DateTime, List<Event>>>(
      future: eventSourceFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('No events found'));
        }

    final events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(snapshot.data!);
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
            return null;
          }),
          onDaySelected: widget.onDaySelected,
          // 날짜 선택 시 실행할 함수
          selectedDayPredicate: (date) =>
              date.year == widget.selectedDate.year &&
              date.month == widget.selectedDate.month &&
              date.day == widget.selectedDate.day,
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
    // 이 함수는 `TableCalendar`의 `hashCode` 설정을 위해 필요합니다.
      }
    );
}
    int getHashCode(DateTime key) {
      return key.day * 1000000 + key.month * 10000 + key.year;
    }
}
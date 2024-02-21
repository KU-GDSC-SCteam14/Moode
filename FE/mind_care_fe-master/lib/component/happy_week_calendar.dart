
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';
import 'package:mind_care/db.dart';

class Event {
  final int diaryID;
  Event(this.diaryID);
}

class WeekCalendar extends StatefulWidget {
  final OnDaySelected onDaySelected; // 날짜 선택 시 실행할 함수
  DateTime selectedDate; // 선택된 날짜

  WeekCalendar({super.key, 
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  _WeekCalendarState createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  late Future<Map<DateTime, List<Event>>> eventsFuture;

  @override
  void initState() {
    super.initState();
    // Fetch the events from the database
    eventsFuture = DatabaseService.gethappyDiariesByDateForEvents() as Future<Map<DateTime, List<Event>>>;
  }

  List<Event> _getEventsForDay(DateTime day, Map<DateTime, List<Event>> events) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<DateTime, List<Event>>>(
      future: eventsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No events found'));
        }

        final events = LinkedHashMap<DateTime, List<Event>>(
          equals: isSameDay,
          hashCode: (DateTime key) => key.day * 1000000 + key.month * 10000 + key.year,
        )..addAll(snapshot.data!);

        return TableCalendar<Event>(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          selectedDayPredicate: (day) => isSameDay(widget.selectedDate, day),
          onDaySelected: (selectedDay, focusedDay) {
            widget.onDaySelected(selectedDay, _getEventsForDay(selectedDay, events) as DateTime);
            setState(() {
              widget.selectedDate = selectedDay;
            });
          },
          eventLoader: (day) => _getEventsForDay(day, events),
          calendarFormat: CalendarFormat.week,
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
        );
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
      }
    );
  }
}
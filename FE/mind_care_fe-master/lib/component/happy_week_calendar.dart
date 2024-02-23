import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';
import 'package:mind_care/db.dart';

class WeekCalendar extends StatefulWidget {
  final OnDaySelected onDaySelected; // 날짜 선택 시 실행할 함수
  final DateTime selectedDate; // 선택된 날짜
  //DateTime showDate;

  WeekCalendar({
    super.key,
    required this.onDaySelected,
    required this.selectedDate,
    //required this.showDate,
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
    eventsFuture = DatabaseService.gethappyDiariesByDateForEvents();
  }

  List<Event> _getEventsForDay(
      DateTime day, Map<DateTime, List<Event>> events) {
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
            hashCode: (DateTime key) =>
                key.day * 1000000 + key.month * 10000 + key.year,
          )..addAll(snapshot.data!);

          return SingleChildScrollView(
            child: Container(
              width: 390,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: Color(0xfff8f9f9),
              ),
              child: TableCalendar<Event>(
                rowHeight: 48,
                daysOfWeekHeight: 17,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                selectedDayPredicate: (day) =>
                    isSameDay(widget.selectedDate, day),
                onDaySelected: (selectedDay, focusedDay) {
                  widget.onDaySelected(selectedDay,
                      _getEventsForDay(selectedDay, events) as DateTime);
                  setState(() {
                    //widget.showDate = selectedDay;
                  });
                },
                eventLoader: (day) => _getEventsForDay(day, events),
                calendarFormat: CalendarFormat.week,
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  cellAlignment: Alignment.center,
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
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  weekendTextStyle: const TextStyle(
                    // 주말 날짜 글꼴
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  selectedTextStyle: const TextStyle(
                    // 선택한 날짜 글꼴
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                calendarBuilders:
                    CalendarBuilders(defaultBuilder: (context, day, events) {
                  return Container(
                    width: 48,
                    height: 44,
                    //margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      // 기본 평일 날짜 스타일
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffEAEAF0),
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}', // 날짜를 텍스트로 표시
                        style: const TextStyle(
                          // 기본 평일 글꼴
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }, selectedBuilder: (context, day, events) {
                  return Container(
                    width: 48,
                    height: 44,
                    //margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      // 기본 평일 날짜 스타일
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xff007AFF),
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}', // 날짜를 텍스트로 표시
                        style: const TextStyle(
                          // 기본 평일 글꼴
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }, dowBuilder: (context, day) {
                  late String dayStr;
                  switch (day.weekday) {
                    case 1:
                      dayStr = 'Mon';
                      break;
                    case 2:
                      dayStr = 'Tue';
                      break;
                    case 3:
                      dayStr = 'Wed';
                      break;
                    case 4:
                      dayStr = 'Thu';
                      break;
                    case 5:
                      dayStr = 'Fri';
                      break;
                    case 6:
                      dayStr = 'Sat';
                      break;
                    case 7:
                      dayStr = 'Sun';
                      break;
                  }
                  return Container(
                    width: 43,
                    height: 17,
                    child: Text(dayStr.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        )),
                  );
                }, markerBuilder: (context, date, dynamic event) {
                  if (event.isNotEmpty) {
                    return Container(
                      width: 48,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}', // 날짜를 텍스트로 표시
                          style: const TextStyle(
                            // 기본 평일 글꼴
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                  return null;
                }),
                headerStyle: const HeaderStyle(
                  // 달력 최상단 스타일
                  titleCentered: true,
                  formatButtonVisible: false,
                  rightChevronVisible: false,
                  leftChevronVisible: false,
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ),
          );
        });
  }
}

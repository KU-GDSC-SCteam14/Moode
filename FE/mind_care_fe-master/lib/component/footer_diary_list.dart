import 'package:flutter/material.dart';
import 'package:mind_care/component/body_calendar.dart';
import 'package:mind_care/page/diary_from_list.dart';
import 'package:intl/intl.dart';
import 'package:mind_care/text_diary_card.dart';

// 날짜 기준 조회
// String date = "2023-01-01"; // 조회하고자 하는 날짜
// List<int> diaryIds = await DatabaseService.getDiariesByDate(date);

// ignore: must_be_immutable
class SelectedDiaryList extends StatelessWidget {
  final DateTime selectedDate;

  SelectedDiaryList({
    required this.selectedDate,
    super.key,
  });
  String date = selectedDate.toString();

  @override
  Widget build(BuildContext context) {
    String weekday =
        DateFormat('E').format(selectedDate).toString().toUpperCase();

    return Container(
        decoration: BoxDecoration(
          color: const Color(0xffd6dadc),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Container(
                // 날짜
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 0, horizontal: 32),
                    //   child: Text(
                    //     '$weekday ${selectedDate.day}, ${selectedDate.month} ${selectedDate.year}',
                    //     style: const TextStyle(
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 20,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 const ShowDiaryfromList()));
                    //   },
                    //   child: DiaryCard,
                    // ),
                    // Container(
                    //   height: 8,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 const ShowDiaryfromList()));
                    //   },
                    //   child: DiaryCard,
                    // ),
                    // Container(
                    //   height: 8,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 const ShowDiaryfromList()));
                    //   },
                    //   child: DiaryCard,
                    // ),
                  ],
                )),
          ],
        ));
  }
}

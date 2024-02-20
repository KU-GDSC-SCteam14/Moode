import 'package:flutter/material.dart';
import 'package:mind_care/db.dart';
import 'package:intl/intl.dart';
//import 'package:mind_care/screen/home_screen.dart';
import 'package:mind_care/card/simple_diary_card.dart';
import 'package:mind_care/card/contents_card.dart';

// selectedDate 기준으로 moodName이 긍정인 일기들의 DiaryIds 리스트 필요

// 그리고 이 리스트 순회하면서 DiaryId를 기준으로 content1, content2, content3, content4 불러와주세요!!!!!

class ShowDiaryfromList extends StatefulWidget {
  final DateTime selectedDate;

  const ShowDiaryfromList({required this.selectedDate, super.key});

  @override
  State<ShowDiaryfromList> createState() => _ShowDiaryfromList();
}

class _ShowDiaryfromList extends State<ShowDiaryfromList> {
  List<int> diaryIds = [];

  @override
  void initState() {
    super.initState();
    _loadDiaries();
  }

  Future<void> _loadDiaries() async {
    String dateString = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
    List<int> diaryIds =
        await DatabaseService.getDiariesByDateAndMood(dateString);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            // 감정일기 페이지 요소
            children: [
              ListView.builder(
                shrinkWrap: true, // 추가된 부분: ListView가 부모 위젯의 크기에 맞게 조절
                physics:
                    const NeverScrollableScrollPhysics(), // 추가된 부분: 스크롤을 방지
                itemCount: diaryIds.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      DiaryCard(diaryID: diaryIds[index]),
                      ContentsCard(diaryID: diaryIds[index]),
                    ],
                  );
                },
              )
            ]),
      ],
    );
  }
}

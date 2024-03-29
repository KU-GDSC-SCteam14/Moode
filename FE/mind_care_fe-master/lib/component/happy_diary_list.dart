import 'package:flutter/material.dart';
import 'package:mind_care/db.dart';
// import 'package:intl/intl.dart';
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
  int happy_count = 0;

  @override
  void initState() {
    super.initState();
    _loadDiaries();
  }

  Future<void> _loadDiaries() async {
    //String dateString = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
    diaryIds = await DatabaseService.getDiariesByDateAndMood(
        widget.selectedDate.toString());
    happy_count = diaryIds.length;
    setState(() {});
  }

  @override
    void didUpdateWidget(covariant ShowDiaryfromList oldWidget) {
      super.didUpdateWidget(oldWidget);
      // selectedDate가 변경되었는지 확인
      if (widget.selectedDate != oldWidget.selectedDate) {
        // selectedDate가 변경된 경우, 다시 데이터를 로드합니다.
        diaryIds.clear();
        _loadDiaries();
      }
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            // 감정일기 페이지 요소
            children: [
              const SizedBox(
                height: 8,
              ),
              // 일기 동그라미 개수
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < happy_count; i++)
                    const SizedBox(
                      height: 6,
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: Color(0xff535354),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              ListView.builder(
                shrinkWrap: true, // 추가된 부분: ListView가 부모 위젯의 크기에 맞게 조절
                physics:
                    const NeverScrollableScrollPhysics(), // 추가된 부분: 스크롤을 방지
                itemCount: diaryIds.length,
                itemBuilder: (context, index) {
                  if (diaryIds.isEmpty) {
                    return const Text('no happy diary!');
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DiaryCard(diaryID: diaryIds[index]),
                        const SizedBox(
                          height: 8,
                        ),
                        ContentsCard(diaryID: diaryIds[index]),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    );
                  }
                },
              )
            ]),
      ],
    );
  }
}

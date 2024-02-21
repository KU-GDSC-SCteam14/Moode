import 'package:flutter/material.dart';
import 'package:mind_care/db.dart';
import 'dart:math';

// 감정일기 카드에 diary id 필요함, 이거를 diary from search에 넘겨줘야 함.
// p.467 참고
// diary_from_list, diary_from_search, happy_week_diary, search_keyword_page2
class DiaryCard extends StatefulWidget {
  final int diaryID;
  const DiaryCard({super.key, required this.diaryID});

  @override
  State<DiaryCard> createState() => _DiaryCardState();
}

class _DiaryCardState extends State<DiaryCard> {
  String titleController = "";
  String Date = "";
  String moodName = "";
  List<String> keywords = [];

  @override
  void initState() {
    super.initState();
    _fetchDiaryDetails();
  }

  Future<void> _fetchDiaryDetails() async {
    final diaryDetails =
        await DatabaseService.getDiaryDetailsById(widget.diaryID);
    if (diaryDetails != null) {
      setState(() {
        titleController = diaryDetails['Title'];
        Date = diaryDetails['Date'];
        moodName = diaryDetails['Mood_name'] ?? 'Soso';
        keywords = diaryDetails['Keywords']?.split(',') ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374,
      //height: 151,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xfff0f1f1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 위 : 글(제목, 날짜), 감정 이모티콘
          DiaryTop(
              titleController: titleController, date: Date, moodName: moodName),
          // 여백
          const SizedBox(
            height: 18,
          ),
          // 아래 : 키워드들 좌우로 스크롤할 수 있게
          DiaryBottom(keywords: keywords)
        ],
      ),
    );
  }
}

class DiaryBottom extends StatelessWidget {
  // 키워드
  final List<String> keywords;

  const DiaryBottom({
    required this.keywords,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < min(keywords.length, 3); i++) Text(keywords[i])
      ],
      // child: Row(
      //   children: [
      //     Container(
      //         child: Row(
      //               children: [
      //                 ListView.builder(
      //                   itemCount: keywords.length,
      //                   itemBuilder: (context, index) {
      //                     return Container(
      //                       // 로컬 keywords 쓰기
      //                       decoration: BoxDecoration(
      //                         borderRadius:
      //                         BorderRadius.circular(100),
      //                         color: const Color.fromRGBO(
      //                             211, 212, 212, 1.0),
      //                       ),
      //                       child: Text(
      //                         keywords[index],
      //                         style: const TextStyle(
      //                           fontSize: 14,
      //                           color: Color.fromRGBO(
      //                               0, 122, 255, 1.0),
      //                         ),
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               ],
      //             )
    );
  }
}

class DiaryTop extends StatelessWidget {
  // 제목
  final String titleController;
  // 날짜
  final String date;
  // 이모티콘
  final String moodName;

  const DiaryTop({
    required this.titleController,
    required this.date,
    // 이모티콘
    required this.moodName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 334,
        height: 64,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // 글(제목, 날짜)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              SizedBox(
                width: 250,
                height: 26,
                child: Text(titleController),
              ),
              // 여백
              const SizedBox(
                height: 14,
              ),
              // 날짜
              Container(
                  child: Text(
                date,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff86858A),
                ),
              )),
            ],
          ),
          // 감정 이모티콘
          Container(
            width: 64,
            height: 64,
            child: getImageWidget(moodName),
          )
        ]));
  }

  Widget getImageWidget(String moodName) {
    switch (moodName) {
      case 'very happy':
        return Image.asset('asset/img/very_happy.png');
      case 'happy':
        return Image.asset('asset/img/happy.png');
      case 'sad':
        return Image.asset('asset/img/sad.png');
      case 'very sad':
        return Image.asset('asset/img/very_sad.png');
      default:
        return Container(); // 예외 처리 혹은 기본값 설정
    }
  }
}

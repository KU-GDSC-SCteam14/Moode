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
      width: 410,
      height: 151,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(255, 255, 255, 0.5),
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
    return Container(
      height: 29,
      //width: 334,
      child: Row(
        children: [
          for (int i = 0; i < min(keywords.length, 3); i++)
            Container(
              height: 29,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                    height: 29,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromRGBO(225, 226, 226, 0.8),
                    ),
                    child: Text(
                      keywords[i],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff007AFF),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                    height: 29,
                  ),
                ],
              ),
            ),
        ],
      ),
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
        //width: 334,
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
                child: Text(
                  titleController,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff535354),
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  maxLines: 1,
                ),
              ),
              // 여백
              const SizedBox(
                height: 14,
              ),
              // 날짜
              Container(
                  child: Text(
                getDateWidget(date) +
                    ' ' +
                    date.substring(8, 10) +
                    ', ' +
                    date.substring(0, 4),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
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

  String getDateWidget(String date) {
    String month;
    switch (date.substring(5, 7)) {
      case '01':
        month = 'Jan';
        return month;
      case '02':
        month = 'Feb';
        return month;
      case '03':
        month = 'Mar';
        return month;
      case '04':
        month = 'Apr';
        return month;
      case '05':
        month = 'May';
        return month;
      case '06':
        month = 'Jun';
        return month;
      case '07':
        month = 'Jul';
        return month;
      case '08':
        month = 'Aug';
        return month;
      case '09':
        month = 'Sep';
        return month;
      case '10':
        month = 'Oct';
        return month;
      case '11':
        month = 'Nov';
        return month;
      case '12':
        month = 'Dec';
        return month;
// 예외 처리 혹은 기본값 설정
      default:
        return 'Jan';
    }
  }
}

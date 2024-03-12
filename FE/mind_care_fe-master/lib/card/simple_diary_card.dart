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
    Date = "2000-01-01";
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(255, 255, 255, 0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: keywords
          .map((keyword) => Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromRGBO(225, 226, 226, 0.8),
                ),
                child: Text(
                  keyword.length > 30
                      ? '${keyword.substring(0, 30)}...'
                      : keyword,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff007AFF),
                  ),
                ),
              ))
          .toList(),
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
    final formattedDate =
        "${getDateWidget(date)} ${date.substring(8, 10)}, ${date.substring(0, 4)}";

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      // 글(제목, 날짜)
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // 제목
        RichText(
          text: TextSpan(
            text: titleController,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff535354),
            ),
          ),
        ),
        // 여백
        const SizedBox(
          height: 14,
        ),
        // 날짜
        Container(
            child: Text(
          formattedDate,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xff86858A),
          ),
        )),
      ])),
      const SizedBox(width: 10),
      // 감정 이모티콘
      Container(
        width: 64,
        height: 64,
        child: getImageWidget(moodName),
      )
    ]);
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
        break;
      case '02':
        month = 'Feb';
        break;
      case '03':
        month = 'Mar';
        break;
      case '04':
        month = 'Apr';
        break;
      case '05':
        month = 'May';
        break;
      case '06':
        month = 'Jun';
        break;
      case '07':
        month = 'Jul';
        break;
      case '08':
        month = 'Aug';
        break;
      case '09':
        month = 'Sep';
        break;
      case '10':
        month = 'Oct';
        break;
      case '11':
        month = 'Nov';
        break;
      case '12':
        month = 'Dec';
        break;
// 예외 처리 혹은 기본값 설정
      default:
        month = 'Jan';
    }
    return month;
  }
}

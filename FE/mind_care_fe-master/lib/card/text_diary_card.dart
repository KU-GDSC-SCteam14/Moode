import 'package:flutter/material.dart';
import 'package:mind_care/db.dart';
import 'dart:math';

// 감정일기 카드에 diary id 필요함, 이거를 diary from search에 넘겨줘야 함.
// p.467 참고
// footer_diary_list

class DiaryCard extends StatelessWidget {
  final int diaryID;

//***************diaryID 기준으로 title, content1, Date, keywords, moodName 조회해야 합니다!!!
// ****************  꼭 'widget.find_keyword' 이 형식으로 불러와주세요. 그래야 불려요.

  const DiaryCard({
    required this.diaryID,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // FutureBuilder를 사용하여 비동기적으로 데이터를 불러온 후 위젯을 구성
    return FutureBuilder<Map<String, dynamic>?>(
      future: DatabaseService.getDiaryDetailsById(diaryID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터 로딩 중인 경우
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // 데이터 로딩에 실패한 경우
          return const Center(child: Text("Error loading diary details"));
        } else if (snapshot.hasData) {
          // 데이터 로딩에 성공한 경우, 상세 정보를 표시
          final diaryDetails = snapshot.data!;
          // 일기의 제목, 내용, 날짜, 키워드, 기분 이름을 추출
          final titleController = diaryDetails['Title'];
          final experienceTextController = diaryDetails['Content_1'];
          //final Date = diaryDetails['Date'];
          final keywords = diaryDetails['Keywords']?.split(',') ?? [];
          final moodName = diaryDetails['Mood_name'] ?? 'Soso';

          return Container(
            width: 374,
            height: 169,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromRGBO(225, 226, 226, 0.8),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DiaryTop(
                  titleController: titleController,
                  experienceTextController: experienceTextController,
                  moodName: moodName,
                ),
                const SizedBox(
                  // 여백
                  height: 18,
                ),
                DiaryBottom(
                  //ate: Date,
                  keywords: keywords,
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text("No diary details available"));
        }
      },
    );
  }
}

class DiaryBottom extends StatelessWidget {
  // 날짜
  //final String Date;
  final List<String> keywords;

  const DiaryBottom({
    //required this.Date,
    required this.keywords,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 29,
      width: 334,
      child: Row(
        children: [
          for (int i = 0; i < min(keywords.length, 3); i++)
            Container(
              height: 29,
              child: Row(
                children: [
                  Container(
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
  final String titleController;
  final String experienceTextController;
  // 이모티콘
  final String moodName;

  const DiaryTop({
    required this.titleController,
    required this.experienceTextController,
    // 이모티콘
    required this.moodName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 334,
        height: 82,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 글(제목, 날짜)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목
                SizedBox(
                    width: 273,
                    height: 20,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      maxLines: 2,
                      titleController,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff535354),
                      ),
                    )),
                // 여백
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: 273,
                  child: Text(
                    experienceTextController,
                    style: const TextStyle(
                      color: Color(0xff888888),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    maxLines: 2,
                  ),
                ),
              ],
            ),

            Container(
              alignment: Alignment.topRight,
              width: 34,
              height: 34,
              child: getImageWidget(moodName),
            )
          ],
        ));
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

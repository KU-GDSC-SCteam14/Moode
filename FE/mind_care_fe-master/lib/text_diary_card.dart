import 'package:flutter/material.dart';
import 'package:mind_care/db.dart';

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
          final Date = diaryDetails['Date'];
          final keywords = diaryDetails['Keywords']?.split(',') ?? [];
          final moodName = diaryDetails['Mood_name'] ?? 'Soso';

    return Container(
      width: 374,
      //height: 169,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xfff8f8f8),
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
            Date: Date,
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
  final String Date;
  final List<String> keywords;

  const DiaryBottom({
    required this.Date,
    required this.keywords,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(keywords[0]),
        // child: Row(
        //   children: [
        //     Container(
        //         child: Row(
        //               children: [
        //                 ListView.builder(
        //                   itemCount: keywords.length,
        //                   itemBuilder: (context, index) {
        //                     return Container(
        // padding: const EdgeInsets.symmetric(
        //   vertical: 6, horizontal: 19),
        // decoration: BoxDecoration(
        // color: const Color.fromRGBO(211, 212, 212, 1.0),

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
        const SizedBox(
          width: 35,
        ),
        Container(
            child: Text(
          Date,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xff86858A),
          ),
        )),
      ],
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
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(83, 83, 84, 1.0),
                      ),
                    )),
                // 여백
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    experienceTextController,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    maxLines: 2,
                  ),
                ),
              ],
            ),

            // 감정 이모티콘
            // Container(
            //   child: Image.asset(
            //     'asset/img/logo.png',
            //     width: 50,
            //   ),
            // ),
            // 감정 이름
            Container(
                child: Text(moodName,
                    style: const TextStyle(
                      fontSize: 18,
                    ))),
          ],
        ));
  }
}

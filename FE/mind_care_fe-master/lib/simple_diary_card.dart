import 'package:flutter/material.dart';

// p.467 참고
// diary_from_list, diary_from_search, happy_week_diary, search_keyword_page2

class DiaryCard extends StatelessWidget {
  final String titleController;
  final String Date;
  final List<String> keywords;
  final String moodName;

  const DiaryCard({
    required this.titleController,
    required this.Date,
    required this.keywords,
    // 이모티콘
    required this.moodName,
    Key? key,
  }) : super(key: key);

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
          SizedBox(
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(keywords[0])
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Container(
                  width: 250,
                  height: 26,
                  child: Text(titleController),
                ),
                // 여백
                SizedBox(
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
            // Container(
            //   child: Image.asset(
            //     'asset/img/logo.png',
            //     width: 50,
            //   ),
            // ),
            // 감정 이름
            Container(
                child: Text(moodName,
                    style: TextStyle(
                      fontSize: 18,
                    ))),
          ],
        ));
  }
}

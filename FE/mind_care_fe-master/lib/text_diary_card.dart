import 'package:flutter/material.dart';
// 감정일기 카드에 diary id 필요함, 이거를 diary from search에 넘겨줘야 함.
// p.467 참고
// footer_diary_list

class DiaryCard extends StatelessWidget {
  final int diaryID;

//***************diaryID 기준으로 title, content1, Date, keywords, moodName 조회해야 합니다!!!

  const DiaryCard({
    required this.diaryID,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
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
  }
}

class DiaryBottom extends StatelessWidget {
  // 날짜
  final String Date;
  final List<String> keywords;

  const DiaryBottom({
    required this.Date,
    required this.keywords,
    Key? key,
  }) : super(key: key);

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
        SizedBox(
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
                    child: Text(
                      titleController,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(83, 83, 84, 1.0),
                      ),
                    )),
                // 여백
                SizedBox(
                  height: 14,
                ),
                Container(
                  width: 250,
                  child: Text(
                    experienceTextController,
                    style: TextStyle(
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
                    style: TextStyle(
                      fontSize: 18,
                    ))),
          ],
        ));
  }
}

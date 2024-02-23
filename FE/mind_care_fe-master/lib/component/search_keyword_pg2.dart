import 'package:flutter/material.dart';
import 'package:mind_care/page/show_diary.dart';
import 'package:mind_care/card/simple_diary_card.dart';
import 'package:mind_care/db.dart';
import 'package:mind_care/component/search_keyword_pg1.dart';

class ResultKeyword extends StatefulWidget {
  final String find_keyword;

  const ResultKeyword({super.key, required this.find_keyword});

  @override
  _ResultKeyword createState() => _ResultKeyword();
}

// 메인 클래스의 상태 상속
class _ResultKeyword extends State<ResultKeyword> {
  // ****************!!!! widget.find_keyword (찾으려는 키워드) 기준으로 diaryids 리스트 불러와주세요!!!!
  // ****************  꼭 'widget.find_keyword' 이 형식으로 불러와주세요. 그래야 불려요.

  late Future<List<int>> diaryIds;

  @override
  void initState() {
    super.initState();
    diaryIds = DatabaseService.getDiaryIdsByKeyword(widget.find_keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42.0),
        child: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back), // 아이콘
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchKeyword()),
                );
              }),
          title: const Text(
            '검색 결과',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              child: Text(
                '\'${widget.find_keyword}\'이 포함된 감정일기',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 32,
            ),
            // ListView.builder(
            //   itemCount: diaryIDs.length,
            //   itemBuilder: (context, index) {
            //     return GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     ShowDiary(diaryID: diaryIDs[index])));
            //       },
            //       child: DiaryCard(
            //         diaryID: diaryIDs[index],
            //       ),
            //     );
            //   },
            // )
            FutureBuilder<List<int>>(
              future: diaryIds,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<int> diaryIDs = snapshot.data!;
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffd6dadc),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap:
                                    true, // 추가된 부분: ListView가 부모 위젯의 크기에 맞게 조절
                                physics:
                                    const NeverScrollableScrollPhysics(), // 추가된 부분: 스크롤을 방지
                                itemCount: diaryIDs.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ShowDiary(
                                                  diaryID: diaryIDs[index])));
                                    },
                                    child: DiaryCard(diaryID: diaryIDs[index]),
                                  );
                                },
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text('No data available');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

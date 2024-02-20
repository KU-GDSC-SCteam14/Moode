import 'package:flutter/material.dart';
import 'package:mind_care/page/diary_from_search.dart';
import 'package:mind_care/simple_diary_card.dart';
import 'package:mind_care/db.dart';

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

  List<int> diaryIDs = [];

  @override
  void initState() {
    super.initState();
    _loadDiaryIds();
  }

  Future<void> _loadDiaryIds() async {
    List<int> loadedDiaryIds = await DatabaseService.getDiaryIdsByKeyword(widget.find_keyword);
    setState(() {
      diaryIDs = loadedDiaryIds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42.0),
        child: AppBar(
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
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              ListView.builder(
                itemCount: diaryIDs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowDiaryfromSearch(
                                  diaryID: diaryIDs[index])));
                    },
                    child: DiaryCard(
                      diaryID: diaryIDs[index],
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

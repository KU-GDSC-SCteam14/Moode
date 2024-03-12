import 'package:flutter/material.dart';
//import 'package:mind_care/page/show_selectedfromsearch_diary.dart';
import 'package:mind_care/page/manage_keyword.dart';
import 'package:mind_care/screen/home_screen.dart';
import 'package:mind_care/component/search_keyword_pg2.dart';
import 'package:mind_care/db.dart';
//import 'package:mind_care/component/show_diary.dart';

String searchText = '';

// *******keywords 리스트 불러와주세요 ****************
List<String> keywords = [];

class SearchKeyword extends StatefulWidget {
  const SearchKeyword({super.key});

  @override
  _SearchKeyword createState() => _SearchKeyword();
}

// 메인 클래스의 상태 상속
class _SearchKeyword extends State<SearchKeyword> {
  @override
  void initState() {
    super.initState();
    _loadAllKeywords();
  }

  Future<void> _loadAllKeywords() async {
    List<String> loadedKeywords = await DatabaseService.getAllKeywords();
    setState(() {
      keywords = loadedKeywords;
    });
  }

  // 키워드 누르면
  void cardClickEvent(BuildContext context, String keyword) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // 정의한 ContentPage의 폼 호출
        builder: (context) => ResultKeyword(
          // keyword 넘겨주기
          find_keyword: keyword,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42.0),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back), // 아이콘
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }),
          title: const Text(
            '검색',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ManageKeyword()),
                  );
                }, // floating
                child: const Text('관리'))
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 29,
          ),

          // Expanded(
          //     child: SingleChildScrollView(
          //         child: Column(children: [

          Container(
            height: 42,
            margin: const EdgeInsets.fromLTRB(16, 3, 16, 3),
            //padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
            child: TextField(
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromRGBO(60, 60, 67, 0.6),
                ),
                suffixIcon: const Icon(
                  Icons.mic,
                  color: Color.fromRGBO(60, 60, 67, 0.6),
                ),
                fillColor: const Color.fromRGBO(118, 118, 128, 0.12),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: '검색어를 입력해주세요.',
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Color(0xffA19FA1)),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Container(
            height: 29,
          ),
          // 키워드 리스트 보여주기
          Expanded(
            child: ListView.builder(
              // items 변수에 저장되어 있는 모든 값 출력
              itemCount: keywords.length,
              itemBuilder: (BuildContext context, int index) {
                // 검색 기능, 검색어가 있을 경우
                if (searchText.isNotEmpty &&
                    !keywords[index]
                        .toLowerCase()
                        .contains(searchText.toLowerCase())) {
                  return const SizedBox.shrink();
                }
                // 검색어가 없을 경우, 모든 항목 표시
                else {
                  return GestureDetector(
                    //alignment: Align.
                    onTap: () => cardClickEvent(context, keywords[index]),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 16,
                          height: 37,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 19),
                              height: 29,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color.fromRGBO(225, 226, 226, 0.8),
                              ),
                              child: Text(
                                keywords[index].length > 30
                                    ? keywords[index].substring(0, 30) + '...'
                                    : keywords[index],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff007AFF),
                                ),
                              ),
                            ),
                            const SizedBox(
                              //width: 16,
                              height: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
//import 'package:mind_care/page/show_selectedfromsearch_diary.dart';
import 'package:mind_care/page/manage_keyword.dart';
import 'package:mind_care/screen/home_screen.dart';
import 'package:mind_care/component/search_keyword_pg2.dart';
import 'package:mind_care/db.dart';
import 'package:mind_care/page/manage_keyword.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42.0),
        child: AppBar(
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
                    MaterialPageRoute(builder: (context) => ManageKeyword()),
                  );
                }, // floating
                child: const Text('관리'))
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          // Expanded(
          //     child: SingleChildScrollView(
          //         child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              style: const TextStyle(
                fontSize: 14,
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
                fillColor: const Color(0xffA19FA1),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: '검색어를 입력해주세요.',
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Container(
            height: 32,
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
                  return Card(
                    elevation: 3,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(20, 20))),
                    child: ListTile(
                      title: Text(keywords[index]),
                      onTap: () => cardClickEvent(context, keywords[index]),
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

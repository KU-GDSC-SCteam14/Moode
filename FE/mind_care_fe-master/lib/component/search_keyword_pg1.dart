import 'package:flutter/material.dart';
//import 'package:mind_care/page/show_selectedfromsearch_diary.dart';
import 'package:mind_care/page/collect_keyword.dart';
import 'package:mind_care/screen/home_screen.dart';
import 'package:mind_care/component/search_keyword_pg2.dart';

String searchText = '';

<<<<<<< HEAD
// ********************!!! keywords 리스트 받아와야 합니다 !!! *****************************
// 아래 keywords에 저장하는 함수 넣어주세요
List<String> keywords = [];

//

// 요 부분!

//
=======
// 검색을 위해 앱의 상태를 변경해야하므로 StatefulWidget 상속
// keyword 기준 조회 ->
// String date = "2023-01-01"; // 조회하고자 하는 날짜
// List<int> diaryIds = await DatabaseService.getDiariesByDate(date);

// 감정일기 카드에 diary id 필요함, 이거를 diary from search에 넘겨줘야 함.
>>>>>>> a7ca9d32287255e4cfc751478d96c86dfe1b9233

class SearchKeyword extends StatefulWidget {
  const SearchKeyword({super.key});

  @override
  _SearchKeyword createState() => _SearchKeyword();
}

// 메인 클래스의 상태 상속
class _SearchKeyword extends State<SearchKeyword> {
  // 키워드 누르면
  void cardClickEvent(BuildContext context, String keyword) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // 정의한 ContentPage의 폼 호출
        builder: (context) => ResultKeyword(
            // diary Id 넘겨주기

            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(42.0),
        child: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back), // 아이콘
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }),
          title: Text(
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
                    MaterialPageRoute(builder: (context) => CollectKeyword()),
                  );
                }, // floating
                child: Text('관리'))
          ],
=======
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
                      MaterialPageRoute(builder: (context) => CollectKeyword()),
                    );
                  }, // floating
                  child: const Text('관리'))
            ],
          ),
>>>>>>> a7ca9d32287255e4cfc751478d96c86dfe1b9233
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
<<<<<<< HEAD
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
                  return SizedBox.shrink();
                }
                // 검색어가 없을 경우, 모든 항목 표시
                else {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(20, 20))),
                    child: ListTile(
                      title: Text(keywords[index]),
                      onTap: () => cardClickEvent(context, keywords[index]),
                    ),
                  );
                }
              },
=======
          Container(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 최근 검색한 키워드
              children: [
                Container(
                  child: const Text(
                    '최근 검색한 키워드',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 16,
                ),

                // ListView.builder(
                //   itemCount: recentKeywords.length,
                //   itemBuilder: (context, index) {
                //     // 리스트의 각 항목을 가져와서 사용
                //     String currentItem = recentKeywords[index];
                //
                //     return ListTile(
                //       title: Container(
                //         // 텍스트를 컨테이너에 넣음
                //         child: Text(currentItem,
                //           style: TextStyle(
                //             fontSize: 14,
                //             color: Color(0xff007AFF),
                //           ),),
                //       ),
                //     );
                //   },
                // ),

                Container(
                  height: 32,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 가장 많이 작성된 키워드
                  children: [
                    Container(
                      child: const Text(
                        '가장 많이 작성된 키워드',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 16,
                    ),
                    // ListView.builder(
                    //   itemCount: multipleKeywords.length,
                    //   itemBuilder: (context, index) {
                    //     // 리스트의 각 항목을 가져와서 사용
                    //     String currentItem = multipleKeywords[index];
                    //
                    //     return ListTile(
                    //       title: Container(
                    //         // 텍스트를 컨테이너에 넣음
                    //         child: Text(currentItem,
                    //           style: TextStyle(
                    //             fontSize: 14,
                    //             color: Color(0xff007AFF),
                    //           ),),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ],
>>>>>>> a7ca9d32287255e4cfc751478d96c86dfe1b9233
            ),
          ),
        ],
      ),
    );
  }
}

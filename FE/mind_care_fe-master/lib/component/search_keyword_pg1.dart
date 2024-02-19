import 'package:flutter/material.dart';
//import 'package:mind_care/page/show_selectedfromsearch_diary.dart';
import 'package:mind_care/page/collect_keyword.dart';
import 'package:mind_care/screen/home_screen.dart';
import 'package:mind_care/page/diary_from_search.dart';

String searchText = '';

// 검색을 위해 앱의 상태를 변경해야하므로 StatefulWidget 상속
// keyword 기준 조회 ->
// 감정일기 카드에 diary id 필요함, 이거를 diary from search에 넘겨줘야 함.

class SearchKeyword extends StatefulWidget {
  const SearchKeyword({super.key});

  @override
  _SearchKeyword createState() => _SearchKeyword();
}

// 메인 클래스의 상태 상속
class _SearchKeyword extends State<SearchKeyword> {
  String searchText = '';

  // // 감정일기 카드 클릭 이벤트 핸들러
  // void cardClickEvent(BuildContext context){
  //       Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       // 정의한 ContentPage의 폼 호출
  //       builder: (context) => ShowDiaryfromSearch(),
  //     ),
  //   );

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
                      MaterialPageRoute(builder: (context) => CollectKeyword()),
                    );
                  }, // floating
                  child: const Text('관리'))
            ],
          ),
        ),
        body: Column(children: <Widget>[
          // Expanded(
          //     child: SingleChildScrollView(
          //         child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              // onChanged: (value) {
              //   setState(() {
              //     searchText = value;
              //   });
              // style: const TextStyle(
              //   fontSize: 14,
              // );
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
            ),
          )
        ]));
  }
}
//}

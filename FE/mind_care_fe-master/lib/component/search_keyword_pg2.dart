import 'package:flutter/material.dart';
import 'package:mind_care/page/diary_from_search.dart';
//import 'package:mind_care/component/search_keyword_pg1.dart';

// 키워드 기준 조회

class SearchKeyword extends StatefulWidget {
  const SearchKeyword({super.key});

  @override
  _SearchKeyword createState() => _SearchKeyword();
}

// 메인 클래스의 상태 상속
class _SearchKeyword extends State<SearchKeyword> {
  String searchText = '';
  // 리스트뷰 카드 클릭 이벤트 핸들러
  void cardClickEvent(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // 정의한 ContentPage의 폼 호출
        builder: (context) => ShowDiaryfromSearch(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42.0),
        child: AppBar(
          title: const Text(
            '검색',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: <Widget>[
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 최근 검색한 키워드
            children: [
              Container(
                child: const Text(
                  '\'디자인\'이 포함된 감정일기',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowDiaryfromSearch()));
                },
                child: Column(
                  // 감정일기 리스트 요소
                  children: [
                    Container(
                        width: 374,
                        height: 169,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xfff8f8f8),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                // 위
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    // 감정일기 제목
                                    child: const Text(
                                  '감정일기의 제목',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(83, 83, 84, 1.0),
                                  ),
                                )),
                                Container(
                                  // 여백
                                  height: 14,
                                ),
                                Container(
                                    // 본문 미리보기 두 줄
                                    child: const Text(
                                  '감정일기의 본문이 보이는 곳입니다. 사용자가 작성한 텍스트만 보여주어야 합니다. 최대 두 줄 까지..',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(136, 136, 136, 1.0),
                                  ),
                                )),
                                Container(// 감정 아이콘

                                    ),
                              ],
                            )),
                            Container(
                              // 여백
                              height: 18,
                            ),
                            Container(
                              // 아래
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      // 키워드
                                      child: Row(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 19),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                211, 212, 212, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: const Text(
                                            '키워드',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  0, 122, 255, 1.0),
                                            ),
                                          )),
                                      Container(
                                        width: 8,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 19),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                211, 212, 212, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: const Text(
                                            '키워드',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  0, 122, 255, 1.0),
                                            ),
                                          )),
                                      Container(
                                        width: 8,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 19),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                211, 212, 212, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: const Text(
                                            '키워드',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  0, 122, 255, 1.0),
                                            ),
                                          )),
                                    ],
                                  )),
                                  Container(
                                      // 작성 시간
                                      child: const Text(
                                    '09:00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(136, 136, 136, 1.0),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

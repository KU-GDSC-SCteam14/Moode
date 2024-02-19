import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mind_care/db.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<void> saveDiary() async {
//    final prefs = await SharedPreferences.getInstance();
//    final userid = prefs.getInt('userid'); // SharedPreferences에서 userid 불러오기

//   Future<List<Map<String, dynamic>>> Diary = await DatabaseService.getDiaries();

// }

// 날짜가 형식이 다 같아서 안되고, 제목 기준으로 조회

class ShowDiaryfromList extends StatelessWidget {
  const ShowDiaryfromList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42.0),
        child: AppBar(
          title: const Text(
            '작성하기',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                // 버튼이 클릭되었을 때 수행할 작업 추가
              },
              child: const Text(
                '수정',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                // 감정일기 제목 붙이기
                Column(
                  // 감정일기 페이지 요소
                  children: [
                    Container(
                        width: 374,
                        height: 169,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xfff3f3f4),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
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
                                    fontSize: 22,
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
                                  '9:00, Mar 16, 2024',
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
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: const Color.fromRGBO(
                                                211, 212, 212, 1.0),
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
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: const Color.fromRGBO(
                                                211, 212, 212, 1.0),
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
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: const Color.fromRGBO(
                                                211, 212, 212, 1.0),
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
                Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: const Color(0xfffbfbfb),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '오늘 어떤 일이 있었나요?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffABB0BC),
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        const Text(
                          '이번 주말에는 예전부터 계획해 온 산책과 휴식을 위해 해안가의 조용한 해수욕장으로 가족들과 함께 떠났어. 그런데 도착하자마자 예상치 못한 날씨 변화로 강한 바람과 비가 내려 해변에서의 휴식이 불가능해졌어.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        const Text(
                          '그때의 감정을 자세히 들려주세요.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffABB0BC),
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        const Text(
                          '해변에서의 산책과 함께하는 가족 휴식은 기대했던 대로 이뤄지지 않을 것 같았어. 그런데도 우리는 가족들과 함께 새로운 계획을 세우고, 예상치 못한 날씨 속에서도 즐거움을 찾아볼 수 있는 방법을 찾아야 했어. 주변에 있는 카페나 실내 활동을 찾아보며 새로운 경험을 쌓을 수 있을 것 같다는 생각이 들었어.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        const Text(
                          '왜 그런 감정이 든 것 같나요?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffABB0BC),
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        const Text(
                          '해변에서의 산책과 함께하는 가족 휴식은 기대했던 대로 이뤄지지 않을 것 같았어. 그런데도 우리는 가족들과 함께 새로운 계획을 세우고, 예상치 못한 날씨 속에서도 즐거움을 찾아볼 수 있는 방법을 찾아야 했어. 주변에 있는 카페나 실내 활동을 찾아보며 새로운 경험을 쌓을 수 있을 것 같다는 생각이 들었어.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

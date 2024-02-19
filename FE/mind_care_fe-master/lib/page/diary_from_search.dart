import 'package:flutter/material.dart';
import 'package:mind_care/simple_diary_card.dart';

class ShowDiaryfromSearch extends StatelessWidget {
  final int diaryID;

  ShowDiaryfromSearch({
    required this.diaryID,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //***********************diaryID 기준으로 content1, content2, content3, content4 불러와주세요!!!!!

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(42.0),
        child: AppBar(
          title: Text(
            '작성하기',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
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
                          color: Color(0xfff3f3f4),
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
                                    child: Text(
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
                                    child: Text(
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
                                            color: Color.fromRGBO(
                                                211, 212, 212, 1.0),
                                          ),
                                          child: Text(
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
                                            color: Color.fromRGBO(
                                                211, 212, 212, 1.0),
                                          ),
                                          child: Text(
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
                                            color: Color.fromRGBO(
                                                211, 212, 212, 1.0),
                                          ),
                                          child: Text(
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
                                      child: Text(
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
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color(0xfffbfbfb),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
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
                        Text(
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
                        Text(
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
                        Text(
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
                        Text(
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
                        Text(
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

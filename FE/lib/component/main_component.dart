import 'package:flutter/material.dart';

class MainComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Row(
        children: [
          // 감정일기 리스트 요소
          Column( // 감정일기 리스트 요소
            children: [
              Container(
                  width: 374,
                  height: 169,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xfff8f8f8),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container( // 위
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(// 감정일기 제목
                                  child: Text(
                                    '감정일기의 제목',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(83, 83, 84, 1.0),
                                    ),
                                  )
                              ),
                              Container( // 여백
                                height: 14,
                              ),
                              Container( // 본문 미리보기 두 줄
                                  child: Text(
                                    '감정일기의 본문이 보이는 곳입니다. 사용자가 작성한 텍스트만 보여주어야 합니다. 최대 두 줄 까지..',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(136, 136, 136, 1.0),
                                    ),
                                  )
                              ),
                              Container( // 감정 아이콘

                              ),
                            ],
                          )
                      ),
                      Container( // 여백
                        height: 18,
                      ),
                      Container( // 아래
                        child: Row(
                          children: [
                            Container( // 키워드
                                child: Row(
                                  children: [
                                    Container(
                                        color: Color.fromRGBO(211, 212, 212, 1.0),
                                        //decoration: BoxDecoration(
                                        //borderRadius: BorderRadius.circular(100),
                                        //),
                                        child: Text(
                                          '키워드',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(0, 122, 255, 1.0),
                                          ),
                                        )
                                    ),
                                    Container(
                                        color: Color.fromRGBO(211, 212, 212, 1.0),
                                        //decoration: BoxDecoration(
                                        //borderRadius: BorderRadius.circular(100),
                                        //),
                                        child: Text(
                                          '키워드',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(0, 122, 255, 1.0),
                                          ),
                                        )
                                    ),
                                    Container(
                                        color: Color.fromRGBO(211, 212, 212, 1.0),
                                        //decoration: BoxDecoration(
                                        //  borderRadius: BorderRadius.circular(100),
                                        //),
                                        child: Text(
                                          '키워드',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(0, 122, 255, 1.0),
                                          ),
                                        )
                                    ),
                                  ],
                                )
                            ),
                            Container( // 작성 시간
                                child: Text(
                                  '09:00',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(136, 136, 136, 1.0),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),

          // 감정일기 페이지 요소
          Column( // 감정일기 페이지 요소
            children: [
              Container(
                  width: 374,
                  height: 169,
                  color: Color.fromRGBO(136, 136, 136, 1.0),
                  //decoration: BoxDecoration(
                  //  borderRadius: BorderRadius.circular(20),
                  //),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container( // 위
                          child:Column(
                            children: [
                              Container( // 감정일기 제목
                                  child: Text(
                                    '감정일기의 제목',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(83, 83, 84, 1.0),
                                    ),
                                  )
                              ),
                              Container( // 여백
                                height: 14,
                              ),
                              Container( // 본문 미리보기 두 줄
                                  child: Text(
                                    '9:00, Mar 16, 2024',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(136, 136, 136, 1.0),
                                    ),
                                  )
                              ),
                              Container( // 감정 아이콘

                              ),
                            ],
                          )
                      ),
                      Container( // 아래
                        child: Row(
                          children: [
                            Container( // 키워드
                                child: Row(
                                  children: [
                                    Container(
                                        color: Color.fromRGBO(211, 212, 212, 1.0),
                                        //decoration: BoxDecoration(
                                        //borderRadius: BorderRadius.circular(100),
                                        //),
                                        child: Text(
                                          '키워드',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(0, 122, 255, 1.0),
                                          ),
                                        )
                                    ),
                                    Container(
                                        color: Color.fromRGBO(211, 212, 212, 1.0),
                                        //decoration: BoxDecoration(
                                        //borderRadius: BorderRadius.circular(100),
                                        //),
                                        child: Text(
                                          '키워드',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(0, 122, 255, 1.0),
                                          ),
                                        )
                                    ),
                                    Container(
                                        color: Color.fromRGBO(211, 212, 212, 1.0),
                                        //decoration: BoxDecoration(
                                        //  borderRadius: BorderRadius.circular(100),
                                        //),
                                        child: Text(
                                          '키워드',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(0, 122, 255, 1.0),
                                          ),
                                        )
                                    ),
                                  ],
                                )
                            ),
                            Container( // 작성 시간
                                child: Text(
                                  '09:00',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(136, 136, 136, 1.0),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),

          // 감정일기 작성완료 요소
          Column( // 감정일기 작성완료 요소
            children: [
              Container(
                width: 374,
                height: 169,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xfff0f1f1),
                ),
                  padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container( // 위
                          child:Column(
                            children: [
                              Container( // 감정일기 제목
                                child: Text(
                                  '첫 번째 감정일기',
                                  style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(216, 214, 213, 1.0),
                              ),
                          )
                        ),
                                  Container( // 여백
                                  height: 14,
                                  ),
                                  Container(
                                  child: Text(
                                  '9:00, Mar 16, 2024',
                                  style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff86858A),
                                  ),
                                  )
                                  ),
                                  Container( // 감정 아이콘

                                  ),
              ],
            )
            ),
            Container( // 아래
            child: Row(
            children: [
            Container( // 키워드
            child: Row(
            children: [
            Container(
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
                color: Color.fromRGBO(211, 212, 212, 1.0),
            ),
            child: Text(
            '키워드',
            style: TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(0, 122, 255, 1.0),
            ),
            )
            ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromRGBO(211, 212, 212, 1.0),
                  ),
            child: Text(
            '키워드',
            style: TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(0, 122, 255, 1.0),
            ),
            )
            ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromRGBO(211, 212, 212, 1.0),
                  ),
            child: Text(
            '키워드',
            style: TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(0, 122, 255, 1.0),
            ),
            )
            ),
            ],
            )
            ),
            ],
            ),
            ),
            ],
            )
          )
        ],
      ),
    ],
    ),
    );
  }
}
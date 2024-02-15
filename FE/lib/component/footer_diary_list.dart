import 'package:flutter/material.dart';
import 'package:mind_care/page/show_selectedfromlist_diary.dart';

class SelectedDiaryList extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
                  decoration: BoxDecoration(
                    color: Color(0xffd6dadc),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children:
                    [Container(// 날짜
                      padding: EdgeInsets.only(top: 16),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 32),
                              child: Text(
                                'THURSDAY Mar 16, 2024',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder:
                                  (context) => ShowDiaryfromList())
                                );
                              },
                              child: Column( // 감정일기 리스트 요소
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
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container( // 키워드
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                                                            decoration: BoxDecoration(
                                                              color: Color.fromRGBO(211, 212, 212, 1.0),
                                                            borderRadius: BorderRadius.circular(100),
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
                                                          width: 8,
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                                                            decoration: BoxDecoration(
                                                              color: Color.fromRGBO(211, 212, 212, 1.0),
                                                              borderRadius: BorderRadius.circular(100),
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
                                                          width: 8,
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                                                            decoration: BoxDecoration(
                                                              color: Color.fromRGBO(211, 212, 212, 1.0),
                                                              borderRadius: BorderRadius.circular(100),
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
                            ),
                            Container(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder:
                                        (context) => ShowDiaryfromList())
                                );
                              },
                              child: Column( // 감정일기 리스트 요소
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
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container( // 키워드
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                                                            decoration: BoxDecoration(
                                                              color: Color.fromRGBO(211, 212, 212, 1.0),
                                                              borderRadius: BorderRadius.circular(100),
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
                                                          width: 8,
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                                                            decoration: BoxDecoration(
                                                              color: Color.fromRGBO(211, 212, 212, 1.0),
                                                              borderRadius: BorderRadius.circular(100),
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
                                                          width: 8,
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                                                            decoration: BoxDecoration(
                                                              color: Color.fromRGBO(211, 212, 212, 1.0),
                                                              borderRadius: BorderRadius.circular(100),
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
                            ),
                            Container(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder:
                                        (context) => ShowDiaryfromList())
                                );
                              },
                              child: Column( // 감정일기 리스트 요소
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
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container( // 키워드
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                                                            decoration: BoxDecoration(
                                                              color: Color.fromRGBO(211, 212, 212, 1.0),
                                                              borderRadius: BorderRadius.circular(100),
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
                                                          width: 8,
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                                                            decoration: BoxDecoration(
                                                              color: Color.fromRGBO(211, 212, 212, 1.0),
                                                              borderRadius: BorderRadius.circular(100),
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
                                                          width: 8,
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                                                            decoration: BoxDecoration(
                                                              color: Color.fromRGBO(211, 212, 212, 1.0),
                                                              borderRadius: BorderRadius.circular(100),
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
                            ),
                          ],
                        )
                    ),

                    ],
                  )
    );
  }
}

import 'package:mind_care/screen/home_screen.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget{
  final thinkTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            42.0),
        child: AppBar(
          title: Text('작성완료',
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
          Expanded(child: SingleChildScrollView(
              child: Column(children: [
                LinearProgressIndicator(
                  value: 1.0,
                  backgroundColor: Colors.white,
                  color: Colors.white,
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromRGBO(0, 122, 255, 1.0)),
                  minHeight: 2.0,
                  semanticsLabel: 'semanticsLabel',
                  semanticsValue: 'semanticsValue',
                ),
                Container(
                  //decoration: BoxDecoration(
                  //  borderRadius: BorderRadius.circular(20),
                  //),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: Text('일기가 완성되었어요!\n작성한 일기에 제목을 붙여주세요.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container( // 위
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      Text('오늘 어떤 일이 있었나요?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffABB0BC),
                        ),
                      ),
                      Container(height: 20,),
                      Text('이번 주말에는 예전부터 계획해 온 산책과 휴식을 위해 해안가의 조용한 해수욕장으로 가족들과 함께 떠났어. 그런데 도착하자마자 예상치 못한 날씨 변화로 강한 바람과 비가 내려 해변에서의 휴식이 불가능해졌어.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(height: 20,),
                      Text('그때의 감정을 자세히 들려주세요.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffABB0BC),
                        ),
                      ),
                      Container(height: 20,),
                      Text('해변에서의 산책과 함께하는 가족 휴식은 기대했던 대로 이뤄지지 않을 것 같았어. 그런데도 우리는 가족들과 함께 새로운 계획을 세우고, 예상치 못한 날씨 속에서도 즐거움을 찾아볼 수 있는 방법을 찾아야 했어. 주변에 있는 카페나 실내 활동을 찾아보며 새로운 경험을 쌓을 수 있을 것 같다는 생각이 들었어.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(height: 20,),
                      Text('왜 그런 감정이 든 것 같나요?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffABB0BC),
                        ),
                      ),
                      Container(height: 20,),
                      Text('해변에서의 산책과 함께하는 가족 휴식은 기대했던 대로 이뤄지지 않을 것 같았어. 그런데도 우리는 가족들과 함께 새로운 계획을 세우고, 예상치 못한 날씨 속에서도 즐거움을 찾아볼 수 있는 방법을 찾아야 했어. 주변에 있는 카페나 실내 활동을 찾아보며 새로운 경험을 쌓을 수 있을 것 같다는 생각이 들었어.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )

                ),
              ],)
          ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 358,
                height: 57,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 122, 255, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  child: const Text(
                    '메인 화면으로',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen()),
                    );
                  }, // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                ),
              )
          ),
        ],

      ),
    );
  }
}
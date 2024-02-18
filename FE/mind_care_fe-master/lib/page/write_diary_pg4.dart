import 'package:mind_care/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/page/write_diary_pg1.dart';
import 'package:mind_care/page/write_diary_pg2.dart';
import 'package:mind_care/page/write_diary_pg3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mind_care/db.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:provider/provider.dart';
//import 'dart:convert';
//import 'package:http/http.dart' as http;

final titleController = TextEditingController();
var now = DateTime.now();
final String Now = DateFormat('yyyy-MM-dd 00:00:00.000').format(now);
final String Z = 'Z';
final String Date = Now + Z;

Future<void> modifyDiary(BuildContext context) async {
  //final int diaryId = ; // 수정할 일기의 ID
  final prefs = await SharedPreferences.getInstance();
  final userid = prefs.getInt('userid'); // SharedPreferences에서 userid 불러오기

  if (userid != null) {
    // 사용자로부터 수정된 일기 데이터
    Map<String, dynamic> updatedDiaryData = {
      //'User_ID': userid, // SharedPreferences에서 불러온 userid 사용
      'Title': titleController.text,
      //'Content_1': experienceTextController.text,
      //'Content_2': emotionTextController.text,
      //'Content_3': reasonTextController.text,
      //'Content_4': thinkTextController.text,
      'Date': Date, // 09:00, Mar 16, 2024
    };
    // 데이터베이스에서 일기 데이터 업데이트
    await DatabaseService.updateDiary(diaryId, updatedDiaryData);
    print('Diary with ID: $diaryId has been updated');
    print(now);
    print(Date);
  } else {
    print('User ID not found in SharedPreferences.');
  }
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomeScreen()),
  );
}

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _Result();
}

class _Result extends State<Result> {
  // Future<void> uploadDiaryToServer() async {
  //   final String apiUrl = "http://34.64.58.86:3000/Diary";

  //   // 사용자 데이터를 Map 형식으로 정의
  //   Map<String, dynamic> userData = {
  //     'Title': titleController.text,
  //     'Date': date,
  //   };

  //   // Map을 JSON 문자열로 변환
  //   String jsonData = jsonEncode(userData);

  //   try {
  //     // HTTP POST 요청 보내기
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonData,
  //     );

  //     if (response.statusCode == 200) {
  //       print('User created successfully.');
  //     } else {
  //       print('Error creating user. Status code: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //   }
  // }

  void onPressedHandler() {
    //uploadDiaryToServer();

    // Get the CalendarData instance from the provider
    //CalendarData calendarData = Provider.of<CalendarData>(context, listen: false);

    // Update the selected date
    //calendarData.updateSelectedDate(DateTime.now());

    modifyDiary(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back), // 아이콘
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WriteEmotion()));
            }),
        title:
            const Text('작성완료', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LinearProgressIndicator(
                    value: 1.0,
                    backgroundColor: Colors.white,
                    color: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(0, 122, 255, 1.0)),
                    minHeight: 2.0,
                    semanticsLabel: 'semanticsLabel',
                    semanticsValue: 'semanticsValue',
                  ),

                  // 멘트
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 40),
                    child: const Text(
                      '일기가 완성되었어요!\n작성한 일기에 제목을 붙여주세요.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // 감정일기 카드
                  Container(
                    width: 374,
                    //height: 151,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xfff0f1f1),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 위 : 글(제목, 날짜), 감정 이모티콘
                        Container(
                            width: 334,
                            height: 64,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 글(제목, 날짜)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 제목
                                    Container(
                                      width: 250,
                                      height: 26,
                                      child: TextField(
                                        controller: titleController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: '제목을 입력하세요.',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                        ),
                                      ),
                                    ),
                                    // 여백
                                    SizedBox(
                                      height: 14,
                                    ),
                                    // 날짜
                                    Container(
                                        child: Text(
                                      DateFormat('hh:mm, MMM dd, yyyy')
                                          .format(now),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff86858A),
                                      ),
                                    )),
                                  ],
                                ),

                                // 감정 이모티콘
                                // Container(
                                //   child: Image.asset(
                                //     'asset/img/logo.png',
                                //     width: 50,
                                //   ),
                                // ),
                                // 감정 이름
                                Container(
                                    child: Text(moodName,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ))),
                              ],
                            )),
                        // 여백
                        SizedBox(
                          height: 18,
                        ),
                        // 아래 : 키워드들
                        //Container(child: Text(keywords[0])
                        // child: Row(
                        //   children: [
                        //     Container(
                        //         child: Row(
                        //               children: [
                        //                 ListView.builder(
                        //                   itemCount: keywords.length,
                        //                   itemBuilder: (context, index) {
                        //                     return Container(
                        //                       // 로컬 keywords 쓰기
                        //                       decoration: BoxDecoration(
                        //                         borderRadius:
                        //                         BorderRadius.circular(100),
                        //                         color: const Color.fromRGBO(
                        //                             211, 212, 212, 1.0),
                        //                       ),
                        //                       child: Text(
                        //                         keywords[index],
                        //                         style: const TextStyle(
                        //                           fontSize: 14,
                        //                           color: Color.fromRGBO(
                        //                               0, 122, 255, 1.0),
                        //                         ),
                        //                       ),
                        //                     );
                        //                   },
                        //                 ),
                        //               ],
                        //             )
                        //),
                      ],
                    ),
                  ),

                  // 일기 내용
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
                          Text(
                            experienceTextController.text,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 17,
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
                          Text(
                            emotionTextController.text,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 17,
                              //fontWeight: FontWeight.bold,
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
                          Text(
                            reasonTextController.text,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 17,
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            height: 20,
                          ),
                          const Text(
                            '나에게 해주고 싶은 말을 자유롭게 적어주세요.',
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
                            thinkTextController.text,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 17,
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
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
                      )),
                  child: const Text(
                    '메인 화면으로',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    onPressedHandler();
                  },
                ),
              )),
        ],
      ),
    );
  }
}

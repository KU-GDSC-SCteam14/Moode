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
DateTime pick_date = DateTime.now();
final String Now = DateFormat('yyyy-MM-dd 00:00:00.000').format(pick_date);
const String Z = 'Z';
final String Date = Now + Z;

Future<void> modifyDiary(BuildContext context) async {
  //final int diaryId = ; // 수정할 일기의 ID
  final prefs = await SharedPreferences.getInstance();
  final userid = prefs.getInt('userid'); // SharedPreferences에서 userid 불러오기

  int? moodId = await DatabaseService.getMoodIdByName(moodName);

  if (moodId == null) {
    print('Mood name "$moodName" not found in the database.');
    return; // Exit the function if no corresponding moodId
  }

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
      'Mood_ID': moodId, // Include the found Mood_ID in the update
    };
    // 데이터베이스에서 일기 데이터 업데이트
    await DatabaseService.updateDiary(diaryId, updatedDiaryData);
    print('Diary with ID: $diaryId has been updated');
    print(pick_date);
    print(Date);
  } else {
    print('User ID not found in SharedPreferences.');
  }

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
}

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _Result();
}

class _Result extends State<Result> {
  void onPressedHandler() async {
    // 데이터베이스에 키워드 데이터 연결
    List<int> keywordIds = await DatabaseService.getKeywordIds(keywords);
    await DatabaseService.insertDiaryKeywords(diaryId, keywordIds);
    print('Keyword $keywords saved with ID $keywordIds in DiaryID: $diaryId');

    modifyDiary(context);

    // SharedPreferences 인스턴스 가져오기
    final prefs = await SharedPreferences.getInstance();

    // UserID 값을 임시 변수에 저장
    final int? userId = prefs.getInt('userid');

    // SharedPreferences에서 모든 데이터 삭제
    await prefs.clear();

    // UserID를 제외한 모든 데이터를 초기화한 후, UserID 값을 다시 저장
    if (userId != null) {
      await prefs.setInt('userid', userId);
    }

    // 필드 초기화
    titleController.clear(); // 제목 컨트롤러 초기화
    experienceTextController.clear(); // '나에게 해주고 싶은 말' 컨트롤러 초기화
    emotionTextController.clear(); // '나에게 해주고 싶은 말' 컨트롤러 초기화
    reasonTextController.clear(); // '나에게 해주고 싶은 말' 컨트롤러 초기화
    thinkTextController.clear(); // '나에게 해주고 싶은 말' 컨트롤러 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back), // 아이콘
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WriteThink()));
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
                        SizedBox(
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
                                    SizedBox(
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
                                    // const SizedBox(
                                    //   height: 14,
                                    // ),
                                    // 날짜
                                    TextButton(
                                      onPressed: () async {
                                        final selectedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: pick_date,
                                          firstDate:
                                              DateTime(1900, 1, 1), // 첫째 날
                                          lastDate: DateTime.now(),
                                        );
                                        if (selectedDate != null) {
                                          setState(() {
                                            pick_date = selectedDate;
                                          });
                                        }
                                      },
                                      child: Text(
                                          '날짜를 선택하세요 : ${DateFormat('MMM dd, yyyy').format(pick_date)}'),
                                    ),
                                  ],
                                ),

                                // 감정 이모티콘
                                Container(
                                  width: 64,
                                  height: 64,
                                  child: getImageWidget(moodName),
                                )
                              ],
                            )),
                        // 여백
                        const SizedBox(
                          height: 18,
                        ),
                        // 아래 : 키워드들
                        Container(
                            //child: Text(keywords[0]),
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
                            ),
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

  Widget getImageWidget(String moodName) {
    switch (moodName) {
      case 'very happy':
        return Image.asset('asset/img/very_happy.png');
      case 'happy':
        return Image.asset('asset/img/happy.png');
      case 'sad':
        return Image.asset('asset/img/sad.png');
      case 'very sad':
        return Image.asset('asset/img/very_sad.png');
      default:
        return Container(); // 예외 처리 혹은 기본값 설정
    }
  }
}

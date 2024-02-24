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
import 'dart:math';
//import 'dart:convert';
//import 'package:http/http.dart' as http;

final titleController = TextEditingController();
DateTime pick_date = DateTime.now();

Future<void> modifyDiary() async {
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
    final String Now = DateFormat('yyyy-MM-dd 00:00:00.000').format(pick_date);
    const String Z = 'Z';
    final String Date = Now + Z;

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

    modifyDiary();

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

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe2e3e4),
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back), // 아이콘
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WriteThink()));
            }),
        title: const Text('작성완료',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
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
                  Container(
                    color: Colors.white,
                    height: 29,
                  ),

                  // 멘트
                  Container(
                    //width: 390,
                    height: 126,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                    child: const Text(
                      '일기가 완성되었어요!\u{1f389}\n작성한 일기에 제목을 붙여주세요.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // 감정일기 카드,
                  Container(
                    width: 410,
                    height: 151,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(255, 255, 255, 0.5),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 위 : 글(제목, 날짜), 감정 이모티콘
                        SizedBox(
                            width: 370,
                            //height: 64,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 글(제목, 날짜)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // 제목
                                    SizedBox(
                                      width: 250,
                                      height: 26,
                                      child: TextField(
                                        controller: titleController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: '제목을 입력하세요. \u{270f}',
                                          labelStyle: TextStyle(
                                            fontSize: 22.0, // 원하는 폰트 크기
                                            color: Color(0xffD8D6D5),
                                            fontWeight:
                                                FontWeight.bold, // 원하는 색상
                                            // 기타 스타일 속성들도 적용 가능
                                          ),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                        ),
                                      ),
                                    ),

                                    // 날짜
                                    TextButton(
                                      style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                            const Size(140.0, 17.0)),
                                      ),
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
                                          '날짜 선택 : ${DateFormat('MMM dd, yyyy').format(pick_date)}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff86858A))),
                                    ),
                                  ],
                                ),

                                // 감정 이모티콘
                                SizedBox(
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
                        Container(
                          //height: 29,
                          width: 334,
                          child: Row(
                            children: [
                              for (int i = 0; i < min(keywords.length, 3); i++)
                                Container(
                                  height: 29,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: const Color.fromRGBO(
                                              225, 226, 226, 0.8),
                                        ),
                                        child: Text(
                                          keywords[i],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff007AFF),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                        height: 29,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // 일기 내용
                  Container(
                      //width: 390,
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 56),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromRGBO(255, 255, 255, 0.8),
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
                              fontWeight: FontWeight.normal,
                              color: Color(0xff272727),
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
                              fontWeight: FontWeight.normal,
                              color: Color(0xff272727),
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
                              fontWeight: FontWeight.normal,
                              color: Color(0xff272727),
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
                              fontWeight: FontWeight.normal,
                              color: Color(0xff272727),
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

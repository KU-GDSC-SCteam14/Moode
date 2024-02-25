import 'package:flutter/material.dart';
import 'package:mind_care/page/write_diary_pg1.dart';
import 'package:mind_care/page/write_diary_pg2.dart';
import 'package:mind_care/page/write_diary_pg4.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mind_care/db.dart';
//import 'dart:convert';
//import 'package:http/http.dart' as http;

final thinkTextController = TextEditingController();

Future<void> modifyDiary(BuildContext context) async {
  //final int diaryId = ; // 수정할 일기의 ID
  final prefs = await SharedPreferences.getInstance();
  final userid = prefs.getInt('userid'); // SharedPreferences에서 userid 불러오기

  if (userid != null) {
    // 사용자로부터 수정된 일기 데이터
    Map<String, dynamic> updatedDiaryData = {
      //'User_ID': userid, // SharedPreferences에서 불러온 userid 사용
      //'Title': 'Updated Diary Title',
      //'Content_1': experienceTextController.text,
      //'Content_2': emotionTextController.text,
      //'Content_3': reasonTextController.text,
      'Content_4': thinkTextController.text,
      //'Date': '2024-02-14', // 수정된 날짜
    };
    // 데이터베이스에서 일기 데이터 업데이트
    await DatabaseService.updateDiary(diaryId, updatedDiaryData);
    print('Diary with ID: $diaryId has been updated');
  } else {
    print('User ID not found in SharedPreferences.');
  }
}

class WriteThink extends StatefulWidget {
  const WriteThink({super.key});

  @override
  State<WriteThink> createState() => _WriteThink();
}

class _WriteThink extends State<WriteThink> {
  void onPressedHandler() {
    modifyDiary(context); // 비동기 함수 호출을 기다립니다.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Result()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42.0),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back), // 아이콘
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WriteEmotion()));
              }),
          title: const Text(
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
                const SizedBox(
                  height: 29,
                ),
                const LinearProgressIndicator(
                  value: 1,
                  backgroundColor: Colors.white,
                  color: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(0, 122, 255, 1.0)),
                  minHeight: 2.0,
                  semanticsLabel: 'semanticsLabel',
                  semanticsValue: 'semanticsValue',
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: const Text(
                    '나에게 해주고 싶은 말을 자유롭게 적어주세요.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: SizedBox(
                    width: 390,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText:
                            'ex) 나는 왜 이런 방식으로 말했을까?\n      나에게 도움이 되는 선택이었나?',
                        labelStyle: TextStyle(
                          fontSize: 16.0, // 원하는 폰트 크기
                          color: Color(0xffD1D3D9),
                          fontWeight: FontWeight.normal, // 원하는 색상
                          // 기타 스타일 속성들도 적용 가능
                        ),
                        contentPadding: EdgeInsets.only(top: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      controller: thinkTextController,
                      maxLines: null, // <-- SEE HERE
                      minLines: 2, // <-- SEE HERE
                      maxLength: 1000,
                    ),
                  ),
                ),
              ],
            )),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(57),
                backgroundColor: const Color.fromRGBO(0, 122, 255, 1.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )),
            child: const Text(
              '다음',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              onPressedHandler();
            }, // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mind_care/page/write_diary_pg1.dart';
import 'package:mind_care/page/write_diary_pg3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mind_care/db.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final emotionTextController = TextEditingController();
final reasonTextController = TextEditingController();
String moodName = "soso";

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
      'Content_2': emotionTextController.text,
      'Content_3': reasonTextController.text,
      //'Content_4': 'Updated content part 4',
      //'Date': '2024-02-14', // 수정된 날짜
    };
    // 데이터베이스에서 일기 데이터 업데이트
    await DatabaseService.updateDiary(diaryId, updatedDiaryData);
    print('Diary with ID: $diaryId has been updated');
  } else {
    print('User ID not found in SharedPreferences.');
  }
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const WriteThink()),
  );
}

class WriteEmotion extends StatefulWidget {
  const WriteEmotion({super.key});

  @override
  State<WriteEmotion> createState() => _WriteEmotion();
}

class _WriteEmotion extends State<WriteEmotion> {
  Future<void> sendMoodRequestMood(String inputText) async {
    try {
      // url 바꿔야 함
      String url = "http://34.22.109.189:3000/AImood?input=$inputText";
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // 서버에서 온 응답을 처리
        Map<String, dynamic> responseData = json.decode(response.body);
        // setState(() {
        //   moodName = responseData['sentiment'];
        // });
        dynamic moodData = responseData['sentiment'];
        moodName = moodData != null ? moodData.toString() : '';
        print(moodName);
      } else {
        // 에러 처리
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      // 예외 처리
      print("Exception: $e");
    }
  }

  // Future<void> _updateLocalMood() async {
  //   // 로컬 데이터베이스 업데이트
  //   await _database.rawInsert(
  //     'INSERT INTO Mood(Mood_Name, Mood_ID) VALUES(?, ?)',
  //     [moodName, moodId],
  //   );
  // }

  // Future<void> uploadDiaryToServer() async {
  //   final String apiUrl = "http://34.64.58.86:3000/Diary";

  //   // 사용자 데이터를 Map 형식으로 정의
  //   Map<String, dynamic> userData = {
  //     'Content_2': emotionTextController.text,
  //     'Content_3': reasonTextController.text,
  //     'Mood_ID': moodId,

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
    sendMoodRequestMood(emotionTextController.text);
    //   _updateLocalMood();
    //   uploadDiaryToServer();
    modifyDiary(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42.0),
        child: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back), // 아이콘
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WriteExperience()));
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
                  const LinearProgressIndicator(
                    value: 0.6,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: const Text(
                      '그 때의 감정을 자세히 들려주세요.',
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
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        controller: emotionTextController,
                        maxLines: null, // <-- SEE HERE
                        minLines: 5, // <-- SEE HERE
                        maxLength: 1000,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: const Text(
                      '왜 그런 감정이 든 것 같나요?',
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
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        controller: reasonTextController,
                        maxLines: null, // <-- SEE HERE
                        minLines: 5, // <-- SEE HERE
                        maxLength: 1000,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            },
          ),
        ],
      ),
    );
  }
}

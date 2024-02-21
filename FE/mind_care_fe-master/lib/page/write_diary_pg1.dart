import 'package:flutter/material.dart';
import 'package:mind_care/screen/home_screen.dart';
import 'package:mind_care/page/write_diary_pg2.dart';
import 'package:mind_care/page/write_diary_pg3.dart';
import 'package:mind_care/page/write_diary_pg4.dart';
//import 'package:flutter/src/material/progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mind_care/db.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

int diaryId = 0;
final experienceTextController = TextEditingController();
List<String> keywords = ["솔루션챌린지"];

Future<void> saveDiary() async {
  final prefs = await SharedPreferences.getInstance();
  final userid = prefs.getInt('userid'); // SharedPreferences에서 userid 불러오기

  print('UserID: $userid');

  if (userid != null) {
    // 사용자로부터 입력받은 일기 데이터
    Map<String, dynamic> diaryData = {
      'User_ID': userid, // SharedPreferences에서 불러온 userid 사용
      'Title': 'tmp_tittle',
      'Content_1': 'tmp_1',
      'Content_2': 'tmp_2',
      'Content_3': 'tmp_3',
      'Content_4': 'tmp_4',
      'Date': '2024-02-13', // 예시로 사용된 오늘날짜
      'Mood_ID': null, // 예시 Mood ID
    };

    // 데이터베이스에 일기 데이터 삽입
    diaryId = await DatabaseService.insertDiary(diaryData);
    print('Diary saved with ID: $diaryId'); // 콘솔에 일기 ID 출력
    print('Diary saved successfully.');
  } else {
    print('User ID not found in SharedPreferences.');
  }
}

Future<void> modifyDiary(BuildContext context) async {
  print('modifyDiary called');
  //final int diaryId = ; // 수정할 일기의 ID
  final prefs = await SharedPreferences.getInstance();
  final userid = prefs.getInt('userid'); // SharedPreferences에서 userid 불러오기

  if (userid != null) {
    // 사용자로부터 수정된 일기 데이터
    Map<String, dynamic> updatedDiaryData = {
      //'User_ID': userid, // SharedPreferences에서 불러온 userid 사용
      //'Title': 'Updated Diary Title',
      'Content_1': experienceTextController.text
      //'Content_2': 'Updated content part 2',
      //'Content_3': 'Updated content part 3',
      //'Content_4': 'Updated content part 4',
      //'Date': '2024-02-14', // 수정된 날짜
      //'Mood_ID': 2, // 수정된 Mood ID
    };

    // 데이터베이스에서 일기 데이터 업데이트
    await DatabaseService.updateDiary(diaryId, updatedDiaryData);
    print('Diary with ID: $diaryId has been updated');
  } else {
    print('User ID not found in SharedPreferences.');
  }

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const WriteEmotion()),
  );
}

Future<void> clearDataAndResetFields() async {

  // 로컬 데이터베이스에서 diaryId를 가진 데이터 삭제
  if (diaryId != 0) { // diaryId가 초기값(0)이 아닌 경우에만 삭제 수행
    await DatabaseService.deleteDiary(diaryId);
    print('diaryId:$diaryId deleted');
    diaryId = 0; // diaryId를 초기화
  }

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
  titleController.clear();
  experienceTextController.clear();
  emotionTextController.clear();
  reasonTextController.clear();
  thinkTextController.clear();
}


class WriteExperience extends StatefulWidget {
  const WriteExperience({super.key});

  @override
  State<WriteExperience> createState() => _WriteExperienceSate();
}

class _WriteExperienceSate extends State<WriteExperience> {
  bool isCompleted = false;

  // Future<void> uploadDiaryToServer() async {
  //   final String apiUrl = "http://34.64.58.86:3000/Diary";

  //   // 사용자 데이터를 Map 형식으로 정의
  //   Map<String, dynamic> userData = {
  //     "Diary_ID": diaryId,
  //     //"User_ID": userid,
  //     "Content_1": experienceTextController.text,
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

  Future<void> sendAIRequestKeyword(String inputText) async {
    try {
      String url = "http://34.22.109.189:3000/AIkeyword?input=$inputText";
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // 서버에서 온 응답을 처리
        Map<String, dynamic> responseData = json.decode(response.body);
        // setState(() {
        //   keywords = responseData['Keywords_Extract'];
        //   print(keywords);
        // });
        dynamic keywordsData = responseData['keywords'];
        keywords = keywordsData != null ? List<String>.from(keywordsData) : [];
        print(keywords);
      } else {
        // 에러 처리
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      // 예외 처리
      print("Exception: $e");
    }
  }

  // Future<void> _updateLocalDiaryKeyWord() async {
  //   // 로컬 데이터베이스 업데이트
  //   await _database.rawInsert(
  //     'INSERT INTO DiaryKeyWord(Diary_ID, Keyword_ID) VALUES(?, ?)',
  //     [diaryId, keywordId],
  //   );
  // }

  // Future<void> _updateLocalKeyword() async {
  //   // 로컬 데이터베이스 업데이트
  //   await _database.rawInsert(
  //     'INSERT INTO Keyword(Keyword) VALUES(?, ?)',
  //     [keywords],
  //   );
  // }

  void onPressedHandler() {
    //  uploadDiaryToServer();
    sendAIRequestKeyword(experienceTextController.text);
    // _updateLocalDiaryKeyWord();
    // _updateLocalKeyword();
    modifyDiary(context);
  }

  @override
  Widget build(BuildContext context) {
    saveDiary();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42.0),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                          //padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ))),
                          //width: 302,
                          height: 134.5,
                          child: const Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // 가운데 정렬
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '일기 작성을 그만 두시겠어요?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              //Container(
                              //padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                              //child:
                              Text(
                                '작성 중인 일기 내용은 저장되지 않아요.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              //),
                            ],
                          )),
                      backgroundColor: const Color.fromRGBO(211, 211, 211, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      actions: <Widget>[
                        //Container(
                        //child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // 가운데 정렬
                          children: [
                            TextButton(
                              onPressed: () async {
                                await clearDataAndResetFields();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()),
                                );
                              },
                              child: const Text(
                                '닫기',
                                style: TextStyle(
                                  color: Color.fromRGBO(209, 11, 11, 1.0),
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isCompleted == true
                                      ? isCompleted = false
                                      : isCompleted = true;
                                });
                                
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                '취소',
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 122, 255, 1.0),
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.arrow_back),
          ),
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
                  value: 0.3,
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
                    '오늘 어떤 일이 있었나요?',
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
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      controller: experienceTextController,
                      maxLines: null, // <-- SEE HERE
                      minLines: 5, // <-- SEE HERE
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
            },
          ),
        ],
      ),
    );
  }
}

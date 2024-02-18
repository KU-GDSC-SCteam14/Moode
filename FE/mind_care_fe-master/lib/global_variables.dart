import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  int diaryId = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController experienceTextController = TextEditingController();
  TextEditingController emotionTextController = TextEditingController();
  TextEditingController reasonTextController = TextEditingController();
  TextEditingController thinkTextController = TextEditingController();
  String date = "";
  List<String> keywords = ["솔루션챌린지"];
  String moodName = "soso";

// 다른 파일에서 이 클래스의 인스턴스를 사용하여 상태를 업데이트하도록 하는 메서드들을 추가할 수 있습니다.
}
import 'package:flutter/material.dart';
import 'package:mind_care/db.dart';

// diary id 기준으로 content1, content2, content3, content4 불러와주세요!!!

class ContentsCard extends StatefulWidget {
  final int diaryID;
  const ContentsCard({super.key, required this.diaryID});

  @override
  State<ContentsCard> createState() => _ContentsCard();
}

class _ContentsCard extends State<ContentsCard> {
  String experienceTextController = "";
  String emotionTextController = "";
  String reasonTextController = "";
  String thinkTextController = "";

  @override
  void initState() {
    super.initState();
    _fetchDiaryDetails();
  }

  void _fetchDiaryDetails() async {
    final diaryDetails = await DatabaseService.getDiaryDetailsById(widget.diaryID);
    if (diaryDetails != null) {
      setState(() {
        experienceTextController = diaryDetails['Content_1'] ?? "";
        emotionTextController = diaryDetails['Content_2'] ?? "";
        reasonTextController = diaryDetails['Content_3'] ?? "";
        thinkTextController = diaryDetails['Content_4'] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Text('오늘 어떤 일이 있었나요?'),
          Text(experienceTextController),
          const Text('그 때의 감정을 자세히 들려주세요.'),
          Text(emotionTextController),
          const Text('왜 그런 감정이 든 것 같나요?'),
          Text(reasonTextController),
          const Text('나에게 해주고 싶은 말을 자유롭게 적어주세요.'),
          Text(thinkTextController),
        ],
      ),
    );
  }
}

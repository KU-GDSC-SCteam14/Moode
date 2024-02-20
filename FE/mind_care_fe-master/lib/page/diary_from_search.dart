import 'package:flutter/material.dart';
import 'package:mind_care/card/simple_diary_card.dart';
import 'package:mind_care/db.dart';

class ShowDiaryfromSearch extends StatefulWidget {
  final int diaryID;
  const ShowDiaryfromSearch({super.key, required this.diaryID});

  @override
  State<ShowDiaryfromSearch> createState() => _ShowDiaryfromSearch();
}

class _ShowDiaryfromSearch extends State<ShowDiaryfromSearch> {
  String content1 = "";
  String content2 = "";
  String content3 = "";
  String content4 = "";

  @override
  void initState() {
    super.initState();
    _loadDiaryDetails();
  }

  Future<void> _loadDiaryDetails() async {
    final diaryDetails =
        await DatabaseService.getDiaryDetailsById(widget.diaryID);
    if (diaryDetails != null) {
      setState(() {
        content1 = diaryDetails['Content_1'] ?? '';
        content2 = diaryDetails['Content_2'] ?? '';
        content3 = diaryDetails['Content_3'] ?? '';
        content4 = diaryDetails['Content_4'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //***********************diaryID 기준으로 content1, content2, content3, content4 불러와주세요!!!!!

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42.0),
        child: AppBar(
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
                DiaryCard(diaryID: widget.diaryID),
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
                        const Text(
                          '이번 주말에는 예전부터 계획해 온 산책과 휴식을 위해 해안가의 조용한 해수욕장으로 가족들과 함께 떠났어. 그런데 도착하자마자 예상치 못한 날씨 변화로 강한 바람과 비가 내려 해변에서의 휴식이 불가능해졌어.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
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
                        const Text(
                          '해변에서의 산책과 함께하는 가족 휴식은 기대했던 대로 이뤄지지 않을 것 같았어. 그런데도 우리는 가족들과 함께 새로운 계획을 세우고, 예상치 못한 날씨 속에서도 즐거움을 찾아볼 수 있는 방법을 찾아야 했어. 주변에 있는 카페나 실내 활동을 찾아보며 새로운 경험을 쌓을 수 있을 것 같다는 생각이 들었어.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
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
                        const Text(
                          '해변에서의 산책과 함께하는 가족 휴식은 기대했던 대로 이뤄지지 않을 것 같았어. 그런데도 우리는 가족들과 함께 새로운 계획을 세우고, 예상치 못한 날씨 속에서도 즐거움을 찾아볼 수 있는 방법을 찾아야 했어. 주변에 있는 카페나 실내 활동을 찾아보며 새로운 경험을 쌓을 수 있을 것 같다는 생각이 들었어.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

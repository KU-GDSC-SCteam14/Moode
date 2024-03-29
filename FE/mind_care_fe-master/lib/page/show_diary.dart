import 'package:flutter/material.dart';
import 'package:mind_care/card/simple_diary_card.dart';
import 'package:mind_care/db.dart';
import 'package:mind_care/card/contents_card.dart';

class ShowDiary extends StatefulWidget {
  final int diaryID;
  const ShowDiary({super.key, required this.diaryID});

  @override
  State<ShowDiary> createState() => _ShowDiary();
}

class _ShowDiary extends State<ShowDiary> {
  //***********************diaryID 기준으로 content1, content2, content3, content4 불러와주세요!!!!!

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
    return Scaffold(
      backgroundColor: Color(0xffe2e3e4),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(71.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.center,
                end: Alignment.bottomCenter,
                colors: const <Color>[
                  Colors.white,
                  Color(0xffe2e3e4),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          title: Image.asset(
            'asset/img/moode_mint.png',
            width: 100,
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
                SizedBox(
                  height: 8,
                ),
                DiaryCard(diaryID: widget.diaryID),
                SizedBox(
                  height: 8,
                ),
                ContentsCard(diaryID: widget.diaryID),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mind_care/card/simple_diary_card.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:mind_care/db.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:mind_care/card/contents_card.dart';

class ShowDiaryfromList extends StatefulWidget {
  final int diaryID;
  const ShowDiaryfromList({super.key, required this.diaryID});

  @override
  State<ShowDiaryfromList> createState() => _ShowDiaryfromList();
}

class _ShowDiaryfromList extends State<ShowDiaryfromList> {
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
                ContentsCard(diaryID: widget.diaryID),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

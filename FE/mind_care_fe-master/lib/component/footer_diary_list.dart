import 'package:flutter/material.dart';
// import 'package:mind_care/component/body_calendar.dart';
import 'package:mind_care/page/diary_from_list.dart';
import 'package:intl/intl.dart';
import 'package:mind_care/text_diary_card.dart';
import 'package:mind_care/db.dart';

class SelectedDiaryList extends StatefulWidget {
  final DateTime selectedDate;

  const SelectedDiaryList({required this.selectedDate, super.key});

  @override
  State<SelectedDiaryList> createState() => _SelectedDiaryListState();
}

class _SelectedDiaryListState extends State<SelectedDiaryList> {
  late Future<List<int>> diaryIds;

  @override
  void initState() {
    super.initState();
    diaryIds = DatabaseService.getDiariesByDate(widget.selectedDate.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: diaryIds,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<int> diaryIDs = snapshot.data!;
          String weekday =
              DateFormat('E').format(widget.selectedDate).toUpperCase();

          return Container(
            decoration: BoxDecoration(
              color: const Color(0xffd6dadc),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 32),
                        child: Text(
                          '$weekday ${widget.selectedDate.day}, ${widget.selectedDate.month} ${widget.selectedDate.year}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true, // 추가된 부분: ListView가 부모 위젯의 크기에 맞게 조절
                        physics:
                            const NeverScrollableScrollPhysics(), // 추가된 부분: 스크롤을 방지
                        itemCount: diaryIDs.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowDiaryfromList(
                                          diaryID: diaryIDs[index])));
                            },
                            child: DiaryCard(diaryID: diaryIDs[index]),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}

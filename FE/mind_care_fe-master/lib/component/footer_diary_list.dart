import 'package:flutter/material.dart';
// import 'package:mind_care/component/body_calendar.dart';
import 'package:mind_care/page/diary_from_list.dart';
import 'package:intl/intl.dart';
import 'package:mind_care/card/text_diary_card.dart';
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
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            decoration: const BoxDecoration(
              color: Color(0xffeceded),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: 390,
                        height: 20,
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 32),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('EEEE')
                                    .format(widget.selectedDate)
                                    .toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Container(
                                  height: 20,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 1.5,
                                  ),
                                  child: Text(
                                      DateFormat('MMM dd, yyyy')
                                          .format(widget.selectedDate),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff86858A),
                                      )))
                            ]),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                          shrinkWrap:
                              true, // 추가된 부분: ListView가 부모 위젯의 크기에 맞게 조절
                          physics:
                              const NeverScrollableScrollPhysics(), // 추가된 부분: 스크롤을 방지
                          itemCount: diaryIDs.length,
                          itemBuilder: (context, index) {
                            // if (diaryIDs.length == 0) {
                            //   return SizedBox(
                            //     height: 56,
                            //   );
                            // } else {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowDiaryfromList(
                                            diaryID: diaryIDs[index])));
                              },
                              child: Container(
                                height: 171,
                                padding: EdgeInsets.only(bottom: 8),
                                child: DiaryCard(diaryID: diaryIDs[index]),
                              ),
                            );
                          }
                          //},
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

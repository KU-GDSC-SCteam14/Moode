import 'package:flutter/material.dart';
// import 'package:mind_care/component/body_calendar.dart';
import 'package:mind_care/page/show_diary.dart';
import 'package:intl/intl.dart';
import 'package:mind_care/card/text_diary_card.dart';
import 'package:mind_care/db.dart';
import 'package:table_calendar/table_calendar.dart';

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
  void didUpdateWidget(covariant SelectedDiaryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      // Update diaryIds with the new selectedDate
      diaryIds =
          DatabaseService.getDiariesByDate(widget.selectedDate.toString());
      setState(() {}); // Trigger a rebuild with the new data
    }
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
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(
            height: 300,
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            decoration: const BoxDecoration(
              color: Color(0xffeceded),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              ///crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  //height: double.infinity,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              const SizedBox(
                                width: 7,
                              ),
                              Container(
                                  height: 20,
                                  padding: const EdgeInsets.symmetric(
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
                      const SizedBox(height: 50),
                      Text(
                        textAlign: TextAlign.center,
                        '아직 작성한 일기가 없어요!',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasData) {
          List<int> diaryIDs = snapshot.data!;

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
                              const SizedBox(
                                width: 7,
                              ),
                              Container(
                                  height: 20,
                                  padding: const EdgeInsets.symmetric(
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
                                        builder: (context) => ShowDiary(
                                            diaryID: diaryIDs[index])));
                              },
                              child: Column(
                                children: [
                                  DiaryCard(diaryID: diaryIDs[index]),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
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

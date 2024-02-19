import 'package:flutter/material.dart';
import 'package:mind_care/component/body_calendar.dart';
import 'package:mind_care/component/footer_diary_list.dart';
import 'package:mind_care/page/write_diary_pg1.dart';
import 'package:mind_care/component/search_keyword_pg1.dart';
//import 'package:mind_care/page/show_selectedfromlist_diary.dart';
//import 'package:intl/intl.dart';
//import 'package:mind_care/component/setting.dart';
import 'package:mind_care/screen/happy_diary_screen.dart';
import 'package:provider/provider.dart';

class CalendarData extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 선택된 날짜를 관리할 변수
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CalendarData(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Mind Care'),
            centerTitle: true,
            leading: IconButton(
                // 간단한 위젯이나 타이틀들을 앱바의 왼쪽에 위치시키는 것을 말함
                icon: const Icon(Icons.menu), // 아이콘
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HappyDiaryScreen()),
                  );
                }),
            actions: [
              IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchKeyword()),
                    );
                  }),
            ],
          ),
          body: SafeArea(
            child: ListView(
              children: [
                // BodyCalendar(
                //   selectedDate: selectedDate, // 날짜 전달하기
                //   onDaySelected: onDaySelected, // 날짜 선택됐을 때 실행할 함수
                // ),
                SelectedDiaryList(
                  selectedDate: selectedDate,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: const Color.fromRGBO(0, 122, 255, 1.0),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WriteExperience()));
            },
            icon: const Icon(
              Icons.add,
            ),
            label: const Text('슬라이드 해 오늘의 일기를 작성하세요.'),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    // 날짜 선택될 때마다(탭할 때마다) 실행할 함수
    print(selectedDate);
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}

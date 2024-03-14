import 'package:flutter/material.dart';
import 'package:mind_care/component/body_calendar.dart';
import 'package:mind_care/component/footer_diary_list.dart';
import 'package:mind_care/page/write_diary_pg1.dart';
import 'package:mind_care/component/search_keyword_pg1.dart';
//import 'package:mind_care/page/show_selectedfromlist_diary.dart';
//import 'package:intl/intl.dart';
import 'package:mind_care/component/setting.dart';
import 'package:mind_care/screen/happy_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:slider_button/slider_button.dart';
// import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:mind_care/db.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // 선택된 날짜를 관리할 변수
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  late AnimationController _controller;
  late Animation<double> _animation;
  ValueNotifier<double> iconPositionNotifier = ValueNotifier<double>(0.0);
  bool showPositiveDiaryBanner = false;

  void _checkForPositiveDiaries() async {
    DateTime now = DateTime.now();
    // Find the last Sunday
    DateTime lastSunday = now.subtract(Duration(days: now.weekday % 7));
    // Find next Saturday
    DateTime nextSaturday = lastSunday.add(Duration(days: 6));

    bool foundPositiveDiary = false;
    for (DateTime date = lastSunday;
        date.isBefore(nextSaturday.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      String dateString =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      List<int> diaries =
          await DatabaseService.getDiariesByDateAndMood(dateString);
      if (diaries.isNotEmpty) {
        foundPositiveDiary = true;
        break;
      }
    }

    setState(() {
      showPositiveDiaryBanner = foundPositiveDiary;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500), // 애니메이션 지속 시간 설정
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(_controller)
      ..addListener(() {
        iconPositionNotifier.value = _animation.value;
      });
    _checkForPositiveDiaries();
  }

  @override
  void dispose() {
    iconPositionNotifier.dispose();
    _controller.dispose(); // 리소스 해제
    super.dispose();
  }

  void startSlideBackAnimation(double startPosition) {
    _animation = Tween<double>(begin: startPosition, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        iconPositionNotifier.value = _animation.value;
      });
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 215, 216, 216),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'asset/img/moode_mint.png',
          width: 100,
        ),
        centerTitle: true,
        leading: IconButton(
            // 간단한 위젯이나 타이틀들을 앱바의 왼쪽에 위치시키는 것을 말함
            icon: const Icon(Icons.menu, size: 30), // 아이콘
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Setting()),
              );
            }),
        actions: [
          IconButton(
              icon: const Icon(Icons.search, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchKeyword()),
                );
              }),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 105),
            children: [
              showPositiveDiaryBanner
                  // 주간 긍정일기 확인버튼 배너
                  ? Container(
                      color: const Color(0xfff8f9f9),
                      width: 390,
                      height: 77,
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '주간 긍정일기를 확인해보세요.',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xff626262)),
                              ),
                              SizedBox(
                                width: 73,
                                height: 41,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(12)),
                                      backgroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                        Color.fromRGBO(49, 200, 201, 0.15),
                                      ),
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      )),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HappyDiaryScreen()),
                                      );
                                    },
                                    child: const Text(
                                      '확인하기',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff007AFF)),
                                    )),
                              )
                            ]),
                      ),
                    )
                  : SizedBox.shrink(),
              BodyCalendar(
                  selectedDate: selectedDate,
                  onDaySelected: (DateTime selected, DateTime focused) {
                    setState(() {
                      selectedDate = selected;
                    });
                  }),
              const SizedBox(height: 4),
              SelectedDiaryList(selectedDate: selectedDate),
            ],
          ),
          Positioned.fill(
              child: IgnorePointer(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 174.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromARGB(255, 149, 149, 149),
                      Color.fromARGB(255, 164, 164, 164),
                      Color.fromARGB(0, 177, 177, 177),
                    ],
                    stops: [0.0, 0.3, 1.0],
                  ),
                ),
              ),
            ),
          )),
          Positioned(
            right: 8,
            left: 8,
            bottom: 50,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                double newExtent =
                    iconPositionNotifier.value + details.primaryDelta!;
                double newPosition = newExtent;
                if (newPosition < 0) {
                  newPosition = 0;
                } else if (newPosition > 300) {
                  newPosition = 300;
                }
                iconPositionNotifier.value = newPosition;
              },
              onHorizontalDragEnd: (details) {
                if (iconPositionNotifier.value >= 300) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WriteExperience()),
                  );
                } else {
                  startSlideBackAnimation(iconPositionNotifier.value);
                }
                iconPositionNotifier.value = 0;
              },
              child: Container(
                width: 374,
                height: 74,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/img/slider_background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    ValueListenableBuilder<double>(
                      valueListenable: iconPositionNotifier,
                      builder: (context, value, child) {
                        return SliderIcon(iconPosition: value);
                      },
                    ),
                    Positioned(
                      left: 85,
                      child: ValueListenableBuilder<double>(
                        valueListenable: iconPositionNotifier,
                        builder: (context, value, child) {
                          // 슬라이더 이동 거리에 따른 텍스트 투명도 조절
                          double opacity =
                              (1 - value / 40); // 0에서 300까지 이동 시 1에서 0으로 변경
                          return Opacity(
                            opacity: opacity.clamp(
                                0.0, 1.0), // 투명도는 0.0에서 1.0 사이 값으로 제한
                            child: Image.asset("asset/img/slider_text.png",
                                height: 25),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    print(selectedDate);
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}

class SliderIcon extends StatefulWidget {
  final double iconPosition;

  const SliderIcon({Key? key, required this.iconPosition}) : super(key: key);

  @override
  _SliderIconState createState() => _SliderIconState();
}

class _SliderIconState extends State<SliderIcon> {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(widget.iconPosition, 0),
      child: Image.asset("asset/img/slider_icon.png", width: 75, height: 75),
    );
  }
}

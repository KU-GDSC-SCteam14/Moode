import 'package:flutter/material.dart';
import 'package:mind_care/component/body_calendar.dart';
import 'package:mind_care/component/footer_diary_list.dart';
import 'package:mind_care/page/write_diary_pg1.dart';
import 'package:mind_care/component/search_keyword_pg1.dart';
import 'package:mind_care/page/show_selectedfromlist_diary.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_native_timezone/flutter_native_timezone.dart';
//import 'package:timezone/timezone.dart' as tz;
//import 'package:timezone/data/latest.dart' as tz;
import 'package:mind_care/component/setting.dart';

// hihiccohoh
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState(){
//     super.initState();
//     //WidgetsBinding.instance!.addObserver(this);
//     _init();
//   }
//
//
//   Future<void> configureTime() async{
//     tz.initializeTimeZones();
//     final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName!));
//   }
//
//   Future<void> initializeNoti() async {
//     const AndroidInitializationSettings initializationSettingAndroid =AndroidInitializationSettings('@mipmap/ic_launcher');
//     const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingAndroid,);
//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   Future<void> _MessageSetting({
//     required int hour,
//     required int minutes,
//     required message,
// }) async {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//        now.day,
//       hour,
//       minutes,
//     );
//     await _flutterLocalNotificationsPlugin.zonedSchedule(0, 'Push_notification', message, scheduledDate, NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channel id', 'channel name', importance: Importance.max, priority: Priority.high, ongoing: true, styleInformation: BigTextStyleInformation(message),
//         icon: '@mipmap/ic_launcher',
//       ),
//     ), androidAllowWhileIdle:true, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }
//
//   Future<void> _init() async{
//     await configureTime();
//     await initializeNoti();
//   }


  // 선택된 날짜를 관리할 변수
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mind Care'),
        centerTitle: true,
        leading: IconButton(
          // 간단한 위젯이나 타이틀들을 앱바의 왼쪽에 위치시키는 것을 말함
          icon: Icon(Icons.menu), // 아이콘
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Setting(
                  )),
            );
          }
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchKeyword(
                  )),
            );
          }),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            BodyCalendar(
              selectedDate: selectedDate, // 날짜 전달하기
              onDaySelected: onDaySelected, // 날짜 선택됐을 때 실행할 함수
            ),
            SelectedDiaryList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromRGBO(0, 122, 255, 1.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WriteExperience(
                      //selectedDate: selectedDate,
                    )),
          );
        },
        icon: const Icon(
          Icons.add,
        ),
        label: const Text('슬라이드 해 오늘의 일기를 작성하세요.'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    // 날짜 선택될 때마다(탭할 때마다) 실행할 함수
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}

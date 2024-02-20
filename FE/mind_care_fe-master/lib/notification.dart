import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notifications = FlutterLocalNotificationsPlugin();

//1. 앱로드시 실행할 기본설정
initNotification() async {
  //안드로이드용 아이콘파일 이름
  var androidSetting = AndroidInitializationSettings('app_icon');

  //ios에서 앱 로드시 유저에게 권한요청하려면
  var iosSetting = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings =
      InitializationSettings(android: androidSetting, iOS: iosSetting);
  await notifications.initialize(
    initializationSettings,
    //알림 누를때 함수실행하고 싶으면
    //onSelectNotification: 함수명추가
  );
}

// 특정시간에 알림을 띄우려면?
makeDate(hour, min, sec) {
  var now = tz.TZDateTime.now(tz.local);
  var when =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, min, sec);
  if (when.isBefore(now)) {
    return when.add(Duration(days: 1));
  } else {
    return when;
  }
}

showNotification2() async {
  tz.initializeTimeZones();

  var androidDetails = const AndroidNotificationDetails(
    '유니크한 알림 ID',
    '알림종류 설명',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );
  var iosDetails = const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 매주 일요일 12:00 PM에 알림 설정
  var scheduledTime = DateTime.now()
      .add(Duration(days: (DateTime.sunday - DateTime.now().weekday) + 7));
  scheduledTime = DateTime(
      scheduledTime.year, scheduledTime.month, scheduledTime.day, 12, 0, 0);

  await notifications.zonedSchedule(
    2,
    '주간 긍정일기를 확인해보세요',
    '매주 같은 요일, 같은 시간 알림입니다.',
    // 특정 시간에 알림 띄우기
    makeDate(9, 0, 0),
    NotificationDetails(android: androidDetails, iOS: iosDetails),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    // 주기적으로 알림을 띄우고 싶으면?
    // 일주일에 한 번 알림 발생
    matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
  );
}

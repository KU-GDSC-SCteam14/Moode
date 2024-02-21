import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mind_care/screen/home_screen.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:mind_care/login_page.dart';
import 'dart:async';
import 'db.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'screen/home_screen.dart';

// 사용자 정보 및 FCM 토큰을 서버에 저장
Future<void> saveUserAndFCMToken() async {
  
  final fcmToken = await FirebaseMessaging.instance.getToken(); // FCM 토큰 획득
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('fcmToken', fcmToken!);
  print('Token saved: $fcmToken');

  final url = Uri.parse('http://34.22.109.189:3000/User');
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({
    "Name": "Testname",
    "email": "adjlsakj-testd212@example.testtest.com",
    "Signup_date": "2024-02-13 12:00:00",
    "is_Google": true,
    "is_Apple": false,
    "Provider_ID": "test_provider_id",
    "Access_Token": "test_access_token",
    "Refresh_Token": "test_refresh_token",
    "Token_Expiry_Date": "2024-02-13 12:00:00",
    "FCM_Token": "fcmToken", // FCM 토큰 추가
    "Profile_Picture_URL": "test_profile_picture_url"
  });

  try {
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        final userid = responseData['userid'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userid', userid);
        print('User saved with ID: $userid');
        print('Token saved: $fcmToken');

        // SQLite 데이터베이스에 유저 데이터와 FCM 토큰 저장
        await DatabaseService.insertUser({
          "User_ID": userid,
          "Name": "Testname",
          "email": "adjlsakj-testd212@example.testtest.com",
          "Signup_date": "2024-02-13 12:00:00",
          "is_Google": true,
          "is_Apple": false,
          "Provider_ID": "test_provider_id",
          "Access_Token": "test_access_token",
          "Refresh_Token": "test_refresh_token",
          "Token_Expiry_Date": "2024-02-13 12:00:00",
          "FCM_Token": fcmToken, // 로컬 DB에도 FCM 토큰 저장
          "Profile_Picture_URL": "test_profile_picture_url"
        });
        print('Local DB fetched and FCM token saved $fcmToken');
      }
    } else {
      print('Failed to save user and FCM token.');
    }
  } catch (e) {
    print('Error saving user and FCM token: $e');
  }
}

//****************
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("백그라운드 메시지 처리.. ${message.notification!.body!}");
}

// ******************
void initializeNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 기본 채널 설정
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  ));

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // 포어그라운드 메시지 설정
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // 기타 알림 세부 설정...
          ),
        ),
      );
    }
  });
}

Future<void> main() async {
  // Database db = await DatabaseService.database;

  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // String? firebaseToken = await fcmSetting();
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진이 초기화되었는지 확인
  await Firebase.initializeApp();
  initializeNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  String? token = await FirebaseMessaging.instance.getToken();
  print('현재 등록된 토큰: $token');
  saveUserAndFCMToken();
  await DatabaseService.printTableContents('Mood');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Pretendard"),
      // 앱의 런치 스크린을 나타내는 위젯
      home: const LaunchScreen(),
    );
  }
}

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
// *************
  var messageString = "";

  @override
  void initState() {
// *************

    super.initState();
    //타이머를 사용하여 2초 후에 홈 화면으로 이동
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'asset/img/logo.png',
          width: 86,
        ),
      ),
    );
  }
}


//********************************************************************************************************************** */
// import 'package:firebase_core/firebase_core.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:flutter/material.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("백그라운드 메시지 처리.. ${message.notification!.body!}");
// }

// void initializeNotification() async {
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(const AndroidNotificationChannel(
//           'high_importance_channel', 'high_importance_notification',
//           importance: Importance.max));

//   await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
//     android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//   ));

//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp();

//   initializeNotification();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var messageString = "";

//   void getMyDeviceToken() async {
//     final token = await FirebaseMessaging.instance.getToken();

//     print("내 디바이스 토큰: $token");
//   }

//   @override
//   void initState() {
//     getMyDeviceToken();

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       RemoteNotification? notification = message.notification;

//       if (notification != null) {
//         FlutterLocalNotificationsPlugin().show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               'high_importance_channel',
//               'high_importance_notification',
//               importance: Importance.max,
//             ),
//           ),
//         );

//         setState(() {
//           messageString = message.notification!.body!;

//           print("Foreground 메시지 수신: $messageString");
//         });
//       }
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("메시지 내용: $messageString"),
//           ],
//         ),
//       ),
//     );
//   }
// }

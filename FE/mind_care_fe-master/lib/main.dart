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


// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   fcmSetting();
//
//
//   runApp(const ProviderScope(child: MyApp()));
// }

// Future<String?> fcmSetting() async {
//   await Firebase.initializeApp(options: DefaultFirevaseOptions.currentPlatform);
//
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
// await messaging.setForegroundNotificationPresentationOptions(
//   alert: true,
//   badge: true,
//   sound: true,
// );
//
// NotificationSettings settings = await messaging.requestPermission(
//   alert: true,
//   announcement: false,
//   badge: true,
//   carPlay: false,
//   criticalAlert: false,
//   provisional: false,
//   sound: true,
// );
// print('User granted permission: ${settings.authorizationStatus}');
//
// // foreground에서의 푸쉬 알림 표시를 위한 알림 중요도 설정(안드로이드)
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'max_importance_channel', // id
//     'Max Importance Notifications',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.max,
//     );
//
//
// // var initialzationSettingsIOS = const DarwinInitializationSettings(
// //   requestSoundPermission: true,
// //   requestBadgePermission: true,
// //   requestAlertPermission: true,
// // );
//
// //var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/launcher_icon');
//
// //var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initialzationSettingsIOS);
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// await flutterLocalNotificationsPlugin
//     .resolvePlatformSpecificImplementation<
//     AndroidFlutterLocalNotificationsPlugin>()
//     ?.createNotificationChannel(channel);

// await flutterLocalNotificationsPlugin
//     .resolvePlatformSpecificImplementation<
//     IOSFlutterLocalNotificationsPlugin>()
//     ?.getActiveNotifications();
//
// await flutterLocalNotificationsPlugin.initialize(
//   initializationSettings,
// );

// FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//
//   print('Got a message while in the foreground!');
//   print('Message data: ${message.data}');
//
//   if (message.notification != null && android != null) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification?.title,
//       notification?.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           icon: android.smallIcon,
//           channelDescription: channel.description,
//         ),
//       ),
//     );
//     print('Message also contained a notification: ${message.notification}');
//   }
// });
//
// // 토큰 발급
// String? firebaseToken = await messaging.getToken();
// print('firebaseToken : ${firebaseToken}');
//
// return firebaseToken;
// // 토큰 리프레시 수신
// FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
//   // save token to server
// });
// }

Future<void> saveUser() async {
  final url = Uri.parse('http://34.64.250.30:3000/User');
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
    "Profile_Picture_URL": "test_profile_picture_url"
  });

  try {
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        final userid = responseData['userid'];
        final prefs =
            await SharedPreferences.getInstance(); // 이 부분(await)때문에 유저가 기다려야함.
        await prefs.setInt('userid', userid);
        print('User saved with ID: $userid');
        // SQLite 데이터베이스에 유저 데이터 저장
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
          "Profile_Picture_URL": "test_profile_picture_url"
        });
        print('Local DB fetched');
      }
    } else {
      print('Failed to save user.');
    }
  } catch (e) {
    print('Error saving user: $e');
  }
}

void main() async {
  // Database db = await DatabaseService.database;

  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // String? firebaseToken = await fcmSetting();
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진이 초기화되었는지 확인
  await Firebase.initializeApp();
  String? token = await FirebaseMessaging.instance.getToken();
  print('현재 등록된 토큰: $token');
  saveUser();
  await DatabaseService.printTableContents('Mood');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // 앱의 런치 스크린을 나타내는 위젯
      home: LaunchScreen(),
    );
  }
}

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
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

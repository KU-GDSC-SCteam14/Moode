// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mind_care/screen/home_screen.dart';
//
// //final GoogleSignIn googleSignIn= GoogleSignIn();
// //Future<void> signInWithGoogle() async {
// //  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn(); final GoogleSignInAuthentication googleSignInAuthentication =
// //    await googleSignInAccount!.authentication;
//
// //  final OAuthCredential credential = GoogleAuthProvider.credential(
// //  );
// //  accessToken: googleSignInAuthentication.accessToken;
// //  idToken: googleSignInAuthentication.idToken;
// //  final UserCredential userCredential =
// //    await FirebaseAuth.instance.signInWithCredential(credential);
// //  final User user = userCredential.user!;
// //}
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginPage(),
//     );
//   }
// }
//
//
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
//
//
//   _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//       // 로그인 성공 시 수행할 작업 추가
//       print("로그인 성공");
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => HomeScreen()),
//       );
//     } catch (error) {
//       print("로그인 실패: $error");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 300,
//             ),
//             Image.asset(
//               'asset/img/logo.png',
//               width: 86,
//             ),
//             SizedBox(
//               height: 220,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                   onPressed: _handleSignIn,
//                   style: ElevatedButton.styleFrom(
//                     elevation: 0,
//                     backgroundColor: Colors.black,
//                     minimumSize: Size(358, 50),
//                   ),
//                   child: Row(
//                     //spaceEvenly: 요소들을 균등하게 배치하는 속성
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                       Image.asset('asset/img/g-logo.png',
//                         width: 18,
//                     ),
//                   Text('Continue with Google',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                   ),),
//               ],
//             ),
//       ),
//       ],
//             ),
//       ],
//       ),
//       ),
//     );
//   }
// }
//
//
//

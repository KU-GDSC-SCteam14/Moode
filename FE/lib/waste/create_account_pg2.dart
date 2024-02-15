// import 'package:flutter/material.dart';
// import 'package:mind_care/screen/home_screen.dart';
//
// class WelcomePage extends StatelessWidget {
//   final String enteredName;
//
//   WelcomePage(this.enteredName);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//           children: [
//             SizedBox(
//               height: 250,
//             ),
//             Image.asset(
//               'asset/img/logo.png',
//               width: 86,
//             ),
//             Expanded(child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
//                     child: Text('Welcome, ${enteredName}!',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16,),
//                     child: Text('Your everyday moodies',
//                       style: TextStyle(
//                         fontSize: 17,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ),
//             Align(
//                 alignment: Alignment.bottomCenter,
//                 child: SizedBox(
//                   width: 358,
//                   height: 57,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromRGBO(0, 122, 255, 1.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         )
//                     ),
//                     child: const Text(
//                       'Let\'s go',
//                       style: TextStyle(
//                         fontSize: 17,
//                         color: Colors.white,
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => HomeScreen()),
//                       );
//                     }, // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//                   ),
//                 )
//             ),
//           ],
//         ),
//     );
//   }
// }
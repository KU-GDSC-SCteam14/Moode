// import 'package:flutter/material.dart';
// import 'package:mind_care/screen/home_screen.dart';
//
// class CreateAccount extends StatefulWidget {
//   const CreateAccount({Key? key}) : super(key: key);
//
//   @override
//   State<CreateAccount> createState() => _CreateAccount();
//
// }
//
// class _CreateAccount extends State<CreateAccount>{
//   TextEditingController nameTextController = TextEditingController();
//   TextEditingController emailTextController = TextEditingController();
//   //WriteExperience({
//   //  required this.selectedDate,
// //
//   //});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: 70,
//           ),
//           Image.asset(
//             'asset/img/logo.png',
//             width: 86,
//             alignment: Alignment.center,
//           ),
//           Expanded(child: SingleChildScrollView(
//           child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               alignment: Alignment.centerLeft,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
//               child: Text('Your name',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(16, 0, 16, 9),
//               child: SizedBox(
//                 width: 358,
//                 height: 50,
//                 child:TextField(
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     labelText: 'Moodie',
//                     labelStyle: TextStyle(
//                       color: Colors.grey,
//                     ),
//                     floatingLabelBehavior: FloatingLabelBehavior.never,
//                   ),
//                         controller: nameTextController,
//                       ),
//                     ),
//                   ),
//             Container(
//               alignment: Alignment.centerLeft,
//               padding: const EdgeInsets.symmetric(horizontal: 16,),
//               child: Text('Email',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(16, 9, 16, 0),
//               child: SizedBox(
//                 width: 358,
//                 height: 50,
//                 child:TextField(
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     labelText: 'email@gmail.com',
//                     labelStyle: TextStyle(
//                       color: Colors.grey,
//                     ),
//                     floatingLabelBehavior: FloatingLabelBehavior.never,
//                   ),
//                   controller: emailTextController,
//                 ),
//               ),
//             ),
//         ],
//         ),
//     ),
//       ),
//       ElevatedButton(
//         style: ElevatedButton.styleFrom(
//             minimumSize: const Size.fromHeight(57),
//             backgroundColor: const Color.fromRGBO(0, 122, 255, 1.0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.zero,
//             )
//         ),
//         child: const Text(
//           '다음',
//           style: TextStyle(
//             fontSize: 17,
//             color: Colors.white,
//           ),
//         ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => WelcomePage(
//                     nameTextController.text
//                 ),
//             ),
//           );
//         }, // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       ),
//     ],
//     ),
//     );
//   }
// }
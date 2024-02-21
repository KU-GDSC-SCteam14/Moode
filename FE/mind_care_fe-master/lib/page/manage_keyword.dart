// import 'package:flutter/material.dart';
// import 'package:mind_care/component/search_keyword_pg1.dart';
// import 'package:mind_care/db.dart';
// //import 'performance.dart';
// import 'dart:convert';

// class CollectKeyword extends StatefulWidget {
//   const CollectKeyword({super.key});

//   @override
//   State<CollectKeyword> createState() => _CollectKeyword();
// }

// class _CollectKeyword extends State<CollectKeyword> {
//   Future<List<String>>? keywordsFuture;

//   //*******************keyword 삭제, 수정 필요

//   @override
//   void initState() {
//     super.initState();
//     keywordsFuture =
//         DatabaseService.getAllKeywords(); // 데이터베이스에서 모든 키워드를 불러옵니다.
//   }

//   void _deleteitem() {}

//   @override
//   Widget build(BuildContext context) {
//     const String title = 'Dismissing Items';

//     return MaterialApp(
//       home: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(42.0),
//           child: AppBar(
//             leading: IconButton(
//                 icon: const Icon(Icons.arrow_back), // 아이콘
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const SearchKeyword()),
//                   );
//                 }),
//             title: const Text(
//               '키워드 모아보기',
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             centerTitle: true,
//           ),
//         ),
//         // 리스트뷰를 생성
//         body: FutureBuilder<List<String>>(
//           future: keywordsFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (snapshot.hasData) {
//               final keywords = snapshot.data!;
//               return ListView.builder(
//                 itemCount: keywords.length,
//                 itemBuilder: (context, index) {
//                   final item = keywords[index];
//                   return Dismissible(
//                     /**
//                * Key 클래스는 위젯이나 앨리먼트 등을 식별할 때 사용한다.
//                * Dismissible은 반드시 유니크한 key 값을 가져야 한다.
//                * Key 생성자는 String값을 아규먼트로 받아서 고유한 키를 생성한다.
//                */
//                     key: Key(item),
//                     // Dismissible의 배경색 설정
//                     background: Container(
//                       color: Colors.blue,
//                     ), // Background for swipe right
//                     secondaryBackground: Container(
//                         color: Colors.red), // Background for swipe left
//                     onDismissed: (direction) {
//                       if (direction == DismissDirection.endToStart) {
//                         // Logic for swiping left
//                         //
//                         setState(() {
//                           // 삭제 기능
//                           // 로컬에서도 삭제 & 페이지에서도 삭제
//                         });
//                       } else if (direction == DismissDirection.startToEnd) {
//                         // Logic for swiping right
//                         // 수정 기능
//                         // 로컬에서도 수정 & 페이지에서도 수정
//                       }
//                     },
//                     // Dismissible의 자식으로 리스트타일을 생성. 리스튜뷰에 타일로 등록
//                     child: ListTile(title: Text(item)),
//                   );
//                 },
//               );
//             } else {
//               return const Center(child: Text('키워드가 없습니다.'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

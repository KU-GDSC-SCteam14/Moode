// import 'package:flutter/material.dart';

// // p.467 참고
// // footer_diary_list

// class DiaryCard extends StatelessWidget {
//   final String titleController;
//   final String experienceTextController;
//   final String Date;
//   final List<String> keywords;
//   final String moodName;

//   const DiaryCard({
//     required this.titleController,
//     required this.experienceTextController,
//     required this.Date,
//     required this.keywords,
//     // 이모티콘
//     required this.moodName,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//             width: 374,
//             //height: 169,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: const Color(0xfff8f8f8),
//             ),
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                     // 위
//                     child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     DiaryTop,
//                 Container(
//                   // 여백
//                   height: 18,
//                 ),
//                 DiaryBottom,
//             ],
//                     ),
//     );
//   }
// }

// class DiaryBottom extends StatelessWidget {
//   // 날짜
//   final String Date;
//   final List<String> keywords;

//   const DiaryBottom({
//     required this.Date,
//     required this.keywords,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(keywords[0]),
//         // child: Row(
//         //   children: [
//         //     Container(
//         //         child: Row(
//         //               children: [
//         //                 ListView.builder(
//         //                   itemCount: keywords.length,
//         //                   itemBuilder: (context, index) {
//         //                     return Container(
//         //                       // 로컬 keywords 쓰기
//         //                       decoration: BoxDecoration(
//         //                         borderRadius:
//         //                         BorderRadius.circular(100),
//         //                         color: const Color.fromRGBO(
//         //                             211, 212, 212, 1.0),
//         //                       ),
//         //                       child: Text(
//         //                         keywords[index],
//         //                         style: const TextStyle(
//         //                           fontSize: 14,
//         //                           color: Color.fromRGBO(
//         //                               0, 122, 255, 1.0),
//         //                         ),
//         //                       ),
//         //                     );
//         //                   },
//         //                 ),
//         //               ],
//         //             )
//         Container(
//             child: Text(
//           Date,
//           style: const TextStyle(
//             fontSize: 14,
//             color: Color(0xff86858A),
//           ),
//         )),
//       ],
//     );
//   }
// }

// Container(
//                   // 아래
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                           // 키워드
//                           child: Row(
//                         children: [
//                           Container(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 6, horizontal: 19),
//                               decoration: BoxDecoration(
//                                 color: const Color.fromRGBO(211, 212, 212, 1.0),
//                                 borderRadius: BorderRadius.circular(100),
//                               ),
//                               child: const Text(
//                                 '키워드',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Color.fromRGBO(0, 122, 255, 1.0),
//                                 ),
//                               )),
//                           Container(
//                             width: 8,
//                           ),
//                           Container(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 6, horizontal: 19),
//                               decoration: BoxDecoration(
//                                 color: const Color.fromRGBO(211, 212, 212, 1.0),
//                                 borderRadius: BorderRadius.circular(100),
//                               ),
//                               child: const Text(
//                                 '키워드',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Color.fromRGBO(0, 122, 255, 1.0),
//                                 ),
//                               )),
//                           Container(
//                             width: 8,
//                           ),
//                           Container(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 6, horizontal: 19),
//                               decoration: BoxDecoration(
//                                 color: const Color.fromRGBO(211, 212, 212, 1.0),
//                                 borderRadius: BorderRadius.circular(100),
//                               ),
//                               child: const Text(
//                                 '키워드',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Color.fromRGBO(0, 122, 255, 1.0),
//                                 ),
//                               )),
//                         ],
//                       )),
//                       Container(
//                           // 작성 시간
//                           child: const Text(
//                         '09:00',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Color.fromRGBO(136, 136, 136, 1.0),
//                         ),
//                       )),
//                     ],
//                   ),
//                 ),
//               ],
//             ))




// class DiaryTop extends StatelessWidget {
//   final String titleController;
//   final String experienceTextController;
//   // 이모티콘
//   final String moodName;

//   const DiaryTop({
//     required this.titleController,
//     required this.experienceTextController,
//     // 이모티콘
//     required this.moodName,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: 334,
//         height: 64,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // 글(제목, 날짜)
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // 제목
//                 Container(
//                   width: 250,
//                   height: 26,
//                   child: Text(titleController),
//                 ),
//                 // 여백
//                 SizedBox(
//                   height: 14,
//                 ),
//                 // 날짜
//               ],
//             ),

//             // 감정 이모티콘
//             // Container(
//             //   child: Image.asset(
//             //     'asset/img/logo.png',
//             //     width: 50,
//             //   ),
//             // ),
//             // 감정 이름
//             Container(
//                 child: Text(moodName,
//                     style: TextStyle(
//                       fontSize: 18,
//                     ))),
//           ],
//         ));
//   }
// }

// Container(
//                         // title
//                         child: const Text(
//                       '감정일기의 제목',
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromRGBO(83, 83, 84, 1.0),
//                       ),
//                     )),
//                     Container(
//                       // 여백
//                       height: 14,
//                     ),
//                     Container(
//                         // substring 메서드 사용하기
//                         child: const Text(
//                       '감정일기의 본문이 보이는 곳입니다. 사용자가 작성한 텍스트만 보여주어야 합니다. 최대 두 줄 까지..',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Color.fromRGBO(136, 136, 136, 1.0),
//                       ),
//                     )),
//                     Container(// 감정 아이콘

//                         ),
//                   ],
//                 )),
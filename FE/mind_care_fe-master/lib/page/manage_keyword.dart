import 'package:flutter/material.dart';
import 'package:mind_care/component/search_keyword_pg1.dart';
import 'package:mind_care/db.dart';
//import 'performance.dart';
import 'dart:convert';

class ManageKeyword extends StatefulWidget {
  const ManageKeyword({super.key});

  @override
  State<ManageKeyword> createState() => _ManageKeyword();
}

class _ManageKeyword extends State<ManageKeyword> {
  Future<List<String>>? keywordsFuture;
  final keywordController = TextEditingController();
  String change_keyword = "";

  @override
  void initState() {
    super.initState();
    keywordsFuture =
        DatabaseService.getAllKeywords(); // 데이터베이스에서 모든 키워드를 불러옵니다.
  }

  void _deleteitem() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(42.0),
          child: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back), // 아이콘
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchKeyword()),
                  );
                }),
            title: const Text(
              '키워드 모아보기',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
        ),

        // 리스트뷰를 생성
        body: FutureBuilder<List<String>>(
          future: keywordsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final keywordsFuture = snapshot.data!;
              return ListView.builder(
                itemCount: keywordsFuture.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    /**
               * Key 클래스는 위젯이나 앨리먼트 등을 식별할 때 사용한다.
               * Dismissible은 반드시 유니크한 key 값을 가져야 한다.
               * Key 생성자는 String값을 아규먼트로 받아서 고유한 키를 생성한다.
               */
                    key: Key(keywordsFuture[index]),
                    // Dismissible의 배경색 설정
                    background: Container(
                      child: Text('수정'),
                      color: Colors.blue,
                    ), // Background for swipe right
                    secondaryBackground: Container(
                        child: Text('삭제'),
                        color: Colors.red), // Background for swipe left
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        // 삭제 기능
                        // 로컬에서도 삭제 & 페이지에서도 삭제
                        setState(() {
                          keywordsFuture.removeAt(index);
                        });
                        DatabaseService.deleteKeywordAndReferences(
                            keywordsFuture[index]);
                      }
                    },
                    // Dismissible의 자식으로 리스트타일을 생성. 리스튜뷰에 타일로 등록
                    child: ListTile(
                      title: Text(keywordsFuture[index]),
                      // 탭하면 수정 모달 실행, 화면에 반영, 로컬에도 반영
                      onTap: () {
                        // 수정 모달
                        changeDialog(keywordsFuture[index]);
                        // 로컬 반영
                        DatabaseService.updateKeyword(
                            keywordsFuture[index], change_keyword);
                        // 즉시 반영
                        setState(() {
                          keywordsFuture[index] = change_keyword;
                        });
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('키워드가 없습니다.'));
            }
          },
        ),
      ),
    );
  }

  void changeDialog(String oldKeyword) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                new Text("키워드 수정하기"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: keywordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: oldKeyword,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text("확인"),
                onPressed: () {
                  change_keyword = keywordController.text;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

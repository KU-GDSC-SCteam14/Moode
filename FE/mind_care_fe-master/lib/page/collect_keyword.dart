import 'package:flutter/material.dart';
import 'package:mind_care/component/search_keyword_pg1.dart';

class CollectKeyword extends StatefulWidget {
  const CollectKeyword({super.key});

  @override
  State<CollectKeyword> createState() => _CollectKeyword();
}

class _CollectKeyword extends State<CollectKeyword> {
  //*********************** keywords 리스트 받아와야 합니다 !!! ******************

  //*******************keyword 삭제, 수정 필요

  // 30개의 스트링 타입의 아이템을 가지는 리스트 생성
  final items = List<String>.generate(30, (i) => "Item ${i + 1}");

  void _deleteitem() {}

  @override
  Widget build(BuildContext context) {
    const String title = 'Dismissing Items';

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
                    MaterialPageRoute(builder: (context) => const SearchKeyword()),
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
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            // 리스트의 index번째의 앨리먼트를 item으로 할당
            final item = items[index];

            return Dismissible(
              /**
               * Key 클래스는 위젯이나 앨리먼트 등을 식별할 때 사용한다.
               * Dismissible은 반드시 유니크한 key 값을 가져야 한다.
               * Key 생성자는 String값을 아규먼트로 받아서 고유한 키를 생성한다.
               */
              key: Key(item),
              // Dismissible의 배경색 설정
              background: Container(
                color: Colors.blue,
              ), // Background for swipe right
              secondaryBackground:
                  Container(color: Colors.red), // Background for swipe left
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  // Logic for swiping left
                  setState(() {
                    //
                  });
                } else if (direction == DismissDirection.startToEnd) {
                  // Logic for swiping right
                }
              },
              // Dismissible의 자식으로 리스트타일을 생성. 리스튜뷰에 타일로 등록
              child: ListTile(title: Text(item)),
            );
          },
        ),
      ),
    );
  }
}

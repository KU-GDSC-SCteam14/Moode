import 'package:flutter/material.dart';
import 'package:mind_care/page/write_diary_pg6.dart';

class WriteThink extends StatelessWidget{
  final thinkTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            42.0),
        child: AppBar(
          title: Text('작성하기',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SingleChildScrollView(
              child: Column(children: [
                LinearProgressIndicator(
                  value: 0.9,
                  backgroundColor: Colors.white,
                  color: Colors.white,
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromRGBO(0, 122, 255, 1.0)),
                  minHeight: 2.0,
                  semanticsLabel: 'semanticsLabel',
                  semanticsValue: 'semanticsValue',
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Text('나에게 해주고 싶은 말을 자유롭게 적어주세요.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: SizedBox(
                    width: 390,
                    child:TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'ex) 나는 왜 이런 방식으로 말했을까?\n      나에게 도움이 되는 선택이었나?',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      controller: thinkTextController,
                      maxLines: null, // <-- SEE HERE
                      minLines: 5, // <-- SEE HERE
                      maxLength: 1000,
                    ),
                  ),
                ),
              ],)
          ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(57),
                backgroundColor: const Color.fromRGBO(0, 122, 255, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                )
            ),
            child: const Text(
              '다음',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Result()),
              );
            }, // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
        ],
      ),

    );
  }
}
import 'package:flutter/material.dart';
import 'package:mind_care/page/write_diary_pg3.dart';


class LLM_1 extends StatelessWidget{

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
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: 0.3,
                  backgroundColor: Colors.white,
                  color: Colors.white,
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromRGBO(0, 122, 255, 1.0)),
                  minHeight: 2.0,
                  semanticsLabel: 'semanticsLabel',
                  semanticsValue: 'semanticsValue',
                ),
                Center(
                  child: Container(
                    width: 262,
                    height: 580,
                    alignment: Alignment.center,
                    child: Text('가족과 함께하려고 계획한\n산책과 휴식이 갑작스러운\n날씨 변화로 물거품이 되다니,\n\n그동안 많이 기대하셨을 텐데\n 너무 안타까운 일이에요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),),
          Align(
            alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 358,
                height: 57,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 122, 255, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
                          builder: (context) => WriteEmotion()),
                    );
                  }, // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                ),
              )
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mind_care/screen/home_screen.dart';
import 'package:mind_care/page/write_diary_pg2.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/src/material/progress_indicator.dart';

class WriteExperience extends StatefulWidget {
  const WriteExperience({Key? key}) : super(key: key);


  @override
  State<WriteExperience> createState() => _WriteExperienceSate();

}

class _WriteExperienceSate extends State<WriteExperience>{
  //final DateTime selectedDate = null;
  final experienceTextController = TextEditingController();


  //WriteExperience({
  //  required this.selectedDate,
//
  //});
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            42.0),
        child: AppBar(
          leading: IconButton(
              onPressed: () {
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                        //padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(
                        color: Colors.black, width: 1.0,
                      ))),
                      //width: 302,
                      height: 134.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            //padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                            child: Text('일기 작성을 취소할까요?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),),
                          ),
                          Container(
                            //padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                            child: Text('작성 중인 일기 내용은 저장되지 않아요.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                fontSize: 13,
                              ),),
                          ),
                        ],
                      )
                    ),
                    backgroundColor: Color.fromRGBO(211,211,211,1.0),
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    actions: <Widget>[
                      Container(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // 가운데 정렬
                          children: [
                            TextButton(

                              onPressed:() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                      )),
                                );
                              },
                              child: const Text('닫기',
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 122, 255, 1.0),
                                  fontSize: 17,
                                ),),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isCompleted == true
                                      ? isCompleted = false
                                      : isCompleted = true;
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('취소',
                                style: TextStyle(
                                  color: Color.fromRGBO(209, 11, 11, 1.0),
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  );
                });
              },
              icon: Icon(Icons.arrow_back),
        ),
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
                value: 0.3,
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
                child: Text('오늘 어떤 일이 있었나요?',
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
                    controller: experienceTextController,
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
                    builder: (context) => LLM_1()),
              );
              }, // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
//import 'package:mind_care/page/show_selectedfromsearch_diary.dart';
import 'package:mind_care/page/manage_keyword.dart';
import 'package:mind_care/screen/home_screen.dart';
import 'package:mind_care/component/search_keyword_pg2.dart';
import 'package:mind_care/db.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:mind_care/component/show_diary.dart';

String searchText = '';
Map<String, int> keywordUsageCount = {};
List<String> recentSearches = [];

// *******keywords 리스트 불러와주세요 ****************
List<String> keywords = [];

class SearchKeyword extends StatefulWidget {
  const SearchKeyword({super.key});

  @override
  _SearchKeyword createState() => _SearchKeyword();
}

// 메인 클래스의 상태 상속
class _SearchKeyword extends State<SearchKeyword> {
  @override
  void initState() {
    super.initState();
    _loadAllKeywords();
    _loadRecentSearches();
  }

  Future<void> _loadAllKeywords() async {
    List<String> loadedKeywords = await DatabaseService.getAllKeywords();
    Map<String, int> localKeywordUsageCount = {};
    for (var keyword in loadedKeywords) {
      List<int> ids = await DatabaseService.getDiaryIdsByKeyword(keyword);
      localKeywordUsageCount[keyword] = ids.length;
    }
    // Sort keywords alphabetically
    loadedKeywords.sort((a, b) => compareNatural(a, b));
    setState(() {
      keywords = loadedKeywords;
      keywordUsageCount = localKeywordUsageCount;
    });
  }

  // 키워드 누르면
  void cardClickEvent(BuildContext context, String keyword) async {
    await _saveRecentSearch(keyword);
    Navigator.push(
      context,
      MaterialPageRoute(
        // 정의한 ContentPage의 폼 호출
        builder: (context) => ResultKeyword(
          // keyword 넘겨주기
          find_keyword: keyword,
        ),
      ),
    );
  }

  // 가장 많이 사용된 키워드 위젯을 만드는 메서드
  Widget _buildTopKeywords(BuildContext context, List<String> topKeywords) {
    return Padding(
        padding: const EdgeInsets.only(
            right: 18.0), // Padding for the entire Wrap widget
        child: Wrap(
          spacing: 8.0, // 가로 간격
          runSpacing: 4.0, // 세로 간격
          children: topKeywords.map((keyword) {
            return GestureDetector(
              onTap: () => cardClickEvent(context, keyword),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                margin: const EdgeInsets.only(bottom: 8), // 하단 여백 추가
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromRGBO(225, 226, 226, 0.8),
                ),
                child: Text(
                  keyword.length > 30
                      ? keyword.substring(0, 30) + '...'
                      : keyword,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff007AFF),
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }

  // 최근 사용된 키워드 위젯을 만드는 메서드
  Widget _recentKeywords(BuildContext context, List<String> RecentKeywords) {
    if (RecentKeywords.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 1, left: 3.0),
        child: Text(
          '검색한 키워드가 없어요 ...',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.only(
              right: 18.0), // Padding for the entire Wrap widget
          child: Wrap(
            spacing: 8.0, // 가로 간격
            runSpacing: 4.0, // 세로 간격
            children: recentSearches.map((keyword) {
              return GestureDetector(
                onTap: () => cardClickEvent(context, keyword),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 19),
                  margin: const EdgeInsets.only(bottom: 8), // 하단 여백 추가
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromRGBO(225, 226, 226, 0.8),
                  ),
                  child: Text(
                    keyword.length > 30
                        ? keyword.substring(0, 30) + '...'
                        : keyword,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff007AFF),
                    ),
                  ),
                ),
              );
            }).toList(),
          ));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Clear the search text when coming back to this screen
    if (searchText.isNotEmpty) {
      setState(() {
        searchText = '';
      });
    }
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  }

  Future<void> _clearRecentSearches() async {
    bool confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            buttonPadding: EdgeInsets.all(0),
            insetPadding: EdgeInsets.all(60),
            contentPadding: EdgeInsets.all(0),
            iconPadding: EdgeInsets.zero,
            // titlePadding: EdgeInsets.zero,
            title: Column(
              children: <Widget>[
                Text(
                  '검색 기록을 전부 지우시겠어요?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),

            content: Container(
              // 여기서 대화상자의 내부 크기를 조정합니다.
              width: double.maxFinite,
              height: 63,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 40.0),
                          ),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setStringList('recentSearches', []);
                            setState(() {
                              recentSearches = [];
                            });
                          },
                          child: const Text(
                            '지우기',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color.fromRGBO(209, 11, 11, 1.0),
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 55.0, // 선의 높이
                          color: Colors.grey, // 선의 색상
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 50.0),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text(
                            '취소',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color.fromRGBO(0, 122, 255, 1.0),
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ])
                ],
              ),
            ),
            backgroundColor: Color.fromARGB(255, 233, 234, 228),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            actionsPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          );
        });
  }

  Future<void> _saveRecentSearch(String keyword) async {
    final prefs = await SharedPreferences.getInstance();
    // 새로운 검색어를 기존 목록에 추가합니다.
    final updatedSearches = [keyword, ...recentSearches]
        .toSet() // 중복 제거
        .toList(); // 다시 리스트로 변환
    if (updatedSearches.length > 8) {
      updatedSearches.removeRange(8, updatedSearches.length); // 8개만 유지
    }
    await prefs.setStringList('recentSearches', updatedSearches);
    setState(() {
      recentSearches = updatedSearches;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sort keywords based on their usage count
    List<String> sortedKeywords = keywords;
    sortedKeywords
        .sort((a, b) => keywordUsageCount[b]!.compareTo(keywordUsageCount[a]!));

    // Only take top 8 most used keywords
    List<String> topKeywords = sortedKeywords.take(8).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42.0),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back), // 아이콘
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }),
          title: const Text(
            '검색',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ManageKeyword()),
                  );
                }, // floating
                child: const Text('관리'))
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 29,
          ),

          // Expanded(
          //     child: SingleChildScrollView(
          //         child: Column(children: [

          Container(
            height: 42,
            margin: const EdgeInsets.fromLTRB(16, 3, 16, 3),
            //padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
            child: TextField(
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 6.5),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromRGBO(60, 60, 67, 0.6),
                ),
                suffixIcon: const Icon(
                  Icons.mic,
                  color: Color.fromRGBO(60, 60, 67, 0.6),
                ),
                fillColor: const Color.fromRGBO(118, 118, 128, 0.12),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: '검색어를 입력해주세요.',
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Color(0xffA19FA1)),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Container(
            height: 29,
          ),
          // 키워드 리스트 보여주기
          searchText.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    // items 변수에 저장되어 있는 모든 값 출력
                    itemCount: keywords.length,
                    itemBuilder: (BuildContext context, int index) {
                      // 검색 기능, 검색어가 있을 경우
                      if (searchText.isNotEmpty &&
                          !keywords[index]
                              .toLowerCase()
                              .contains(searchText.toLowerCase())) {
                        return const SizedBox.shrink();
                      }
                      // 검색어가 없을 경우, 모든 항목 표시
                      else {
                        return GestureDetector(
                          //alignment: Align.
                          onTap: () => cardClickEvent(context, keywords[index]),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 16,
                                height: 37,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 19),
                                    height: 29,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color.fromRGBO(
                                          225, 226, 226, 0.8),
                                    ),
                                    child: Text(
                                      keywords[index].length > 30
                                          ? keywords[index].substring(0, 30) +
                                              '...'
                                          : keywords[index],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff007AFF),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    //width: 16,
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                )
              : SizedBox.shrink(),
          searchText.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '최근 검색한 키워드',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: _clearRecentSearches,
                            tooltip: '검색 기록 지우기',
                            iconSize: 20,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 14.0), // 왼쪽으로 이동시킬 너비
                        Expanded(
                          child: _recentKeywords(context, recentSearches),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                )
              : SizedBox.shrink(),
          searchText.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 15),
                      child: Text(
                        '가장 많이 작성된 키워드',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 14.0), // 왼쪽으로 이동시킬 너비
                        Expanded(
                          child: _buildTopKeywords(context, topKeywords),
                        ),
                      ],
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

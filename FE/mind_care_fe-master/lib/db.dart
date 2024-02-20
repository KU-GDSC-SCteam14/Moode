import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  static Future<void> insertUser(Map<String, dynamic> userData) async {
    final db = await database;

    // SQLite 데이터베이스에 유저 데이터 삽입
    await db.insert('User', userData,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<Database> get database async {
    if (_database != null) return _database!;

    // 데이터베이스 경로 설정
    String path = join(await getDatabasesPath(), 'local.db');
    // String path = join(await getDatabasesPath(), 'moode_localDB.db');

    // 데이터베이스 열기 또는 생성
    _database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      // 테이블 생성
      await db.execute('''
        CREATE TABLE User (
          User_ID INTEGER PRIMARY KEY,
          Name TEXT NOT NULL,
          email TEXT NOT NULL,
          Signup_date TEXT NOT NULL,
          is_Google INTEGER NOT NULL,
          is_Apple INTEGER NOT NULL,
          Provider_ID TEXT NOT NULL,
          Access_Token TEXT NOT NULL,
          Refresh_Token TEXT NOT NULL,
          Token_Expiry_Date TEXT NOT NULL,
          Profile_Picture_URL TEXT
        );
      ''');

      await db.execute('''
        CREATE TABLE Mood (
          Mood_ID INTEGER PRIMARY KEY,
          Mood_name TEXT NOT NULL,
          Mood_value_min REAL NOT NULL,
          Mood_value_max REAL NOT NULL
        );
      ''');

      await db.execute('''
        CREATE TABLE Diary (
          Diary_ID INTEGER PRIMARY KEY AUTOINCREMENT,
          User_ID INTEGER NOT NULL,
          Title TEXT NOT NULL,
          Content_1 TEXT NOT NULL,
          Content_2 TEXT NOT NULL,
          Content_3 TEXT NOT NULL,
          Content_4 TEXT NOT NULL,
          Date TEXT NOT NULL,
          Mood_ID INTEGER,
          FOREIGN KEY (User_ID) REFERENCES User(User_ID),
          FOREIGN KEY (Mood_ID) REFERENCES Mood(Mood_ID)
        );
      ''');

      await db.execute('''
        CREATE TABLE Keyword (
          Keyword_ID INTEGER PRIMARY KEY AUTOINCREMENT,
          keyword TEXT NOT NULL
        );
      ''');

      await db.execute('''
        CREATE TABLE DiaryKeyword (
          Diary_Keyword_ID INTEGER PRIMARY KEY AUTOINCREMENT,
          Diary_ID INTEGER NOT NULL,
          Keyword_ID INTEGER NOT NULL,
          FOREIGN KEY (Diary_ID) REFERENCES Diary(Diary_ID),
          FOREIGN KEY (Keyword_ID) REFERENCES Keyword(Keyword_ID)
        );
      ''');

      await db.execute('''
        INSERT INTO Mood (Mood_ID, Mood_name, Mood_value_min, Mood_value_max) VALUES (1, 'very happy', 0.0, 0.0);
      ''');
      await db.execute('''
        INSERT INTO Mood (Mood_ID, Mood_name, Mood_value_min, Mood_value_max) VALUES (2, 'happy', 0.0, 0.0);
      ''');
      await db.execute('''
        INSERT INTO Mood (Mood_ID, Mood_name, Mood_value_min, Mood_value_max) VALUES (3, 'sad', 0.0, 0.0);
      ''');
      await db.execute('''
        INSERT INTO Mood (Mood_ID, Mood_name, Mood_value_min, Mood_value_max) VALUES (4, 'very sad', 0.0, 0.0);
      ''');
    });
    return _database!;
  }

  // 다이어리 삽입 메서드 (삽입된 일기의 ID 반환)
  static Future<int> insertDiary(Map<String, dynamic> diary) async {
    final db = await database;
    int id = await db.insert('Diary', diary,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id; // 삽입된 일기의 ID 반환
  }

  // 다이어리 업데이트 메서드
  static Future<void> updateDiary(
      int diaryId, Map<String, dynamic> diaryData) async {
    final db = await database;
    await db.update(
      'Diary',
      diaryData,
      where: 'Diary_ID = ?',
      whereArgs: [diaryId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 다이어리 조회 메서드
  static Future<List<Map<String, dynamic>>> getDiaries() async {
    final db = await database;
    return db.query('Diary');
  }

  // 키워드 검색 및 저장 로직
  static Future<int> getOrInsertKeyword(String keyword) async {
    final db = await database;
    // 키워드 검색
    final List<Map<String, dynamic>> maps = await db.query(
      'Keyword',
      where: 'keyword = ?',
      whereArgs: [keyword],
    );

    if (maps.isNotEmpty) {
      // 키워드가 존재하는 경우, Keyword_ID 반환
      return maps.first['Keyword_ID'];
    } else {
      // 새로운 키워드 저장
      int id = await db.insert(
        'Keyword',
        {'keyword': keyword},
      );
      // 저장된 키워드의 Keyword_ID 반환
      return id;
    }
  }

  // 키워드 리스트를 받아 각 키워드의 Keyword_ID를 리스트로 반환하는 함수
  static Future<List<int>> getKeywordIds(List<String> keywords) async {
    List<int> keywordIds = [];
    for (String keyword in keywords) {
      int id = await getOrInsertKeyword(keyword);
      keywordIds.add(id);
    }
    return keywordIds;
  }

  // DiaryKeyword 테이블에 데이터 삽입
  static Future<void> insertDiaryKeywords(
      int diaryId, List<int> keywordIds) async {
    final db = await database;
    for (int keywordId in keywordIds) {
      await db.insert(
        'DiaryKeyword',
        {
          'Diary_ID': diaryId,
          'Keyword_ID': keywordId,
        },
      );
    }
  }

  // 테이블 내용을 콘솔에 출력하는 메서드
  static Future<void> printTableContents(String tableName) async {
    final db = await database; // 데이터베이스 인스턴스를 가져옵니다.
    List<Map<String, dynamic>> results =
        await db.query(tableName); // 테이블의 모든 데이터를 조회합니다.

    print("Contents of the $tableName table:");
    for (var row in results) {
      print(row); // 각 행을 콘솔에 출력합니다.
    }
  }

  // 특정 날짜의 일기 ID들을 리스트로 반환하는 함수
  static Future<List<int>> getDiariesByDate(String date) async {
    final db = await database;
    // 입력받은 날짜와 일치하는 모든 일기 조회
    final List<Map<String, dynamic>> result = await db.query(
      'Diary',
      columns: ['Diary_ID'], // 조회할 컬럼
      where: 'Date LIKE ?', // 날짜가 일치하는 조건
      whereArgs: ['$date%'], // 날짜 입력. LIKE 연산자 사용 시 '%'는 와일드카드로 사용됩니다.
    );

    // 조회 결과에서 일기 ID들을 추출하여 리스트로 반환
    List<int> diaryIds = result.map((row) => row['Diary_ID'] as int).toList();
    return diaryIds;
  }

  // 일기 ID를 기준으로 일기 세부 정보 조회
  static Future<Map<String, dynamic>?> getDiaryDetailsById(int diaryId) async {
    final db = await database;
    // Diary, Mood, 그리고 Keyword 테이블을 조인하여 필요한 정보를 조회하는 쿼리 실행
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT 
        Diary.Title, 
        Diary.Content_1,
        Diary.Content_2,
        Diary.Content_3, 
        Diary.Content_4,
        Diary.Date, 
        Mood.Mood_name,
        GROUP_CONCAT(Keyword.keyword) AS Keywords
      FROM Diary
      LEFT JOIN Mood ON Diary.Mood_ID = Mood.Mood_ID
      LEFT JOIN DiaryKeyword ON Diary.Diary_ID = DiaryKeyword.Diary_ID
      LEFT JOIN Keyword ON DiaryKeyword.Keyword_ID = Keyword.Keyword_ID
      WHERE Diary.Diary_ID = ?
      GROUP BY Diary.Diary_ID
    ''', [diaryId]);

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  // Method to find Mood_ID by mood name
  static Future<int?> getMoodIdByName(String moodName) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'Mood',
      where: 'Mood_name = ?',
      whereArgs: [moodName],
    );

    if (result.isNotEmpty) {
      return result.first['Mood_ID'] as int;
    }
    return null; // Return null if the mood name was not found
  }

  // 모든 고유 키워드를 리스트로 반환하는 메서드
  static Future<List<String>> getAllKeywords() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query('Keyword', orderBy: 'keyword ASC'); // 키워드를 알파벳 순으로 정렬

    // 결과에서 키워드만 추출하여 리스트로 변환
    List<String> keywords = results.map((row) => row['keyword'] as String).toList();
    return keywords;
  }

  // 주어진 키워드를 포함하는 모든 일기의 ID를 리스트로 반환하는 메서드
  static Future<List<int>> getDiaryIdsByKeyword(String keyword) async {
    final db = await database;
    // 먼저 키워드 ID를 찾습니다.
    final List<Map<String, dynamic>> keywordResult = await db.query(
      'Keyword',
      where: 'keyword = ?',
      whereArgs: [keyword],
    );

    if (keywordResult.isEmpty) {
      return []; // 키워드가 존재하지 않으면 빈 리스트를 반환
    }

    final keywordId = keywordResult.first['Keyword_ID'];

    // 해당 키워드 ID를 가진 모든 일기의 ID를 찾습니다.
    final List<Map<String, dynamic>> diaryKeywordResult = await db.query(
      'DiaryKeyword',
      where: 'Keyword_ID = ?',
      whereArgs: [keywordId],
    );

    // 결과에서 일기 ID만 추출하여 리스트로 변환
    List<int> diaryIds = diaryKeywordResult.map((row) => row['Diary_ID'] as int).toList();
    return diaryIds;
  }

  // 주어진 키워드를 삭제하는 메서드
  static Future<void> deleteKeywordAndReferences(String keyword) async {
    final db = await database;
    // 먼저 키워드 ID를 찾습니다.
    final List<Map<String, dynamic>> keywordResult = await db.query(
      'Keyword',
      where: 'keyword = ?',
      whereArgs: [keyword],
    );

    if (keywordResult.isNotEmpty) {
      final keywordId = keywordResult.first['Keyword_ID'] as int;

      // 해당 키워드 ID를 가진 모든 DiaryKeyword 데이터를 삭제합니다.
      await db.delete(
        'DiaryKeyword',
        where: 'Keyword_ID = ?',
        whereArgs: [keywordId],
      );

      // 마지막으로 Keyword 테이블에서 키워드 자체를 삭제합니다.
      await db.delete(
        'Keyword',
        where: 'Keyword_ID = ?',
        whereArgs: [keywordId],
      );
    }
  }

  // 키워드 수정 메서드
  static Future<void> updateKeyword(String oldKeyword, String newKeyword) async {
    final db = await database;
    // 먼저 oldKeyword의 Keyword_ID를 찾습니다.
    final List<Map<String, dynamic>> oldKeywordResult = await db.query(
      'Keyword',
      where: 'keyword = ?',
      whereArgs: [oldKeyword],
    );

    if (oldKeywordResult.isEmpty) {
      // oldKeyword가 존재하지 않으면 종료
      return;
    }
    final oldKeywordId = oldKeywordResult.first['Keyword_ID'] as int;

    // newKeyword가 Keyword 테이블에 이미 존재하는지 확인합니다.
    final List<Map<String, dynamic>> newKeywordResult = await db.query(
      'Keyword',
      where: 'keyword = ?',
      whereArgs: [newKeyword],
    );

    if (newKeywordResult.isNotEmpty) {
      // newKeyword가 이미 존재하면, 해당 Keyword_ID로 DiaryKeyword 테이블을 업데이트
      final newKeywordId = newKeywordResult.first['Keyword_ID'] as int;
      await db.update(
        'DiaryKeyword',
        {'Keyword_ID': newKeywordId},
        where: 'Keyword_ID = ?',
        whereArgs: [oldKeywordId],
      );

      // oldKeyword를 Keyword 테이블에서 삭제
      await db.delete(
        'Keyword',
        where: 'Keyword_ID = ?',
        whereArgs: [oldKeywordId],
      );
    } else {
      // newKeyword가 존재하지 않으면, oldKeyword를 newKeyword로 업데이트
      await db.update(
        'Keyword',
        {'keyword': newKeyword},
        where: 'Keyword_ID = ?',
        whereArgs: [oldKeywordId],
      );
    }
  }

    // 키워드 추가 메서드
  static Future<void> addKeyword(String keyword, int diaryId) async {
    final db = await database;
    // 키워드가 Keyword 테이블에 이미 존재하는지 확인합니다.
    final List<Map<String, dynamic>> keywordResult = await db.query(
      'Keyword',
      where: 'keyword = ?',
      whereArgs: [keyword],
    );

    int keywordId;

    if (keywordResult.isNotEmpty) {
      // 키워드가 이미 존재하면, 해당 Keyword_ID를 사용
      keywordId = keywordResult.first['Keyword_ID'] as int;
    } else {
      // 새로운 키워드라면, Keyword 테이블에 추가하고 Keyword_ID를 받아옵니다.
      keywordId = await db.insert(
        'Keyword',
        {'keyword': keyword},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // DiaryKeyword 테이블에 연결합니다.
    await db.insert(
      'DiaryKeyword',
      {
        'Diary_ID': diaryId,
        'Keyword_ID': keywordId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Method to get diaries by date with Mood_ID 1 or 2
  static Future<List<int>> getDiariesByDateAndMood(String dateString) async {
    final db = await database;

    // Query to select diaries that match the date and have a Mood_ID of 1 or 2
    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT Diary_ID
      FROM Diary
      WHERE Date LIKE ?
      AND (Mood_ID = 1 OR Mood_ID = 2)
    ''', ['$dateString%']);
    
    // Extracting and returning the diary IDs from the query results
    return results.map((row) => row['Diary_ID'] as int).toList();
  }

  // 여기에 추가 할거에요!!
}

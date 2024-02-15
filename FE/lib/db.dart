// 임시 DB 페이지
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    // 데이터베이스 경로 설정
    String path = join(await getDatabasesPath(), 'mydatabase.db');
    // 데이터베이스 열기 또는 생성
    _database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      // 테이블 생성
      await db.execute('''
        CREATE TABLE User (
          User_ID INTEGER PRIMARY KEY AUTOINCREMENT,
          Name TEXT NOT NULL,
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
          Mood_ID INTEGER PRIMARY KEY AUTOINCREMENT,
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
    });
    return _database!;
  }

  /*
  // 데이터 삽입 메서드
  static Future<void> insertDiary(Map<String, dynamic> diary) async {
    final db = await database;
    await db.insert('Diary', Diary,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  
  Future<void> addDiary() async {                               // 데이터베이스 서비스 클래스에 insertDiary 메서드를 호출하여 일기 데이터 삽입
    Map<String, dynamic> diaryData = {                          // 삽입할 일기 데이터를 Map 형태로 준비
      'Title': '일기1',
      'Content_1': '내용123',
    };
    await DatabaseService.insertDiary(diaryData);                // insertDiary 메서드를 호출하여 데이터베이스에 데이터 삽입
  }


  // 데이터 조회 메서드
  static Future<List<Map<String, dynamic>>> getDiaries() async {
    final db = await database;
    return db.query('Diary');
  }
  */
}

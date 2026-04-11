import 'package:flutter_book_reader/models/book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DataBaseHelper {
  static final String _databaseName = "book_database.db";
  static final int _databaseVersion = 1;
  static final String tableName = 'books';

  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database? _dataBase;

  Future<Database> get database async {
    _dataBase ??= await _initDatabase();

    return _dataBase!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _oncreate,
    );
  }

  Future _oncreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    author TEXT,
    cover_id INTEGER UNIQUE,
    description TEXT,
    publish_year INTEGER,
    is_favorite INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
''');
  }

  //insert books
  Future<int?> inserBook(Docs docs) async {
    var db = await instance.database;
    return await db.insert(tableName, docs.toJson());
  }

  //read books

  Future<List<Docs>> getAllBooks() async {
    var db = await instance.database;
    var result = await db.query(tableName);

    return result.isNotEmpty
        ? result
              .map((book) => Docs.fromJson(book as Map<String, dynamic>))
              .toList()
        : [];
  }
}

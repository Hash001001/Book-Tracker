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
        id                   INTEGER PRIMARY KEY AUTOINCREMENT,
        title                TEXT NOT NULL,
        author_name         TEXT,
        author_key          TEXT,
        cover_edition_key    TEXT,
        cover_i              INTEGER DEFAULT 0,
        ebook_access         TEXT,
        edition_count        INTEGER DEFAULT 0,
        first_publish_year   INTEGER DEFAULT 0,
        has_fulltext         INTEGER DEFAULT 0,
        lending_edition_s    TEXT,
        lending_identifier_s TEXT,
        public_scan_b        INTEGER DEFAULT 0,
        language            TEXT,
        ia                   TEXT,
        ia_collection        TEXT,
        id_standard_ebooks   TEXT,
        key   TEXT,
        is_favorite          INTEGER DEFAULT 0,
        created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
''');
  }

  //insert books
  Future<int> inserBook(Docs docs) async {
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

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../hive_add_update_page/hive_model.dart';
import 'database_model.dart';

class DBHelper {
  static Database? _database;
  static const String _tableName = "users";

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "users.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            image TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insertUser(DetailModel user) async {
    final db = await database;
    return await db.insert(_tableName, user.toMap());
  }

  static Future<List<DetailModel>> getUsers() async {
    final db = await database;
    final res = await db.query(_tableName);
    return res.map((e) => DetailModel.fromMap(e)).toList();
  }

  static Future<int> updateUser(DetailModel user) async {
    final db = await database;
    return await db.update(_tableName, user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}

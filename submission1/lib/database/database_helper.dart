import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:submission1/model/favorite.dart';

class DatabaseHelper {
  static late Database _db;
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _db = await _initializedDb();
    return _db;
  }

  final String _tableName = 'favorite';

  Future<Database> _initializedDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'favorite_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id TEXT PRIMARY KEY,
               name TEXT,
               description TEXT,
               pictureId TEXT ,
               city TEXT,
               rating INTEGER
             )''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertNote(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toMap());
  }

  Future<List<Restaurant>> getNotes() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => Restaurant.fromMap(res)).toList();
  }

  // Future<List<Restaurant>> getNoteByName(String name) async {
  //   final Database db = await database;
  //   List<Map<String, dynamic>> results = await db
  //       .rawQuery("SELECT * FROM $_tableName WHERE name LIKE '%$name%'");

  //   return results.map((res) => Restaurant.fromMap(res));
  // }

  Future<void> updateRestaurant(Restaurant restaurant) async {
    final db = await database;

    await db.update(
      _tableName,
      restaurant.toMap(),
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
  }

  Future<void> deleteRestaurant(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

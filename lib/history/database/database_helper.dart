import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:telemetry/history/model/history_db_model.dart';

class DatabaseHelper {
  static const _databaseName = "history.db";
  static const _databaseVersion = 1;
  static const table = "history";
  static const columnId = 'historyId';
  static const columnStationId = 'statonId';
  static const columnAssetId = 'assetId';
  static const columnTitle = 'title';
  static const columnbody = 'body';
  static const columnFile = 'file';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''  CREATE TABLE $table (    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,    $columnStationId INTEGER NOT NULL, $columnAssetId INTEGER NULL, $columnTitle FLOAT NOT NULL , $columnbody FLOAT NULL, $columnFile FLOAT NULL   )  ''');
  }

  Future<int> insert(HistoryDbModel todo) async {
    Database db = await instance.database;
    //print(todo.toMap());
    var res = await db.insert(table, todo.toMap());
    //return res;
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    var res = await db.query(table, orderBy: "$columnId DESC");
    return res;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, Object?>>> clearTable() async {
    Database db = await instance.database;
    return await db.rawQuery("DELETE FROM $table");
  }
}

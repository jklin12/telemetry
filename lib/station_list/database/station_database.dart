import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StationDatabase {
  static const _databaseName = "station.db";
  static const _databaseVersion = 1;
  static const table = "station";
  static const columnId = 'stationId';
  static const columnbody = 'station_name';

  StationDatabase._privateConstructor();
  static final StationDatabase instance = StationDatabase._privateConstructor();
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
        '''  CREATE TABLE $table (    $columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnbody FLOAT NULL   )  ''');
  }

  Future<int> insert(Map<String, dynamic> todo) async {
    Database db = await instance.database;

    var res = await db.insert(table, todo);
    //return res;
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    var res = await db.query(table, orderBy: "$columnId ASC");
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

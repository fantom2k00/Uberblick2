import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../Models/user.dart';

class Scans {

  static const _databaseName = "uberblick_db.db";
  static const _databaseVersion = 1;

  static const table = 'Scans';

  static const scanId = 'scan_id';
  static const userId = 'user_id';
  static const foodId = 'food_id';
  static const dateTime = 'date_time';
  static const location = 'location';

  Scans._privateConstructor();
  static final Scans instance = Scans._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initScans();
    return _database;
  }

  _initScans() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
  }

  Future<int> addScan(Map<String, dynamic> row) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await openDatabase(path, version: _databaseVersion);
    Database db = await instance.database;

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $table (
        $scanId INTEGER PRIMARY KEY,
        $userId INTEGER NOT NULL,
        $foodId INTEGER NOT NULL,
        $dateTime TEXT NOT NULL,
        $location TEXT NOT NULL
      )
      ''');

    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> getScans(_userId) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await openDatabase(path, version: _databaseVersion);
    Database db = await instance.database;
    return await db.query('$table WHERE $userId = $_userId');
  }

  Future<int> deleteScan(int _scanId, int _userId) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await openDatabase(path, version: _databaseVersion);
    Database db = await instance.database;
    return await db.delete(table, where: '$scanId = ? AND $userId = ?', whereArgs: [_scanId, _userId]);
  }
}
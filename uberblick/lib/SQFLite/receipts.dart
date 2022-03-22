import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../Models/user.dart';

class Receipts {

  static const _databaseName = "uberblick_db.db";
  static const _databaseVersion = 1;

  static const table = 'Receipts';

  static const receiptId = 'receipt_id';
  static const userId = 'user_id';
  static const foodIds = 'food_ids';
  static const dateTime = 'date_time';
  static const location = 'location';

  Receipts._privateConstructor();
  static final Receipts instance = Receipts._privateConstructor();

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

  Future<int> addReceipt(Map<String, dynamic> row) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await openDatabase(path, version: _databaseVersion);
    Database db = await instance.database;

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $table (
        $receiptId INTEGER PRIMARY KEY,
        $userId INTEGER NOT NULL,
        $foodIds TEXT NOT NULL,
        $dateTime TEXT NOT NULL,
        $location TEXT NOT NULL
      )
      ''');

    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> getReceipts(_userId) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await openDatabase(path, version: _databaseVersion);
    Database db = await instance.database;
    return await db.query('$table WHERE user_id = $_userId');
  }

  Future<int> deleteReceipt(int receiptId, int userId) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await openDatabase(path, version: _databaseVersion);
    Database db = await instance.database;
    return await db.delete(table, where: '$receiptId = ? AND $userId = ?', whereArgs: [receiptId, userId]);
  }
}
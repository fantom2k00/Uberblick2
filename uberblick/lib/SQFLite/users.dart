import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../Models/user.dart';

class Users {

  static const _databaseName = "uberblick_db.db";
  static const _databaseVersion = 1;

  static const table = 'Users';

  static const userId = 'user_id';
  static const email = 'email';
  static const password = 'password';
  static const nickname = 'nickname';
  static const country = 'country';
  static const birthyear = 'birthyear';

  Users._privateConstructor();
  static final Users instance = Users._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initUsers();
    return _database;
  }

  _initUsers() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $table (
            $userId INTEGER PRIMARY KEY,
            $email TEXT NOT NULL,
            $password TEXT NOT NULL,
            $nickname TEXT NOT NULL,
            $country TEXT NOT NULL,
            $birthyear INTEGER NOT NULL
          )
          ''');

    User admin = User(
      email: 'Admin',
      password: 'Admin',
      nickname: 'Admin',
      country: 'Belgium',
      birthyear: 2000,
    );

    addUser( admin.getUser() );
  }

  Future<int> addUser(Map<String, dynamic> row) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await openDatabase(path, version: _databaseVersion);
    Database db = await instance.database;
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $table (
            $userId INTEGER PRIMARY KEY,
            $email TEXT NOT NULL,
            $password TEXT NOT NULL,
            $nickname TEXT NOT NULL,
            $country TEXT NOT NULL,
            $birthyear INTEGER NOT NULL
          )
          ''');
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[userId];
    return await db.update(table, row, where: '$userId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$userId = ?', whereArgs: [id]);
  }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../Models/food.dart';

class Foods {

  static const _databaseName = "uberblick_db.db";
  static const _databaseVersion = 1;

  static const table = 'Foods';

  static const foodId = 'food_id';
  static const food = 'food';
  static const price = 'price';

  static const unit = 'unit';
  static const serving = 'serving';
  static const quantity = 'quantity';

  static const kgCo2Eq = 'kg_co2_eq';
  static const landUse = 'land_use';
  static const waterUse = 'water_use';
  static const ecoRating = 'eco_rating';

  static const nutriscore = 'nutriscore';
  static const calories = 'calories';
  static const carbs = 'carbs';
  static const fat = 'fat';
  static const protein = 'protein';
  static const ingredients = 'ingredients';

  static const producer = 'producer';
  static const distributor = 'distributor';
  static const additionalInfo = 'additional_info';

  Foods._privateConstructor();
  static final Foods instance = Foods._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initFoods();
    return _database;
  }

  _initFoods() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion);
  }

  Future<int> addFood() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await openDatabase(path, version: _databaseVersion);
    Database db = await instance.database;

    await db.execute('DROP TABLE IF EXISTS $table');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $table(
            $foodId INTEGER PRIMARY KEY,
            $food TEXT NOT NULL,
            $price DOUBLE NOT NULL,
            
            $unit TEXT NOT NULL,
            $serving INTEGER NOT NULL,
            $quantity INTEGER NOT NULL,
            
            $kgCo2Eq DOUBLE NOT NULL,
            $landUse DOUBLE NOT NULL,
            $waterUse DOUBLE NOT NULL,
            $ecoRating TEXT NOT NULL,
            
            $nutriscore TEXT NOT NULL,
            $calories INTEGER NOT NULL,
            $carbs DOUBLE NOT NULL,
            $fat DOUBLE NOT NULL,
            $protein DOUBLE NOT NULL,
            $ingredients TEXT NOT NULL,
            
            $producer TEXT NOT NULL,
            $distributor TEXT NOT NULL,
            $additionalInfo TEXT NOT NULL
          )
          ''');

    Food freeRangeEggs = Food(
      food: 'Free Range Eggs',
      price: 2.50,

      unit: 'egg',
      serving: 1,
      quantity: 6,

      kgCo2Eq: 0.22, //kg/egg
      landUse: 0.4, //m2/egg
      waterUse: 199.81, //l/egg
      ecoRating: 'D',

      nutriscore: 'B',
      calories: 77,
      carbs: 0.6,
      fat: 5.3,
      protein: 6.3,
      ingredients: 'saturated fats, monounsaturated fat, cholesterol, vitamin a, vitamin b, phosphorus, selenium',

      producer: 'Ferme Plein Air',
      distributor: 'Lidl Belgium GmbH & Co. KG',
      additionalInfo: 'Free range eggs, coming from hens raised outdoors living in good conditions.',
    );
    await db.insert(table, freeRangeEggs.getFood());

    Food intensivelyFarmedEggs = Food(
      food: 'Intensively Farmed Eggs',
      price: 2.85,

      unit: 'egg',
      serving: 1,
      quantity: 8,

      kgCo2Eq: 0.20, //kg/egg
      landUse: 0.34, //m2/egg
      waterUse: 179.81, //l/egg
      ecoRating: 'C',

      nutriscore: 'B',
      calories: 77,
      carbs: 0.6,
      fat: 5.3,
      protein: 6.3,
      ingredients: 'saturated fats, monounsaturated fat, cholesterol, vitamin a, vitamin b, phosphorus, selenium',

      producer: 'Urban Egg Productions',
      distributor: 'Lidl Belgium GmbH & Co. KG',
      additionalInfo: 'Intensively farmed eggs, coming from hens living in closed, crowded cages.',
    );
    return await db.insert(table, intensivelyFarmedEggs.getFood());
  }

  Future<List<Map<String, dynamic>>> getFoods() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await openDatabase(path, version: _databaseVersion);
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<Map<String, dynamic>> getFood(int _foodId) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await openDatabase(path, version: _databaseVersion);
    Database db = await instance.database;
    return (await db.query('$table WHERE $foodId = $_foodId'))[0];
  }

  void deleteFoods() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await openDatabase(path, version: _databaseVersion);
    Database db = await instance.database;
    await db.execute('DROP TABLE IF EXISTS $table');
  }
}
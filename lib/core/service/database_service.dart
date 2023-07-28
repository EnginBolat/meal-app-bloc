import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/database_model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('savedmeals.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';

    await db.execute('''
CREATE TABLE $tableSavedNews ( 
  ${SavedMealFields.id} $idType
  )
''');
  }

  Future<SavedMealModel> create(SavedMealModel meal) async {
    final db = await instance.database;
    final id = await db.insert(tableSavedNews, meal.toJson());
    log("Kaydedildi id: ${meal.id}");
    return meal.copy(id: id);
  }

  Future<SavedMealModel> readSavedMealsById(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableSavedNews,
      columns: SavedMealFields.values,
      where: '${SavedMealFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return SavedMealModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<SavedMealModel>?> allSavedMeals() async {
    final db = await instance.database;
    final result = await db.query(tableSavedNews);
    return result.map((json) => SavedMealModel.fromJson(json)).toList();
  }

  Future<int> update(SavedMealModel meal) async {
    final db = await instance.database;
    return db.update(
      tableSavedNews,
      meal.toJson(),
      where: '${SavedMealFields.id} = ?',
      whereArgs: [meal.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableSavedNews,
      where: '${SavedMealFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future resetDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'savednews.db');

    if (await File(path).exists()) {
      await deleteDatabase(path);
      debugPrint('Veritabanı sıfırlandı.');
    } else {
      debugPrint('Veritabanı bulunamadı.');
    }
  }
}

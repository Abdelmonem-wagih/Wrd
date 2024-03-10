import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton pattern to ensure a single instance of the database helper
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  // Database instance variable
  Database? _database;

  // Getter for the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If the database does not exist, copy it from assets to the app's directory
    _database = await _initDatabase();
    return _database!;
  }

  // Internal method to initialize the database
  Future<Database> _initDatabase() async {
    // Get the directory path for both Android and iOS to store the database.
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "quran.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Copy the database from assets
      ByteData data =
          await rootBundle.load("assets/database/Holly-Quran.sqlite");
      List<int> bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes, flush: true);
    }

    // Open the database
    return await openDatabase(path, readOnly: true);
  }

  Future<List<Map<String, dynamic>>> fetchDataFromTable(int page) async {
    Database db = await database;
    return await db.query('aya', where: 'page = ?', whereArgs: [page]);
  }

  Future<List<Map<String, dynamic>>> fetchDataFromTableBySurahId(
    int page,
  ) async {
    Database db = await database;
    return await db.query('quran', where: 'page = ?', whereArgs: [page]);
  }

  Future<String> getStringById(int id) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'aya',
      columns: ['text'],
      where: 'ayaId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return maps.first['text'];
    } else {
      return 'Not Found';
    }
  }

  Future<List<Map<String, dynamic>>> fetchJozFromTable(int page) async {
    Database db = await database;
    return await db.query('aya', where: 'joza = ?', whereArgs: [page]);
  }
}

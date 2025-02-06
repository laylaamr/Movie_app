import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Api/model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Api/model.dart';

class DatabaseHelper {
  static const _dbName = 'favorites.db';
  static const _dbVersion = 2;  // Incremented version number
  static const _tableName = 'favorites';

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tableName(
      rank INTEGER PRIMARY KEY,  -- rank column added
      title TEXT,
      description TEXT,
      image TEXT,
      bigImage TEXT,
      genre TEXT,
      thumbnail TEXT,
      rating TEXT,
      id TEXT,
      year INTEGER,
      imdbid TEXT,
      imdbLink TEXT
    )
  ''');
  }

  // Handle database schema upgrades if needed
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add rank column if the version was previously lower than 2
      await db.execute('''
        ALTER TABLE $_tableName ADD COLUMN rank INTEGER
      ''');
    }
  }

  Future<int> insertMovie(Movie movie) async {
    Database db = await database;
    return await db.insert(
      _tableName,
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Prevent duplicates
    );
  }

  Future<bool> isFavorite(int rank) async {
    Database db = await database;
    var result = await db.query(_tableName, where: 'rank = ?', whereArgs: [rank]);
    return result.isNotEmpty;
  }

  Future<List<Movie>> getFavoriteMovies() async {
    Database db = await database;
    var result = await db.query(_tableName);
    return result.map((e) => Movie.fromMap(e)).toList();
  }

  Future<int> deleteMovie(int rank) async {
    Database db = await database;
    return await db.delete(_tableName, where: 'rank = ?', whereArgs: [rank]);
  }

  // Delete the database (used for development)
  Future<void> deleteDatabaseFile() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, _dbName);
    await deleteDatabase(path);  // Delete the database
  }
}

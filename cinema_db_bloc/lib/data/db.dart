import 'dart:io';
import 'package:cinema_db_bloc/model/movie.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {

  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'movies.db');
    return await openDatabase(path, version: 1, onOpen: (db) async {
    }, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE movies (id INTEGER PRIMARY KEY, title TEXT, vote_average INTEGER, poster_path TEXT,'
            'backdrop_path TEXT, overview TEXT, release_date TEXT)'
      );
    });
  }

  Future addMovie(Movie movie) async {
    final db = await database;
    var result = await db.insert('movies', movie.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<List> getMovies() async {
    final db = await database;
    var moviesList = List<Movie>();
    List<Map> result = await db.query('movies');
    moviesList = result.map((item) => Movie(item)).toList();
    return moviesList;
  }
}
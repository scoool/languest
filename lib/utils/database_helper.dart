import 'package:langtest/module/sql_words.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String WordTable = 'note_table';
  String colId = 'id';
  String colWord = 'word';
  String colMean = 'mean';
  String colLang = 'lang';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'langtest.db';

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $WordTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colWord TEXT, '
        '$colMean TEXT, $colLang TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getWordMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $WordTable order by $colPriority ASC');
    var result = await db.query(WordTable, orderBy: '$colId ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(SQLiteWords word) async {
    Database db = await this.database;
    var result = await db.insert(WordTable, word.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(SQLiteWords word) async {
    var db = await this.database;
    var result = await db.update(WordTable, word.toMap(), where: '$colId = ?', whereArgs: [word.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $WordTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $WordTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<SQLiteWords>> getWordList() async {

    var noteMapList = await getWordMapList(); // Get 'Map List' from database
    int count = noteMapList.length;         // Count the number of map entries in db table

    List<SQLiteWords> wordList = List<SQLiteWords>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      wordList.add(SQLiteWords.fromMapObject(noteMapList[i]));
    }

    return wordList;
  }

}

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  Future<Database> createDatabase() async {
    Directory databaseDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(databaseDirectory.path, 'notes_app.db');

    Database database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
    return database;
  }

  void populateDb(Database db, int version) async {
    await db.execute(
      """CREATE TABLE notes(
        id TEXT PRIMARY KEY,
        date TEXT,
        title TEXT,
        content TEXT)""",
    );
  }
}

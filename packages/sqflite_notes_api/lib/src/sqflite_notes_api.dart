import 'package:notes_api/notes_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteNotesApi extends NotesApi {
  SqfliteNotesApi._(this._db);

  final Database _db;

  static openDb() async {
    final databasePath = await getDatabasesPath();
    final dbPath = join(databasePath, 'notes_app.db');

    Database database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE notes(id TEXT PRIMARY KEY, title TEXT, content TEXT, date TEXT)',
        );
      },
    );

    return SqfliteNotesApi._(database);
  }

  @override
  Future<void> addNote(Note note) {
    // TODO: implement addNote
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNote(String id) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> getAllNotes() {
    // TODO: implement getAllNotes
    throw UnimplementedError();
  }

  @override
  Future<Note?> getNote(String id) {
    // TODO: implement getNote
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> searchNotes(String pattern) {
    // TODO: implement searchNotes
    throw UnimplementedError();
  }

  @override
  Future<void> updateNote(Note note) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}

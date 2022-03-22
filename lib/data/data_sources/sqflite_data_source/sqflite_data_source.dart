import 'package:sqflite/sqflite.dart';

import '../../models/note_model.dart';
import '../i_data_source.dart';

class SqfliteDataSource implements IDataSource {
  final Database _db;
  final String table = 'notes';

  SqfliteDataSource(this._db);

  //================================================================================================
  @override
  Future<void> addNote(NoteModel noteModel) async {
    await _db.insert(
      table,
      noteModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //================================================================================================
  @override
  Future<void> updateNote(NoteModel noteModel) async {
    await _db.update(
      table,
      noteModel.toMap(),
      where: 'id = ?',
      whereArgs: [noteModel.id],
    );
  }

  //================================================================================================
  @override
  Future<void> deleteNote(String id) async {
    await _db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //================================================================================================
  @override
  Future<List<NoteModel>> getAllNotes() async {
    var listOfMaps = await _db.query(
      table,
      orderBy: 'date DESC',
    );

    if (listOfMaps.isEmpty) return [];

    return listOfMaps.map<NoteModel>((map) => NoteModel.fromMap(map)).toList();
  }

  //================================================================================================
  @override
  Future<NoteModel?> getNoteById(String id) async {
    var listOfMaps = await _db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (listOfMaps.isEmpty) {
      return null;
    } else {
      return NoteModel.fromMap(listOfMaps.first);
    }
  }

  //================================================================================================
  @override
  Future<List<NoteModel>> searchNotes(String pattern) async {
    var listOfMaps = await _db.query(
      table,
      where: 'title LIKE ?',
      whereArgs: ['%$pattern%'],
      orderBy: 'date DESC',
    );

    if (listOfMaps.isEmpty) return [];

    return listOfMaps.map<NoteModel>((map) => NoteModel.fromMap(map)).toList();
  }
  //================================================================================================

}

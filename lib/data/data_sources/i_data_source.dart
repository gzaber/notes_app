import 'package:notes_app/data/models/note_model.dart';

abstract class IDataSource {
  Future<void> addNote(NoteModel noteModel);
  Future<void> updateNote(NoteModel noteModel);
  Future<void> deleteNote(String id);
  Future<List<NoteModel>> getAllNotes();
  Future<NoteModel?> getNoteById(String id);
  Future<List<NoteModel>> searchNotes(String pattern);
}

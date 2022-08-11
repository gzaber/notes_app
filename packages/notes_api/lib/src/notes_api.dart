import 'package:notes_api/notes_api.dart';

abstract class NotesApi {
  Future<void> addNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String id);
  Future<List<Note>> getAllNotes();
  Future<Note?> getNote(String id);
  Future<List<Note>> searchNotes(String pattern);
}

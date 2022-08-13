import 'package:notes_api/notes_api.dart';

class NotesRepository {
  const NotesRepository({
    required NotesApi notesApi,
  }) : _notesApi = notesApi;

  final NotesApi _notesApi;

  Future<void> addNote(Note note) async => await _notesApi.addNote(note);
  Future<void> updateNote(Note note) async => await _notesApi.updateNote(note);
  Future<void> deleteNote(String id) async => await _notesApi.deleteNote(id);
  Future<List<Note>> getAllNotes() async => await _notesApi.getAllNotes();
  Future<Note> getNote(String id) async => await _notesApi.getNote(id);
  Future<List<Note>> searchNotes(String pattern) async =>
      await _notesApi.searchNotes(pattern);
}

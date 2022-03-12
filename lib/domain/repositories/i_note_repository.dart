import 'package:notes_app/domain/entities/note.dart';

abstract class INoteRepository {
  Future<void> add(String title, String content);
  Future<void> update(Note note);
  Future<void> delete(String id);
  Future<List<Note>> getAll();
  Future<Note?> getById(String id);
  Future<List<Note>> search(String pattern);
}

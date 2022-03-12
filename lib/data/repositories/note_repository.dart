import 'package:notes_app/data/data_sources/i_data_source.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/domain/repositories/i_note_repository.dart';

class NoteRepository implements INoteRepository {
  final IDataSource _dataSource;

  NoteRepository(this._dataSource);
  //================================================================================================
  @override
  Future<void> add(String title, String content) async {
    NoteModel noteModel = NoteModel.newNote(
      title: title,
      content: content,
    );
    return await _dataSource.addNote(noteModel);
  }

  //================================================================================================
  @override
  Future<void> update(Note note) async {
    NoteModel noteModel = NoteModel(
      id: note.id,
      date: note.date,
      title: note.title,
      content: note.content,
    );

    return await _dataSource.updateNote(noteModel);
  }

  //================================================================================================
  @override
  Future<void> delete(String id) async {
    await _dataSource.deleteNote(id);
  }

  //================================================================================================
  @override
  Future<List<Note>> getAll() async {
    return await _dataSource.getAllNotes();
  }

  //================================================================================================
  @override
  Future<Note?> getById(String id) async {
    return await _dataSource.getNoteById(id);
  }

  //================================================================================================
  @override
  Future<List<Note>> search(String pattern) async {
    return await _dataSource.searchNotes(pattern);
  }
  //================================================================================================
}

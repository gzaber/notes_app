import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/domain/repositories/i_note_repository.dart';

class FakeNoteRepository implements INoteRepository {
  var map1 = {
    'id': 'id1',
    'date': '2022',
    'title': 'title1',
    'content': 'content1',
  };
  var map2 = {
    'id': 'id2',
    'date': '2022',
    'title': 'title2',
    'content': 'content2',
  };

  var map3 = {
    'id': 'id3',
    'date': '2022',
    'title': 'title3',
    'content': 'content3',
  };

  var map4 = {
    'id': 'id4',
    'date': '2022',
    'title': 'title333',
    'content': 'content4',
  };

  late List<Note> notes;

  FakeNoteRepository() {
    notes = [
      NoteModel.fromMap(map1),
      NoteModel.fromMap(map2),
      NoteModel.fromMap(map3),
      NoteModel.fromMap(map4),
    ];
  }

  //================================================================================================
  @override
  Future<void> add(String title, String content) async {
    NoteModel noteModel = NoteModel.newNote(title: title, content: content);

    return notes.add(noteModel);
  }

  //================================================================================================
  @override
  Future<void> update(Note note) async {
    int counter = 0;
    int idx = 0;
    for (Note n in notes) {
      if (n.id == note.id) idx = counter;
      counter++;
    }
    notes[idx] = note;
  }

  //================================================================================================
  @override
  Future<void> delete(String id) async {
    int counter = 0;
    int idx = 0;
    for (Note n in notes) {
      if (n.id == id) idx = counter;
      counter++;
    }
    notes.removeAt(idx);
  }

  //================================================================================================
  @override
  Future<List<Note>> getAll() async {
    if (notes.isEmpty) {
      return [];
    } else {
      return notes;
    }
  }

  //================================================================================================
  @override
  Future<Note?> getById(String id) async {
    var result = notes.where((n) => n.id == id).toList();

    if (result.isEmpty) {
      return null;
    } else {
      return result.first;
    }
  }

  //================================================================================================
  @override
  Future<List<Note>> search(String pattern) async {
    var result = notes.where((n) => n.title.contains(pattern)).toList();

    if (result.isEmpty) {
      return [];
    } else {
      return result;
    }
  }
  //================================================================================================
}

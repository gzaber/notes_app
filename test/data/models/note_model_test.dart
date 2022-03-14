import 'package:notes_app/data/models/note_model.dart';
import 'package:test/test.dart';

void main() {
  group('NoteModel.newNote', () {
    test('should create NoteModel with generated id and date fields', () {
      // arrange
      String title = 'title';
      String content = 'content';
      // act
      var result = NoteModel.newNote(title: title, content: content);
      // assert
      expect(result.title, title);
      expect(result.content, content);
      expect(result.id, isNotNull);
      expect(result.id, isNotEmpty);
      expect(result.date, isNotNull);
      expect(result.date, isNotEmpty);
    });
  });

  group('NoteModel.fromMap', () {
    test('should create NoteModel from map', () {
      // arrange
      String id = 'id';
      String date = '2022';
      String title = 'title';
      String content = 'content';
      // act
      var result = NoteModel.fromMap(
        {
          'id': id,
          'date': date,
          'title': title,
          'content': content,
        },
      );
      // assert
      expect(result.id, id);
      expect(result.date, date);
      expect(result.title, title);
      expect(result.content, content);
    });
  });

  group('NoteModel.toMap', () {
    test('should create map from NoteModel', () {
      // arrange
      String id = 'id';
      String date = '2022';
      String title = 'title';
      String content = 'content';
      NoteModel noteModel = NoteModel(id: id, date: date, title: title, content: content);
      // act
      var result = noteModel.toMap();
      // assert
      expect(result['id'], id);
      expect(result['date'], date);
      expect(result['title'], title);
      expect(result['content'], content);
    });
  });
}

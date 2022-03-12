import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/data/data_sources/i_data_source.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/data/repositories/note_repository.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:test/test.dart';

import 'note_repository_test.mocks.dart';

@GenerateMocks([IDataSource])
void main() {
  late NoteRepository sut;
  late MockIDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockIDataSource();
    sut = NoteRepository(mockDataSource);
  });

  //================================================================================================
  group('NoteRepository.add', () {
    test('should add a note when successful', () async {
      // arrange
      // act
      await sut.add('title', 'content');
      // assert
      verify(mockDataSource.addNote(any)).called(1);
    });
  });
  //================================================================================================
  group('NoteRepository.update', () {
    test('should update a note when successful', () async {
      // arrange
      Note note = Note(id: 'id', date: '2022', title: 'title', content: 'content');
      // act
      await sut.update(note);
      // assert
      verify(mockDataSource.updateNote(any)).called(1);
    });
  });
  //================================================================================================
  group('NoteRepository.delete', () {
    test('should delete a note when successful', () async {
      // arrange
      // act
      await sut.delete('id');
      // assert
      verify(mockDataSource.deleteNote(any)).called(1);
    });
  });
  //================================================================================================
  group('NoteRepository.getAll', () {
    test('should return list of notes when successful', () async {
      // arrange
      NoteModel noteModel = NoteModel.newNote(title: 'title', content: 'content');
      when(mockDataSource.getAllNotes()).thenAnswer((_) async => [noteModel]);
      // act
      var result = await sut.getAll();
      // assert
      expect(result, isNotEmpty);
      expect(result, [noteModel]);
      verify(mockDataSource.getAllNotes()).called(1);
    });

    test('should return empty list when no notes found', () async {
      // arrange
      when(mockDataSource.getAllNotes()).thenAnswer((_) async => []);
      // act
      var result = await sut.getAll();
      // assert
      expect(result, isEmpty);
      verify(mockDataSource.getAllNotes()).called(1);
    });
  });
  //================================================================================================
  group('NoteRepository.getById', () {
    test('should return a note when successful', () async {
      // arrange
      NoteModel noteModel = NoteModel.newNote(title: 'title', content: 'content');
      when(mockDataSource.getNoteById(any)).thenAnswer((_) async => noteModel);
      // act
      var result = await sut.getById('id');
      // assert
      expect(result, isNotNull);
      expect(result, noteModel);
      verify(mockDataSource.getNoteById(any)).called(1);
    });

    test('should return null when note not found', () async {
      // arrange
      when(mockDataSource.getNoteById(any)).thenAnswer((_) async => null);
      // act
      var result = await sut.getById('id');
      // assert
      expect(result, isNull);
      verify(mockDataSource.getNoteById(any)).called(1);
    });
  });
  //================================================================================================
  group('NoteRepository.search', () {
    test('should return list of notes when successful', () async {
      // arrange
      NoteModel noteModel = NoteModel.newNote(title: 'title', content: 'content');
      when(mockDataSource.searchNotes(any)).thenAnswer((_) async => [noteModel]);
      // act
      var result = await sut.search('pattern');
      // assert
      expect(result, isNotEmpty);
      expect(result, [noteModel]);
      verify(mockDataSource.searchNotes(any)).called(1);
    });

    test('should return empty list when no notes found', () async {
      // arrange
      when(mockDataSource.searchNotes(any)).thenAnswer((_) async => []);
      // act
      var result = await sut.search('failurePattern');
      // assert
      expect(result, isEmpty);
      verify(mockDataSource.searchNotes(any)).called(1);
    });
  });
  //================================================================================================
}

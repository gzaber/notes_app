import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/data/data_sources/sqflite_data_source/sqflite_data_source.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/test.dart';

import 'sqflite_data_source_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  late SqfliteDataSource sut;
  late MockDatabase mockDatabase;
  late String table;

  setUp(() {
    table = 'notes';
    mockDatabase = MockDatabase();
    sut = SqfliteDataSource(mockDatabase);
  });

  NoteModel noteModel = NoteModel(
    id: 'id',
    date: '2022',
    title: 'title',
    content: 'content',
  );

  // ===============================================================================================
  group('addNote', () {
    test('should perform a database insert', () async {
      // arrange
      when(mockDatabase.insert(
        table,
        noteModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )).thenAnswer((_) async => 1);
      // act
      await sut.addNote(noteModel);
      // assert
      verify(mockDatabase.insert(
        table,
        noteModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )).called(1);
    });
  });
  // ===============================================================================================
  group('updateNote', () {
    test('should perform a database update', () async {
      // arrange
      when(mockDatabase.update(
        table,
        noteModel.toMap(),
        where: 'id = ?',
        whereArgs: [noteModel.id],
      )).thenAnswer((_) async => 1);
      // act
      await sut.updateNote(noteModel);
      // assert
      verify(mockDatabase.update(
        table,
        noteModel.toMap(),
        where: 'id = ?',
        whereArgs: [noteModel.id],
      )).called(1);
    });
  });
  // ===============================================================================================
  group('deleteNote', () {
    test('should perform a database delete', () async {
      // arrange
      when(mockDatabase.delete(
        table,
        where: 'id = ?',
        whereArgs: [noteModel.id],
      )).thenAnswer((_) async => 1);
      // act
      await sut.deleteNote(noteModel.id);
      // assert
      verify(mockDatabase.delete(
        table,
        where: 'id = ?',
        whereArgs: [noteModel.id],
      )).called(1);
    });
  });
  // ===============================================================================================
  group('getAllNotes', () {
    test('should perform a database query and return all notes', () async {
      // arrange
      when(mockDatabase.query(table, orderBy: 'date ASC'))
          .thenAnswer((_) async => [noteModel.toMap()]);
      // act
      await sut.getAllNotes();
      // assert
      verify(mockDatabase.query(table, orderBy: 'date ASC')).called(1);
    });
  });
  // ===============================================================================================
  group('getNoteById', () {
    test('should perform a database query and return a matching record', () async {
      // arrange
      when(mockDatabase.query(
        table,
        where: 'id = ?',
        whereArgs: [noteModel.id],
      )).thenAnswer((_) async => [noteModel.toMap()]);
      // act
      await sut.getNoteById(noteModel.id);
      // assert
      verify(mockDatabase.query(
        table,
        where: 'id = ?',
        whereArgs: [noteModel.id],
      )).called(1);
    });
  });
  // ===============================================================================================
  group('searchNotes', () {
    String pattern = 'ti';
    test('should perform a database query and return found notes', () async {
      // arrange
      when(mockDatabase.query(
        table,
        where: 'title LIKE ?',
        whereArgs: ['%$pattern%'],
        orderBy: 'date ASC',
      )).thenAnswer((_) async => [noteModel.toMap()]);
      // act
      await sut.searchNotes(pattern);
      // assert
      verify(mockDatabase.query(
        table,
        where: 'title LIKE ?',
        whereArgs: ['%$pattern%'],
        orderBy: 'date ASC',
      )).called(1);
    });
  });
  // ===============================================================================================

  // ===============================================================================================
}

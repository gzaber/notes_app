// Mocks generated by Mockito 5.1.0 from annotations
// in notes_app/test/data/repositories/note_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:notes_app/data/data_sources/i_data_source.dart' as _i2;
import 'package:notes_app/data/models/note_model.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [IDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockIDataSource extends _i1.Mock implements _i2.IDataSource {
  MockIDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> addNote(_i4.NoteModel? noteModel) =>
      (super.noSuchMethod(Invocation.method(#addNote, [noteModel]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> updateNote(_i4.NoteModel? noteModel) =>
      (super.noSuchMethod(Invocation.method(#updateNote, [noteModel]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> deleteNote(String? id) =>
      (super.noSuchMethod(Invocation.method(#deleteNote, [id]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<List<_i4.NoteModel>> getAllNotes() =>
      (super.noSuchMethod(Invocation.method(#getAllNotes, []),
              returnValue: Future<List<_i4.NoteModel>>.value(<_i4.NoteModel>[]))
          as _i3.Future<List<_i4.NoteModel>>);
  @override
  _i3.Future<_i4.NoteModel?> getNoteById(String? id) =>
      (super.noSuchMethod(Invocation.method(#getNoteById, [id]),
              returnValue: Future<_i4.NoteModel?>.value())
          as _i3.Future<_i4.NoteModel?>);
  @override
  _i3.Future<List<_i4.NoteModel>> searchNotes(String? expression) =>
      (super.noSuchMethod(Invocation.method(#searchNotes, [expression]),
              returnValue: Future<List<_i4.NoteModel>>.value(<_i4.NoteModel>[]))
          as _i3.Future<List<_i4.NoteModel>>);
}

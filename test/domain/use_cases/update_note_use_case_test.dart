import 'package:async/async.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/domain/use_cases/update_note_use_case.dart';

import 'package:test/test.dart';

import '../../data/fake_repositories/fake_note_repository.dart';

void main() {
  late UpdateNoteUseCase sut;
  late FakeNoteRepository fakeNoteRepository;

  setUp(() {
    fakeNoteRepository = FakeNoteRepository();
    sut = UpdateNoteUseCase(fakeNoteRepository);
  });

  group('UpdateNoteUseCase', () {
    test('should update a note when successful', () async {
      // arrange
      Note note = Note(
        id: fakeNoteRepository.notes.first.id,
        date: fakeNoteRepository.notes.first.date,
        title: 'newTitle',
        content: 'newContent',
      );
      // act
      var result = await sut(note);
      // assert
      expect(result, isA<ValueResult>());
      expect(fakeNoteRepository.notes.first.title, note.title);
    });

    test('should return an error when title is empty', () async {
      // arrange
      Note note = Note(
        id: fakeNoteRepository.notes.first.id,
        date: fakeNoteRepository.notes.first.date,
        title: '',
        content: 'newContent',
      );
      // act
      var result = await sut(note);
      // assert
      expect(result, isA<ErrorResult>());
    });
  });
}

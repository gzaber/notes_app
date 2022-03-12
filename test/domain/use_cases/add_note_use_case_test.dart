import 'package:async/async.dart';
import 'package:notes_app/domain/use_cases/add_note_use_case.dart';
import 'package:test/test.dart';

import '../../data/fake_repositories/fake_note_repository.dart';

void main() {
  late AddNoteUseCase sut;
  late FakeNoteRepository fakeNoteRepository;

  setUp(() {
    fakeNoteRepository = FakeNoteRepository();
    sut = AddNoteUseCase(fakeNoteRepository);
  });

  group('AddNoteUseCase', () {
    test('should add a note when successful', () async {
      // arrange
      int len = fakeNoteRepository.notes.length;
      // act
      var result = await sut('title', 'content');
      // assert
      expect(result, isA<ValueResult>());
      expect(result, isA<Result<void>>());
      expect(fakeNoteRepository.notes.length, len + 1);
    });

    test('should return an error when title is empty', () async {
      // arrange
      int len = fakeNoteRepository.notes.length;
      // act
      var result = await sut('', 'content');
      // assert
      expect(result, isA<ErrorResult>());
      expect(result, isA<Result<void>>());
      expect(fakeNoteRepository.notes.length, len);
    });
  });
}

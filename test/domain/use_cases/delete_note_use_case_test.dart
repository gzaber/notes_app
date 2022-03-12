import 'package:async/async.dart';
import 'package:notes_app/domain/use_cases/delete_note_use_case.dart';

import 'package:test/test.dart';

import '../../data/fake_repositories/fake_note_repository.dart';

void main() {
  late DeleteNoteUseCase sut;
  late FakeNoteRepository fakeNoteRepository;

  setUp(() {
    fakeNoteRepository = FakeNoteRepository();
    sut = DeleteNoteUseCase(fakeNoteRepository);
  });

  group('DeleteNoteUseCase', () {
    test('should delete a note when successful', () async {
      // arrange
      int len = fakeNoteRepository.notes.length;
      String id = fakeNoteRepository.notes.first.id;
      // act
      var result = await sut(id);
      // assert
      expect(result, isA<ValueResult>());
      expect(result, isA<Result<void>>());
      expect(fakeNoteRepository.notes.length, len - 1);
    });
  });
}

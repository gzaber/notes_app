import 'package:async/async.dart';
import 'package:notes_app/domain/use_cases/get_all_notes_use_case.dart';

import 'package:test/test.dart';

import '../../data/fake_repositories/fake_note_repository.dart';

void main() {
  late GetAllNotesUseCase sut;
  late FakeNoteRepository fakeNoteRepository;

  setUp(() {
    fakeNoteRepository = FakeNoteRepository();
    sut = GetAllNotesUseCase(fakeNoteRepository);
  });

  group('GetAllNotesUseCase', () {
    test('should return list of notes when successful', () async {
      // arrange
      int len = fakeNoteRepository.notes.length;
      // act
      var result = await sut();
      // assert
      expect(result, isA<ValueResult>());
      expect(result.asValue!.value.length, len);
    });

    test('should return an error when no notes found', () async {
      // arrange
      fakeNoteRepository.notes.clear();
      // act
      var result = await sut();
      // assert
      expect(result, isA<ErrorResult>());
    });
  });
}

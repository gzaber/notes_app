import 'package:async/async.dart';
import 'package:notes_app/domain/use_cases/search_notes_use_case.dart';

import 'package:test/test.dart';

import '../../data/fake_repositories/fake_note_repository.dart';

void main() {
  late SearchNotesUseCase sut;
  late FakeNoteRepository fakeNoteRepository;

  setUp(() {
    fakeNoteRepository = FakeNoteRepository();
    sut = SearchNotesUseCase(fakeNoteRepository);
  });

  group('SearchNotesUseCase', () {
    test('should return list of notes when successful', () async {
      // arrange
      String pattern = 'title3';
      // act
      var result = await sut(pattern);
      // assert
      expect(result, isA<ValueResult>());
      expect(result.asValue!.value.length, 2);
    });

    test('should return an error when no notes found', () async {
      // arrange
      fakeNoteRepository.notes.clear();
      // act
      var result = await sut('unknown');
      // assert
      expect(result, isA<ErrorResult>());
    });
  });
}

import 'package:async/async.dart';
import 'package:notes_app/domain/use_cases/get_note_by_id_use_case.dart';

import 'package:test/test.dart';

import '../../data/fake_repositories/fake_note_repository.dart';

void main() {
  late GetNoteByIdUseCase sut;
  late FakeNoteRepository fakeNoteRepository;

  setUp(() {
    fakeNoteRepository = FakeNoteRepository();
    sut = GetNoteByIdUseCase(fakeNoteRepository);
  });

  group('GetNoteByIdUseCase', () {
    test('should return a note when successful', () async {
      // arrange
      String id = fakeNoteRepository.notes.last.id;
      // act
      var result = await sut(id);
      // assert
      expect(result, isA<ValueResult>());
      expect(result.asValue!.value.id, id);
    });

    test('should return an error when note not found', () async {
      // arrange
      // act
      var result = await sut('unknownId');
      // assert
      expect(result, isA<ErrorResult>());
    });
  });
}

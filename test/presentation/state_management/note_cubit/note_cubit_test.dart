import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/domain/use_cases/get_note_by_id_use_case.dart';
import 'package:notes_app/presentation/state_management/note_cubit/note_cubit.dart';

import '../../../data/fake_repositories/fake_note_repository.dart';

void main() {
  late NoteCubit sut;
  late GetNoteByIdUseCase getNoteByIdUseCase;
  late FakeNoteRepository fakeNoteRepository;

  setUp(() {
    fakeNoteRepository = FakeNoteRepository();
    getNoteByIdUseCase = GetNoteByIdUseCase(fakeNoteRepository);
    sut = NoteCubit(getNoteByIdUseCase);
  });

  group('initial state', () {
    test('state is NoteInitial() when initial state', () {
      // assert
      expect(sut.state, NoteInitial());
    });

    blocTest<NoteCubit, NoteState>(
      'emits [] when nothing was done',
      build: () => sut,
      expect: () => [],
    );
  });

  group('getNoteById', () {
    blocTest<NoteCubit, NoteState>(
      'emits [NoteLoading, NoteLoadSuccess] when successful',
      build: () => sut,
      act: (cubit) => cubit.getNoteById(fakeNoteRepository.notes.first.id),
      expect: () => [NoteLoading(), isA<NoteLoadSuccess>()],
    );

    blocTest<NoteCubit, NoteState>(
      'emits [NoteLoading, NoteFailure] when failure',
      build: () => sut,
      act: (cubit) => cubit.getNoteById('wrongId'),
      expect: () => [NoteLoading(), isA<NoteFailure>()],
    );
  });
}

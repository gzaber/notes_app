import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/domain/use_cases/add_note_use_case.dart';
import 'package:notes_app/domain/use_cases/update_note_use_case.dart';
import 'package:notes_app/presentation/state_management/upsert_cubit/upsert_cubit.dart';

import '../../../data/fake_repositories/fake_note_repository.dart';

void main() {
  late UpsertCubit sut;
  late AddNoteUseCase addNoteUseCase;
  late UpdateNoteUseCase updateNoteUseCase;
  late FakeNoteRepository fakeNoteRepository;

  setUp(() {
    fakeNoteRepository = FakeNoteRepository();
    addNoteUseCase = AddNoteUseCase(fakeNoteRepository);
    updateNoteUseCase = UpdateNoteUseCase(fakeNoteRepository);
    sut = UpsertCubit(addNoteUseCase, updateNoteUseCase);
  });

  group('initial state', () {
    test('state is UpsertInitial() when initial state', () {
      // assert
      expect(sut.state, UpsertInitial());
    });

    blocTest<UpsertCubit, UpsertState>(
      'emits [] when nothing was done',
      build: () => sut,
      expect: () => [],
    );
  });

  group('addNote', () {
    blocTest<UpsertCubit, UpsertState>(
      'emits [UpsertLoading, UpsertAddSuccess] when successful',
      build: () => sut,
      act: (cubit) => cubit.addNote('title', 'content'),
      expect: () => [UpsertLoading(), isA<UpsertAddSuccess>()],
    );

    blocTest<UpsertCubit, UpsertState>(
      'emits [UpsertLoading, UpsertFailure] when failure',
      build: () => sut,
      act: (cubit) => cubit.addNote('', 'content'),
      expect: () => [UpsertLoading(), isA<UpsertFailure>()],
    );
  });

  group('updateNote', () {
    late Note note;
    blocTest<UpsertCubit, UpsertState>(
      'emits [UpsertLoading, UpsertUpdateSuccess] when successful',
      setUp: () {
        note = Note(
          id: fakeNoteRepository.notes.first.id,
          date: '2022',
          title: 'title',
          content: 'content',
        );
      },
      build: () => sut,
      act: (cubit) => cubit.updateNote(note),
      expect: () => [UpsertLoading(), isA<UpsertUpdateSuccess>()],
    );

    blocTest<UpsertCubit, UpsertState>(
      'emits [UpsertLoading, UpsertFailure] when failure',
      setUp: () {
        note = Note(
          id: fakeNoteRepository.notes.first.id,
          date: '2022',
          title: '',
          content: 'content',
        );
      },
      build: () => sut,
      act: (cubit) => cubit.updateNote(note),
      expect: () => [UpsertLoading(), isA<UpsertFailure>()],
    );
  });
}

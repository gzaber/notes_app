import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/domain/use_cases/delete_note_use_case.dart';
import 'package:notes_app/domain/use_cases/get_all_notes_use_case.dart';
import 'package:notes_app/presentation/state_management/home_cubit/home_cubit.dart';

import '../../../data/fake_repositories/fake_note_repository.dart';

void main() {
  late HomeCubit sut;
  late GetAllNotesUseCase getAllNotesUseCase;
  late DeleteNoteUseCase deleteNoteUseCase;
  late FakeNoteRepository fakeNoteRepository;

  setUp(() {
    fakeNoteRepository = FakeNoteRepository();
    getAllNotesUseCase = GetAllNotesUseCase(fakeNoteRepository);
    deleteNoteUseCase = DeleteNoteUseCase(fakeNoteRepository);
    sut = HomeCubit(getAllNotesUseCase, deleteNoteUseCase);
  });

  group('initial state', () {
    test('state is HomeInitial() when initial state', () {
      // assert
      expect(sut.state, HomeInitial());
    });

    blocTest<HomeCubit, HomeState>(
      'emits [] when nothing was done',
      build: () => sut,
      expect: () => [],
    );
  });

  group('getAllNotes', () {
    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeLoadSuccess] when notes found',
      build: () => sut,
      act: (cubit) => cubit.getAllNotes(),
      expect: () => [HomeLoading(), isA<HomeLoadSuccess>()],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeFailure] when no notes found',
      setUp: () => fakeNoteRepository.notes.clear(),
      build: () => sut,
      act: (cubit) => cubit.getAllNotes(),
      expect: () => [HomeLoading(), isA<HomeFailure>()],
    );
  });

  group('deleteNote', () {
    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeLoadSuccess] when successful',
      build: () => sut,
      act: (cubit) => cubit.deleteNote(fakeNoteRepository.notes.first.id),
      expect: () => [HomeLoading(), isA<HomeDeleteSuccess>()],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeFailure] when failure',
      setUp: () => fakeNoteRepository.notes.clear(),
      build: () => sut,
      act: (cubit) => cubit.deleteNote('wrongId'),
      expect: () => [HomeLoading(), isA<HomeFailure>()],
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/domain/use_cases/search_notes_use_case.dart';
import 'package:notes_app/presentation/state_management/search_cubit/search_cubit.dart';

import '../../../data/fake_repositories/fake_note_repository.dart';

void main() {
  late SearchCubit sut;
  late SearchNotesUseCase searchNotesUseCase;
  late FakeNoteRepository fakeNoteRepository;

  setUp(() {
    fakeNoteRepository = FakeNoteRepository();
    searchNotesUseCase = SearchNotesUseCase(fakeNoteRepository);
    sut = SearchCubit(searchNotesUseCase);
  });

  group('initial state', () {
    test('state is SearchInitial() when initial state', () {
      // assert
      expect(sut.state, SearchInitial());
    });

    blocTest<SearchCubit, SearchState>(
      'emits [] when nothing was done',
      build: () => sut,
      expect: () => [],
    );
  });

  group('searchNotes', () {
    blocTest<SearchCubit, SearchState>(
      'emits [SearchLoading, SearchLoadSuccess] when successful',
      build: () => sut,
      act: (cubit) => cubit.searchNotes('title3'),
      expect: () => [SearchLoading(), isA<SearchLoadSuccess>()],
    );

    blocTest<SearchCubit, SearchState>(
      'emits [SearchLoading, SearchFailure] when failure',
      build: () => sut,
      act: (cubit) => cubit.searchNotes('wrongPattern'),
      expect: () => [SearchLoading(), isA<SearchFailure>()],
    );
  });
}

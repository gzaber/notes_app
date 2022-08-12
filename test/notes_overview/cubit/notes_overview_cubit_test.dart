import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_app/notes_overview/cubit/notes_overview_cubit.dart';
import 'package:notes_repository/notes_repository.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

void main() {
  group('NotesOverviewCubit', () {
    late NotesRepository notesRepository;

    setUp(() {
      notesRepository = MockNotesRepository();
    });

    NotesOverviewCubit createCubit() => NotesOverviewCubit(notesRepository);

    group('constructor', () {
      test('works properly', () {
        expect(() => createCubit(), returnsNormally);
      });

      test('initial state is correct', () {
        expect(createCubit().state, equals(const NotesOverviewState()));
      });
    });

    group('getNotes', () {
      final note = Note(title: 'title');
      blocTest<NotesOverviewCubit, NotesOverviewState>(
        'emits state with success status and list of notes',
        setUp: () {
          when(() => notesRepository.getAllNotes())
              .thenAnswer((_) async => [note]);
        },
        build: () => createCubit(),
        act: (cubit) => cubit.getNotes(),
        expect: () => [
          const NotesOverviewState(status: NotesOverviewStatus.loading),
          NotesOverviewState(
              status: NotesOverviewStatus.success, notes: [note]),
        ],
        verify: (_) {
          verify(() => notesRepository.getAllNotes()).called(1);
        },
      );

      blocTest<NotesOverviewCubit, NotesOverviewState>(
        'emits state with failure status and error message',
        setUp: () {
          when(() => notesRepository.getAllNotes())
              .thenThrow(Exception('failure'));
        },
        build: () => createCubit(),
        act: (cubit) => cubit.getNotes(),
        expect: () => [
          const NotesOverviewState(status: NotesOverviewStatus.loading),
          const NotesOverviewState(
            status: NotesOverviewStatus.failure,
            errorMessage: 'Exception: failure',
          ),
        ],
        verify: (_) {
          verify(() => notesRepository.getAllNotes()).called(1);
        },
      );
    });

    group('deleteNote', () {
      final note = Note(title: 'title');
      blocTest<NotesOverviewCubit, NotesOverviewState>(
        'emits state with success status',
        setUp: () {
          when(() => notesRepository.deleteNote(any()))
              .thenAnswer((_) async {});
        },
        build: () => createCubit(),
        act: (cubit) => cubit.deleteNote(note.id),
        expect: () => [
          const NotesOverviewState(status: NotesOverviewStatus.loading),
          const NotesOverviewState(status: NotesOverviewStatus.success),
        ],
        verify: (_) {
          verify(() => notesRepository.deleteNote(note.id)).called(1);
        },
      );

      blocTest<NotesOverviewCubit, NotesOverviewState>(
        'emits state with failure status and error message',
        setUp: () {
          when(() => notesRepository.deleteNote(any()))
              .thenThrow(Exception('failure'));
        },
        build: () => createCubit(),
        act: (cubit) => cubit.deleteNote(note.id),
        expect: () => [
          const NotesOverviewState(status: NotesOverviewStatus.loading),
          const NotesOverviewState(
            status: NotesOverviewStatus.failure,
            errorMessage: 'Exception: failure',
          ),
        ],
        verify: (_) {
          verify(() => notesRepository.deleteNote(note.id)).called(1);
        },
      );
    });
  });
}

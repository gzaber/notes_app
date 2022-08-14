import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_app/manage_note/cubit/manage_note_cubit.dart';
import 'package:notes_repository/notes_repository.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

class FakeNote extends Fake implements Note {}

void main() {
  group('ManageNoteCubit', () {
    late NotesRepository notesRepository;
    final note = Note(title: 'title');

    setUp(() {
      notesRepository = MockNotesRepository();
    });

    setUpAll(() {
      registerFallbackValue(FakeNote());
    });

    ManageNoteCubit createCubit() =>
        ManageNoteCubit(notesRepository: notesRepository, note: note);

    group('constructor', () {
      test('works properly', () {
        expect(() => createCubit(), returnsNormally);
      });

      test('initial state is correct', () {
        expect(createCubit().state, equals(ManageNoteState(note: note)));
      });
    });

    group('onTitleChanged', () {
      blocTest<ManageNoteCubit, ManageNoteState>(
        'emits state with empty status when title is empty',
        build: () => createCubit(),
        act: (cubit) => cubit.onTitleChanged(''),
        expect: () =>
            [ManageNoteState(status: ManageNoteStatus.empty, note: note)],
      );

      blocTest<ManageNoteCubit, ManageNoteState>(
        'emits state with initial status and changed note title',
        build: () => createCubit(),
        act: (cubit) => cubit.onTitleChanged('changed title'),
        expect: () => [
          ManageNoteState(
              status: ManageNoteStatus.initial,
              note: note.copyWith(title: 'changed title'))
        ],
      );
    });

    group('onContentChanged', () {
      blocTest<ManageNoteCubit, ManageNoteState>(
        'emits state with initial status and changed note content',
        build: () => createCubit(),
        act: (cubit) => cubit.onContentChanged('changed content'),
        expect: () => [
          ManageNoteState(
              status: ManageNoteStatus.initial,
              note: note.copyWith(content: 'changed content'))
        ],
      );
    });

    group('createNote', () {
      blocTest<ManageNoteCubit, ManageNoteState>(
        'emits state with success status when creates note successfully',
        setUp: () {
          when(() => notesRepository.createNote(any()))
              .thenAnswer((_) async {});
        },
        build: () => createCubit(),
        act: (cubit) => cubit.createNote(),
        expect: () => [
          ManageNoteState(status: ManageNoteStatus.loading, note: note),
          ManageNoteState(status: ManageNoteStatus.success, note: note),
        ],
        verify: (_) {
          verify(() => notesRepository.createNote(note)).called(1);
        },
      );

      blocTest<ManageNoteCubit, ManageNoteState>(
        'emits state with failure status and error message when error occurs',
        setUp: () {
          when(() => notesRepository.createNote(any()))
              .thenThrow(Exception('error'));
        },
        build: () => createCubit(),
        act: (cubit) => cubit.createNote(),
        expect: () => [
          ManageNoteState(status: ManageNoteStatus.loading, note: note),
          ManageNoteState(
              status: ManageNoteStatus.failure,
              note: note,
              errorMessage: 'Exception: error'),
        ],
        verify: (_) {
          verify(() => notesRepository.createNote(note)).called(1);
        },
      );
    });

    group('updateNote', () {
      blocTest<ManageNoteCubit, ManageNoteState>(
        'emits state with success status when updates note successfully',
        setUp: () {
          when(() => notesRepository.updateNote(any()))
              .thenAnswer((_) async {});
        },
        build: () => createCubit(),
        act: (cubit) => cubit.updateNote(),
        expect: () => [
          ManageNoteState(status: ManageNoteStatus.loading, note: note),
          ManageNoteState(status: ManageNoteStatus.success, note: note),
        ],
        verify: (_) {
          verify(() => notesRepository.updateNote(note)).called(1);
        },
      );

      blocTest<ManageNoteCubit, ManageNoteState>(
        'emits state with failure status and error message when error occurs',
        setUp: () {
          when(() => notesRepository.updateNote(any()))
              .thenThrow(Exception('error'));
        },
        build: () => createCubit(),
        act: (cubit) => cubit.updateNote(),
        expect: () => [
          ManageNoteState(status: ManageNoteStatus.loading, note: note),
          ManageNoteState(
              status: ManageNoteStatus.failure,
              note: note,
              errorMessage: 'Exception: error'),
        ],
        verify: (_) {
          verify(() => notesRepository.updateNote(note)).called(1);
        },
      );
    });
  });
}

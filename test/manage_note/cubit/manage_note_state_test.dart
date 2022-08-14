import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/manage_note/cubit/manage_note_cubit.dart';
import 'package:notes_repository/notes_repository.dart';

void main() {
  group('ManageNoteState', () {
    final note = Note(title: 'title');
    ManageNoteState createState() => ManageNoteState(note: note);

    test('constructor works properly', () {
      expect(() => createState(), returnsNormally);
    });

    test('supports value equality', () {
      expect(createState(), equals(createState()));
    });

    test('props are correct', () {
      expect(
        createState().props,
        equals([ManageNoteStatus.initial, note, '']),
      );
    });

    test('creates note when not provided', () {
      expect(ManageNoteState().note, isA<Note>());
    });

    group('copyWith', () {
      test('returns the same object if no arguments are provided', () {
        expect(
          createState().copyWith(),
          equals(createState()),
        );
      });

      test('retains old parameter value if null is provided', () {
        expect(
          createState().copyWith(status: null, note: null, errorMessage: null),
          equals(createState()),
        );
      });

      test('replaces non-null parameters', () {
        expect(
          createState().copyWith(
            status: ManageNoteStatus.failure,
            note: note,
            errorMessage: 'failure',
          ),
          equals(
            ManageNoteState(
              status: ManageNoteStatus.failure,
              note: note,
              errorMessage: 'failure',
            ),
          ),
        );
      });
    });
  });
}

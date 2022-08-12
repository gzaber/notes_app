import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes_app/common/common.dart';
import 'package:notes_app/notes_overview/notes_overview.dart';
import 'package:notes_repository/notes_repository.dart';

extension PumpView on WidgetTester {
  Future<void> pumpNotesOverviewView({
    required NotesOverviewCubit notesOverviewCubit,
  }) {
    return pumpWidget(
      BlocProvider.value(
        value: notesOverviewCubit,
        child: const MaterialApp(
          home: NotesOverviewView(),
        ),
      ),
    );
  }
}

class MockNotesRepository extends Mock implements NotesRepository {}

class MockNotesOverviewCubit extends MockCubit<NotesOverviewState>
    implements NotesOverviewCubit {}

void main() {
  group('NotesOverviewPage', () {
    late NotesRepository notesRepository;

    setUp(() {
      notesRepository = MockNotesRepository();
    });

    testWidgets('renders NotesOverviewView', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: notesRepository,
          child: const MaterialApp(
            home: NotesOverviewPage(),
          ),
        ),
      );

      expect(find.byType(NotesOverviewView), findsOneWidget);
    });
  });

  group('NotesOverviewView', () {
    late NotesOverviewCubit notesOverviewCubit;

    setUp(() {
      notesOverviewCubit = MockNotesOverviewCubit();
    });

    testWidgets('renders CircularProgressIndicator when data is loading',
        (tester) async {
      when(() => notesOverviewCubit.state).thenReturn(
        const NotesOverviewState(status: NotesOverviewStatus.loading),
      );

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders MasonryGridView with 2 NoteCards '
        'when data is loaded successfully', (tester) async {
      when(() => notesOverviewCubit.state).thenReturn(
        NotesOverviewState(
          status: NotesOverviewStatus.success,
          notes: [Note(title: 'title1'), Note(title: 'title2')],
        ),
      );

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);

      expect(find.byType(MasonryGridView), findsOneWidget);
      expect(find.byType(NoteCard), findsNWidgets(2));
    });

    testWidgets('shows SnackBar with error text when error occurs',
        (tester) async {
      when(() => notesOverviewCubit.state).thenReturn(
          const NotesOverviewState(status: NotesOverviewStatus.loading));
      whenListen(
          notesOverviewCubit,
          Stream.fromIterable([
            const NotesOverviewState(
              status: NotesOverviewStatus.failure,
              errorMessage: 'error',
            )
          ]));

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.descendant(
            of: find.byType(SnackBar), matching: find.text('error')),
        findsOneWidget,
      );
    });

    testWidgets('renders AppBar with text and ElevatedButton with icon',
        (tester) async {
      when(() => notesOverviewCubit.state)
          .thenReturn(const NotesOverviewState());

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);

      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(of: find.byType(AppBar), matching: find.text('Notes')),
        findsOneWidget,
      );
      expect(
        find.descendant(
            of: find.byType(AppBar), matching: find.byType(ElevatedButton)),
        findsOneWidget,
      );
      expect(
        find.descendant(
            of: find.byType(ElevatedButton),
            matching: find.byIcon(Icons.search)),
        findsOneWidget,
      );
    });

    testWidgets('renders FloatingActionButton', (tester) async {
      when(() => notesOverviewCubit.state)
          .thenReturn(const NotesOverviewState());

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });
}

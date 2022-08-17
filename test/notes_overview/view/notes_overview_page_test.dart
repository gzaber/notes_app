import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
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
        'renders MasonryGridView with notes when data is loaded successfully',
        (tester) async {
      final note1 = Note(title: 'title1', date: '2021');
      final note2 = Note(title: 'title2', date: '2022');
      when(() => notesOverviewCubit.state).thenReturn(
        NotesOverviewState(
          status: NotesOverviewStatus.success,
          notes: [note1, note2],
        ),
      );

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);

      expect(find.byType(MasonryGridView), findsOneWidget);
      expect(find.text(note1.title), findsOneWidget);
      expect(find.text(note2.title), findsOneWidget);
      expect(find.text(note1.date), findsOneWidget);
      expect(find.text(note2.date), findsOneWidget);
    });

    testWidgets('renders MasonryGridView with notes when search notes',
        (tester) async {
      final note1 = Note(title: 'title1', date: '2021');
      final note2 = Note(title: 'title2', date: '2022');
      when(() => notesOverviewCubit.state).thenReturn(
        NotesOverviewState(
          status: NotesOverviewStatus.search,
          filteredNotes: [note1, note2],
        ),
      );

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);

      expect(find.byType(MasonryGridView), findsOneWidget);
      expect(find.text(note1.title), findsOneWidget);
      expect(find.text(note2.title), findsOneWidget);
      expect(find.text(note1.date), findsOneWidget);
      expect(find.text(note2.date), findsOneWidget);
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

    testWidgets('renders AppBar with text and search button', (tester) async {
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

    testWidgets('renders AppBar with TextField, back button and clear button',
        (tester) async {
      when(() => notesOverviewCubit.state).thenReturn(
          const NotesOverviewState(status: NotesOverviewStatus.search));

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);

      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
            of: find.byType(AppBar), matching: find.byType(TextField)),
        findsOneWidget,
      );
      expect(
        find.descendant(
            of: find.byType(AppBar),
            matching: find.byIcon(Icons.arrow_back_ios)),
        findsOneWidget,
      );
      expect(
        find.descendant(
            of: find.byType(AppBar), matching: find.byIcon(Icons.clear)),
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

    testWidgets('shows SimpleDialog with delete icon when note is long pressed',
        (tester) async {
      final note = Note(title: 'title', date: '202');

      when(() => notesOverviewCubit.state).thenReturn(
        NotesOverviewState(status: NotesOverviewStatus.success, notes: [note]),
      );

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);

      await tester.longPress(find.text(note.title));

      expect(find.byType(SimpleDialog), findsOneWidget);
      expect(
        find.descendant(
            of: find.byType(SimpleDialog), matching: find.byIcon(Icons.delete)),
        findsOneWidget,
      );
    });

    testWidgets(
        'performs note delete, pops SimpleDialog and getting all notes '
        'when SimpleDialogOption is tapped', (tester) async {
      final note = Note(title: 'title', date: '2022');
      final navigator = MockNavigator();
      when(() => navigator.pop<void>()).thenAnswer((_) async {});
      when(() => notesOverviewCubit.state).thenReturn(
        NotesOverviewState(status: NotesOverviewStatus.success, notes: [note]),
      );

      await tester.pumpWidget(
        BlocProvider.value(
          value: notesOverviewCubit,
          child: MaterialApp(
            home: MockNavigatorProvider(
              navigator: navigator,
              child: const NotesOverviewView(),
            ),
          ),
        ),
      );

      await tester.longPress(find.text(note.title));
      await tester.tap(find.byType(SimpleDialogOption));

      verify(() => navigator.pop<void>()).called(1);
      verify(() => notesOverviewCubit.deleteNote(note.id)).called(1);

      // verify(() => notesOverviewCubit.getNotes()).called(1);
    });

    testWidgets('performs turn on search when search button is tapped',
        (tester) async {
      when(() => notesOverviewCubit.state)
          .thenReturn(const NotesOverviewState());

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);

      await tester.tap(find.byIcon(Icons.search));

      verify(() => notesOverviewCubit.turnOnSearch()).called(1);
    });

    testWidgets('performs turn off search when back button is tapped',
        (tester) async {
      when(() => notesOverviewCubit.state).thenReturn(
          const NotesOverviewState(status: NotesOverviewStatus.search));

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);

      await tester.tap(find.byIcon(Icons.arrow_back_ios));

      verify(() => notesOverviewCubit.turnOffSearch()).called(1);
    });

    testWidgets('performs search when enters text', (tester) async {
      when(() => notesOverviewCubit.state).thenReturn(
          const NotesOverviewState(status: NotesOverviewStatus.search));

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);

      await tester.enterText(find.byType(TextField), 'title');

      verify(() => notesOverviewCubit.search('title')).called(1);
    });

    testWidgets('performs clear search text when clear button is tapped',
        (tester) async {
      when(() => notesOverviewCubit.state).thenReturn(
          const NotesOverviewState(status: NotesOverviewStatus.search));

      await tester.pumpNotesOverviewView(
          notesOverviewCubit: notesOverviewCubit);

      await tester.enterText(find.byType(TextField), 'title');
      await tester.tap(find.byIcon(Icons.clear));

      verify(() => notesOverviewCubit.clearSearch()).called(1);
    });

    testWidgets('routes to ManageNotePage when FloatingActionButton is tapped',
        (tester) async {
      final note1 = Note(title: 'title1', date: '2021');
      final note2 = Note(title: 'title2', date: '2022');
      final navigator = MockNavigator();
      when(() => navigator.push<void>(any())).thenAnswer((_) async {});
      when(() => notesOverviewCubit.state).thenReturn(NotesOverviewState(
          status: NotesOverviewStatus.success, notes: [note1, note2]));

      await tester.pumpWidget(
        BlocProvider.value(
          value: notesOverviewCubit,
          child: MaterialApp(
            home: MockNavigatorProvider(
              navigator: navigator,
              child: const NotesOverviewView(),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));

      verify(
        () => navigator.push<void>(
          any(that: isRoute<void>(whereName: equals('/manage'))),
        ),
      ).called(1);
    });

    testWidgets('routes to NotePage when note card is tapped', (tester) async {
      final note1 = Note(title: 'title1', date: '2021');
      final note2 = Note(title: 'title2', date: '2022');
      final navigator = MockNavigator();
      when(() => navigator.push<void>(any())).thenAnswer((_) async {});
      when(() => notesOverviewCubit.state).thenReturn(NotesOverviewState(
          status: NotesOverviewStatus.success, notes: [note1, note2]));

      await tester.pumpWidget(
        BlocProvider.value(
          value: notesOverviewCubit,
          child: MaterialApp(
            home: MockNavigatorProvider(
              navigator: navigator,
              child: const NotesOverviewView(),
            ),
          ),
        ),
      );

      await tester.tap(find.text(note1.title));

      verify(
        () => navigator.push<void>(
          any(that: isRoute<void>(whereName: equals('/note'))),
        ),
      ).called(1);
    });
  });
}

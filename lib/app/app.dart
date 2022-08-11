import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/notes_overview/notes_overview.dart';
import 'package:notes_repository/notes_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.notesRepository,
  }) : super(key: key);

  final NotesRepository notesRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: notesRepository,
      child: const NotesOverviewPage(),
    );
  }
}

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotesApp',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.theme,
      home: const NotesOverviewPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'data/data_sources/i_data_source.dart';
import 'data/data_sources/sqflite_data_source/sqflite_data_source.dart';
import 'data/database/notes_database.dart';
import 'data/repositories/note_repository.dart';
import 'domain/entities/note.dart';
import 'domain/repositories/i_note_repository.dart';
import 'domain/use_cases/use_cases.dart';
import 'presentation/state_management/home_cubit/home_cubit.dart';
import 'presentation/state_management/note_cubit/note_cubit.dart';
import 'presentation/state_management/search_cubit/search_cubit.dart';
import 'presentation/state_management/upsert_cubit/upsert_cubit.dart';
import 'presentation/ui/pages/pages.dart';

class CompositionRoot {
  static late Database _db;
  static late IDataSource _dataSource;
  static late INoteRepository _noteRepository;

  static configure() async {
    _db = await NotesDatabase().createDatabase();
    _dataSource = SqfliteDataSource(_db);
    _noteRepository = NoteRepository(_dataSource);
  }

  //================================================================================================
  static Widget composeHomePage() {
    GetAllNotesUseCase _getAllNotesUseCase = GetAllNotesUseCase(_noteRepository);
    DeleteNoteUseCase _deleteNoteUseCase = DeleteNoteUseCase(_noteRepository);
    HomeCubit _homeCubit = HomeCubit(_getAllNotesUseCase, _deleteNoteUseCase);

    return BlocProvider(
      create: (BuildContext context) => _homeCubit,
      child: const HomePage(),
    );
  }

  //================================================================================================
  static Widget composeNotePage(String id) {
    GetNoteByIdUseCase _getNoteByIdUseCase = GetNoteByIdUseCase(_noteRepository);
    NoteCubit _noteCubit = NoteCubit(_getNoteByIdUseCase);

    return BlocProvider(
      create: (BuildContext context) => _noteCubit,
      child: NotePage(id: id),
    );
  }

  //================================================================================================
  static Widget composeUpsertPage(Note? note) {
    AddNoteUseCase _addNoteUseCase = AddNoteUseCase(_noteRepository);
    UpdateNoteUseCase _updateNoteUseCase = UpdateNoteUseCase(_noteRepository);
    UpsertCubit _upsertCubit = UpsertCubit(_addNoteUseCase, _updateNoteUseCase);

    return BlocProvider(
      create: (BuildContext context) => _upsertCubit,
      child: UpsertPage(note: note),
    );
  }

  //================================================================================================
  static Widget composeSearchPage() {
    SearchNotesUseCase _searchNotesUseCase = SearchNotesUseCase(_noteRepository);
    SearchCubit _searchCubit = SearchCubit(_searchNotesUseCase);

    return BlocProvider(
      create: (BuildContext context) => _searchCubit,
      child: const SearchPage(),
    );
  }
  //================================================================================================
}

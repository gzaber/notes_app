import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/domain/use_cases/add_note_use_case.dart';
import 'package:notes_app/domain/use_cases/update_note_use_case.dart';

part 'upsert_state.dart';

class UpsertCubit extends Cubit<UpsertState> {
  final AddNoteUseCase _addNoteUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;

  UpsertCubit(this._addNoteUseCase, this._updateNoteUseCase) : super(UpsertInitial());

  addNote(String title, String content) async {
    emit(UpsertLoading());
    final result = await _addNoteUseCase(title, content);
    if (result.asError != null) {
      emit(UpsertFailure(result.asError!.error.toString()));
    } else {
      emit(UpsertAddSuccess());
    }
  }

  updateNote(Note note) async {
    emit(UpsertLoading());
    final result = await _updateNoteUseCase(note);
    if (result.asError != null) {
      emit(UpsertFailure(result.asError!.error.toString()));
    } else {
      emit(UpsertUpdateSuccess());
    }
  }
}

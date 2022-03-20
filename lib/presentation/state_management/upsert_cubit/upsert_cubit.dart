import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/note.dart';
import '../../../domain/use_cases/use_cases.dart';
import '../../helpers/constants.dart';

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
      emit(UpsertAddSuccess(kAddSuccess));
    }
  }

  updateNote(Note note) async {
    emit(UpsertLoading());
    final result = await _updateNoteUseCase(note);
    if (result.asError != null) {
      emit(UpsertFailure(result.asError!.error.toString()));
    } else {
      emit(UpsertUpdateSuccess(kUpdateSuccess));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/note.dart';
import '../../../domain/use_cases/use_cases.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final GetNoteByIdUseCase _getNoteByIdUseCase;

  NoteCubit(this._getNoteByIdUseCase) : super(NoteInitial());

  getNoteById(String id) async {
    emit(NoteLoading());
    final result = await _getNoteByIdUseCase(id);
    if (result.asError != null) {
      emit(NoteFailure(result.asError!.error.toString()));
    } else {
      emit(NoteLoadSuccess(result.asValue!.value));
    }
  }
}

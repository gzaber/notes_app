import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_repository/notes_repository.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit(this._notesRepository) : super(const NoteState());

  final NotesRepository _notesRepository;

  void getNote(String id) async {
    emit(state.copyWith(status: NoteStatus.loading));
    try {
      final result = await _notesRepository.getNote(id);
      emit(
        state.copyWith(
          status: NoteStatus.success,
          note: result,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NoteStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
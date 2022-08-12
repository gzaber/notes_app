import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_repository/notes_repository.dart';

part 'notes_overview_state.dart';

class NotesOverviewCubit extends Cubit<NotesOverviewState> {
  NotesOverviewCubit(this._notesRepository) : super(const NotesOverviewState());

  final NotesRepository _notesRepository;

  void getNotes() async {
    emit(state.copyWith(status: NotesOverviewStatus.loading));
    try {
      final notes = await _notesRepository.getAllNotes();
      emit(
        state.copyWith(
          status: NotesOverviewStatus.success,
          notes: notes,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NotesOverviewStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void deleteNote(String id) async {
    emit(state.copyWith(status: NotesOverviewStatus.loading));
    try {
      await _notesRepository.deleteNote(id);
      emit(
        state.copyWith(status: NotesOverviewStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NotesOverviewStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

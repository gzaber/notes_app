import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/domain/use_cases/delete_note_use_case.dart';
import 'package:notes_app/domain/use_cases/get_all_notes_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllNotesUseCase _getAllNotesUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;

  HomeCubit(this._getAllNotesUseCase, this._deleteNoteUseCase) : super(HomeInitial());

  getAllNotes() async {
    emit(HomeLoading());
    final result = await _getAllNotesUseCase();
    if (result.asError != null) {
      emit(HomeFailure(result.asError!.error.toString()));
    } else {
      emit(HomeLoadSuccess(result.asValue!.value));
    }
  }

  deleteNote(String id) async {
    emit(HomeLoading());
    final result = await _deleteNoteUseCase(id);
    if (result.asError != null) {
      emit(HomeFailure(result.asError!.error.toString()));
    } else {
      emit(HomeDeleteSuccess());
    }
  }
}

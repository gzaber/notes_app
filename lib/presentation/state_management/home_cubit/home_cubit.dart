import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/note.dart';
import '../../../domain/use_cases/use_cases.dart';

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

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/domain/use_cases/search_notes_use_case.dart';

import '../../../domain/entities/note.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchNotesUseCase _searchNotesUseCase;

  SearchCubit(this._searchNotesUseCase) : super(SearchInitial());

  searchNotes(String pattern) async {
    emit(SearchLoading());
    final result = await _searchNotesUseCase(pattern);
    if (result.asError != null) {
      emit(SearchFailure(result.asError!.error.toString()));
    } else {
      emit(SearchLoadSuccess(result.asValue!.value));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/note.dart';
import '../../../domain/use_cases/use_cases.dart';

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

  clearSearchResults() {
    emit(SearchLoading());
    emit(SearchLoadSuccess(const []));
  }
}

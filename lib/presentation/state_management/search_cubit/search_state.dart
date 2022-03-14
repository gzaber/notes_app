part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoadSuccess extends SearchState {
  final List<Note> notes;

  SearchLoadSuccess(this.notes);
}

class SearchFailure extends SearchState {
  final String message;

  SearchFailure(this.message);
}

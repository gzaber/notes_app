part of 'search_cubit.dart';

@immutable
abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoadSuccess extends SearchState {
  final List<Note> notes;

  SearchLoadSuccess(this.notes);

  @override
  List<Object> get props => [notes];
}

class SearchFailure extends SearchState {
  final String message;

  SearchFailure(this.message);

  @override
  List<Object> get props => [message];
}

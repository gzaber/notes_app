part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeDeleteSuccess extends HomeState {
  final String message;

  HomeDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class HomeLoadSuccess extends HomeState {
  final List<Note> notes;

  HomeLoadSuccess(this.notes);

  @override
  List<Object> get props => [notes];
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);

  @override
  List<Object> get props => [message];
}

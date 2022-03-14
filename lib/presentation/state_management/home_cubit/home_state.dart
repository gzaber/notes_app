part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final List<Note> notes;

  HomeLoadSuccess(this.notes);
}

class HomeDeleteSuccess extends HomeState {}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
}

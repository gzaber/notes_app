part of 'upsert_cubit.dart';

@immutable
abstract class UpsertState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpsertInitial extends UpsertState {}

class UpsertLoading extends UpsertState {}

class UpsertAddSuccess extends UpsertState {
  final String message;

  UpsertAddSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class UpsertUpdateSuccess extends UpsertState {
  final String message;

  UpsertUpdateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class UpsertFailure extends UpsertState {
  final String message;

  UpsertFailure(this.message);

  @override
  List<Object> get props => [message];
}

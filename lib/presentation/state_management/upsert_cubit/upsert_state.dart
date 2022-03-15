part of 'upsert_cubit.dart';

@immutable
abstract class UpsertState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpsertInitial extends UpsertState {}

class UpsertLoading extends UpsertState {}

class UpsertAddSuccess extends UpsertState {}

class UpsertUpdateSuccess extends UpsertState {}

class UpsertFailure extends UpsertState {
  final String message;

  UpsertFailure(this.message);

  @override
  List<Object> get props => [message];
}

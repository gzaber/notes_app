part of 'upsert_cubit.dart';

@immutable
abstract class UpsertState {}

class UpsertInitial extends UpsertState {}

class UpsertLoading extends UpsertState {}

class UpsertAddNoteSuccess extends UpsertState {}

class UpsertUpdateNoteSuccess extends UpsertState {}

class UpsertFailure extends UpsertState {
  final String message;

  UpsertFailure(this.message);
}

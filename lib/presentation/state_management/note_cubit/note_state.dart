part of 'note_cubit.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoadSuccess extends NoteState {
  final Note note;

  NoteLoadSuccess(this.note);
}

class NoteFailure extends NoteState {
  final String message;

  NoteFailure(this.message);
}

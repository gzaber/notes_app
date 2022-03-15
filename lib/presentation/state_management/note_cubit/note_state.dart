part of 'note_cubit.dart';

@immutable
abstract class NoteState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoadSuccess extends NoteState {
  final Note note;

  NoteLoadSuccess(this.note);

  @override
  List<Object> get props => [note];
}

class NoteFailure extends NoteState {
  final String message;

  NoteFailure(this.message);

  @override
  List<Object> get props => [message];
}

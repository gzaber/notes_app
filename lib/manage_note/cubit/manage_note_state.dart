part of 'manage_note_cubit.dart';

enum ManageNoteStatus { initial, loading, empty, success, failure }

class ManageNoteState extends Equatable {
  ManageNoteState({
    this.status = ManageNoteStatus.initial,
    Note? note,
    this.errorMessage = '',
  }) : note = note ?? Note(title: '');

  final ManageNoteStatus status;
  final Note note;
  final String errorMessage;

  @override
  List<Object?> get props => [status, note, errorMessage];

  ManageNoteState copyWith({
    ManageNoteStatus? status,
    Note? note,
    String? errorMessage,
  }) {
    return ManageNoteState(
      status: status ?? this.status,
      note: note ?? this.note,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

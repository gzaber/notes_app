part of 'notes_overview_cubit.dart';

enum NotesOverviewStatus { loading, success, failure }

class NotesOverviewState extends Equatable {
  const NotesOverviewState({
    this.status = NotesOverviewStatus.loading,
    this.notes = const [],
    this.errorMessage = '',
  });

  final NotesOverviewStatus status;
  final List<Note> notes;
  final String errorMessage;

  @override
  List<Object> get props => [status, notes, errorMessage];

  NotesOverviewState copyWith({
    NotesOverviewStatus? status,
    List<Note>? notes,
    String? errorMessage,
  }) {
    return NotesOverviewState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

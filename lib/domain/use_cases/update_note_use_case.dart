import 'package:async/async.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/domain/repositories/i_note_repository.dart';

class UpdateNoteUseCase {
  final INoteRepository _noteRepository;

  UpdateNoteUseCase(this._noteRepository);

  Future<Result<void>> call(Note note) async {
    try {
      return Result.value(await _noteRepository.update(note));
    } catch (err) {
      return Result.error(err.toString());
    }
  }
}

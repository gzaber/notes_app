import 'package:async/async.dart';

import '../entities/note.dart';
import '../error_codes.dart';
import '../repositories/i_note_repository.dart';

class GetNoteByIdUseCase {
  final INoteRepository _noteRepository;

  GetNoteByIdUseCase(this._noteRepository);

  Future<Result<Note>> call(String id) async {
    try {
      Note? note = await _noteRepository.getById(id);

      if (note == null) return Result.error(errorNoteNotFound);

      return Result.value(note);
    } catch (err) {
      return Result.error(err.toString());
    }
  }
}

import 'package:async/async.dart';

import '../entities/note.dart';
import '../error_codes.dart';
import '../repositories/i_note_repository.dart';

class UpdateNoteUseCase {
  final INoteRepository _noteRepository;

  UpdateNoteUseCase(this._noteRepository);

  Future<Result<void>> call(Note note) async {
    try {
      if (note.title.isEmpty) return Result.error(errorEmptyTitle);

      return Result.value(await _noteRepository.update(note));
    } catch (err) {
      return Result.error(err.toString());
    }
  }
}

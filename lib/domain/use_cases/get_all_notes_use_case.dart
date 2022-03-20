import 'package:async/async.dart';

import '../entities/note.dart';
import '../error_codes.dart';
import '../repositories/i_note_repository.dart';

class GetAllNotesUseCase {
  final INoteRepository _noteRepository;

  GetAllNotesUseCase(this._noteRepository);

  Future<Result<List<Note>>> call() async {
    try {
      List<Note> notes = await _noteRepository.getAll();
      if (notes.isEmpty) return Result.error(errorNoNotesFound);

      return Result.value(notes);
    } catch (err) {
      return Result.error(err.toString());
    }
  }
}

import 'package:async/async.dart';

import '../entities/note.dart';
import '../error_codes.dart';
import '../repositories/i_note_repository.dart';

class SearchNotesUseCase {
  final INoteRepository _noteRepository;

  SearchNotesUseCase(this._noteRepository);

  Future<Result<List<Note>>> call(String expression) async {
    try {
      List<Note> notes = await _noteRepository.search(expression);
      if (notes.isEmpty) return Result.error(errorNoNotesFound);

      return Result.value(notes);
    } catch (err) {
      return Result.error(err.toString());
    }
  }
}

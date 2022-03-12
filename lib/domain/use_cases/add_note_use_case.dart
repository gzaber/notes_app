import 'package:notes_app/domain/error_codes.dart';
import 'package:notes_app/domain/repositories/i_note_repository.dart';
import 'package:async/async.dart';

class AddNoteUseCase {
  final INoteRepository _noteRepository;

  AddNoteUseCase(this._noteRepository);

  Future<Result<void>> call(String title, String content) async {
    try {
      if (title.isEmpty) return Result.error(errorEmptyTitle);

      return Result.value(await _noteRepository.add(title, content));
    } catch (err) {
      return Result.error(err.toString());
    }
  }
}

import 'package:async/async.dart';

import '../repositories/i_note_repository.dart';

class DeleteNoteUseCase {
  final INoteRepository _noteRepository;

  DeleteNoteUseCase(this._noteRepository);

  Future<Result<void>> call(String id) async {
    try {
      return Result.value(await _noteRepository.delete(id));
    } catch (err) {
      return Result.error(err.toString());
    }
  }
}

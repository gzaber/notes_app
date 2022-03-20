import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({
    required String id,
    required String date,
    required String title,
    required String content,
  }) : super(id: id, date: date, title: title, content: content);

  NoteModel.newNote({
    required String title,
    required String content,
  }) : super(
            id: const Uuid().v4(),
            date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
            title: title,
            content: content);

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      date: map['date'],
      title: map['title'],
      content: map['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'content': content,
    };
  }
}

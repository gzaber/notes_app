import 'package:flutter/material.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/presentation/ui/pages/home_page.dart';
import 'package:notes_app/presentation/ui/pages/note_page.dart';
import 'package:notes_app/presentation/ui/pages/upsert_page.dart';

class CompositionRoot {
  static Widget composeHomePage() {
    return const HomePage();
  }

  static Widget composeNotePage(Note note) {
    return NotePage(note: note);
  }

  static Widget composeUpsertPage(Note? note) {
    return UpsertPage(note: note);
  }
}

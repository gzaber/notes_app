import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/composition_root.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/presentation/helpers/colors.dart';

import '../widgets/custom_elevated_button.dart';
import '../widgets/note_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          CustomElevatedButton(
            icon: Icons.search,
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CompositionRoot.composeUpsertPage(null),
            ),
          ),
          child: const Icon(Icons.add, size: 30.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildNoteList(context, testNotes),
        ),
      ),
    );
  }

  _buildNoteList(BuildContext context, List<Note> notes) => Column(
        children: List.generate(
          notes.length,
          (index) => NoteCard(
            note: notes[index],
            color: colorPalette[Random().nextInt(colorPalette.length)],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CompositionRoot.composeNotePage(notes[index]),
              ),
            ),
          ),
        ),
      );
}

List<Note> testNotes = [
  Note(
    id: 'id1',
    date: '01-01-2022',
    title: 'How to make your personal brand stand out online',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  Note(
    id: 'id2',
    date: '02-02-2022',
    title: 'Beautiful weather app UI concepts we wish existed',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  Note(
    id: 'id3',
    date: '03-03-2022',
    title: '10 excellent font pairing tools for designers',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  Note(
    id: 'id1',
    date: '01-01-2022',
    title: 'How to make your personal brand stand out online',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Note(
    id: 'id2',
    date: '02-02-2022',
    title: 'Beautiful weather app UI concepts we wish existed',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Note(
    id: 'id3',
    date: '03-03-2022',
    title: '10 excellent font pairing tools for designers',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
];

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/composition_root.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/presentation/helpers/colors.dart';
import 'package:notes_app/presentation/helpers/constants.dart';

import '../widgets/custom_elevated_button.dart';
import '../widgets/note_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kNotes),
        titleSpacing: kSidePadding,
        actions: [
          CustomElevatedButton(
            icon: Icons.search,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CompositionRoot.composeSearchPage(),
              ),
            ),
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
          padding: const EdgeInsets.symmetric(horizontal: kSidePadding),
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
            onLongPress: () => _showDeleteDialog(context),
          ),
        ),
      );

  _showDeleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => SimpleDialog(
              backgroundColor: kButtonColor,
              contentPadding: const EdgeInsets.all(8.0),
              children: [
                SimpleDialogOption(
                  onPressed: () {},
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.delete,
                    size: 30.0,
                    color: Colors.white,
                  ),
                )
              ],
            ));
  }
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

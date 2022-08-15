import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/common/common.dart';
import 'package:notes_app/manage_note/manage_note.dart';
import 'package:notes_app/note/note.dart';
import 'package:notes_app/notes_overview/cubit/notes_overview_cubit.dart';
import 'package:notes_repository/notes_repository.dart';

class NotesOverviewPage extends StatelessWidget {
  const NotesOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesOverviewCubit(
        context.read<NotesRepository>(),
      )..getNotes(),
      child: const NotesOverviewView(),
    );
  }
}

class NotesOverviewView extends StatelessWidget {
  const NotesOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          CustomElevatedButton(
            widget: const Icon(Icons.search, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 30),
        onPressed: () {
          Navigator.of(context).push<void>(ManageNotePage.route()).whenComplete(
              () => context.read<NotesOverviewCubit>().getNotes());
        },
      ),
      body: BlocConsumer<NotesOverviewCubit, NotesOverviewState>(
        listener: (context, state) {
          if (state.status == NotesOverviewStatus.failure) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: SnackBarMessage(message: state.errorMessage),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state.status == NotesOverviewStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          if (state.status == NotesOverviewStatus.success) {
            return _MasonryGridView(notes: state.notes);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _MasonryGridView extends StatelessWidget {
  const _MasonryGridView({
    Key? key,
    required this.notes,
  }) : super(key: key);

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      itemCount: notes.length,
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.symmetric(horizontal: kSidePadding),
      itemBuilder: (context, index) {
        return NoteCard(
          note: notes[index],
          color: colorPalette[Random().nextInt(colorPalette.length)],
          onTap: () {
            Navigator.of(context)
                .push<void>(NotePage.route(id: notes[index].id))
                .whenComplete(
                    () => context.read<NotesOverviewCubit>().getNotes());
          },
          onLongPress: () {
            showDialog(
                    context: context,
                    builder: (_) =>
                        _DeleteDialog(context: context, id: notes[index].id))
                .whenComplete(
                    () => context.read<NotesOverviewCubit>().getNotes());
          },
        );
      },
    );
  }
}

class _DeleteDialog extends StatelessWidget {
  const _DeleteDialog({
    Key? key,
    required this.context,
    required this.id,
  }) : super(key: key);

  final BuildContext context;
  final String id;

  @override
  Widget build(BuildContext ctx) {
    return SimpleDialog(
      backgroundColor: kButtonColor,
      contentPadding: const EdgeInsets.all(8),
      children: [
        SimpleDialogOption(
          onPressed: () {
            context.read<NotesOverviewCubit>().deleteNote(id);
            Navigator.of(context).pop<void>();
          },
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Icons.delete,
            size: 30.0,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

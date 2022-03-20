import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../composition_root.dart';
import '../../../domain/entities/note.dart';
import '../../helpers/colors.dart';
import '../../helpers/constants.dart';
import '../../state_management/home_cubit/home_cubit.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeCubit>(context).getAllNotes();
    return Scaffold(
      appBar: AppBar(
        title: const Text(kNotes),
        titleSpacing: kSidePadding,
        actions: [
          CustomElevatedButton(
              icon: Icons.search,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => CompositionRoot.composeSearchPage()))
                    .then((_) => BlocProvider.of<HomeCubit>(context).getAllNotes());
              }),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CompositionRoot.composeUpsertPage(null)))
              .then((_) => BlocProvider.of<HomeCubit>(context).getAllNotes()),
          child: const Icon(Icons.add, size: 30.0),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (state is HomeLoadSuccess) {
              return _buildMasonryGridView(context, state.notes);
            }
            if (state is HomeFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  _buildMasonryGridView(BuildContext context, List<Note> notes) => MasonryGridView.count(
        itemCount: notes.length,
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        padding: const EdgeInsets.symmetric(horizontal: kSidePadding),
        itemBuilder: (context, index) {
          return NoteCard(
            note: notes[index],
            color: colorPalette[Random().nextInt(colorPalette.length)],
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (_) => CompositionRoot.composeNotePage(notes[index].id)))
                .then((_) => BlocProvider.of<HomeCubit>(context).getAllNotes()),
            onLongPress: () => _showDeleteDialog(context, notes[index].id),
          );
        },
      );

  _showDeleteDialog(BuildContext context, String id) {
    return showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        backgroundColor: kButtonColor,
        contentPadding: const EdgeInsets.all(8.0),
        children: [
          SimpleDialogOption(
            onPressed: () {
              BlocProvider.of<HomeCubit>(context).deleteNote(id);
              Navigator.of(context).pop();
              BlocProvider.of<HomeCubit>(context).getAllNotes();
            },
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.delete,
              size: 30.0,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

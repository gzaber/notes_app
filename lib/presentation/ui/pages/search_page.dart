import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../composition_root.dart';
import '../../../domain/entities/note.dart';
import '../../helpers/colors.dart';
import '../../helpers/constants.dart';
import '../../state_management/search_cubit/search_cubit.dart';
import '../widgets/widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pattern = '';
    return Scaffold(
      appBar: AppBar(
        leadingWidth: kLeadingWidth,
        leading: CustomElevatedButton(
          icon: Icons.arrow_back_ios,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(kSearch),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                text: '',
                hintText: kTypeSomething,
                textInputAction: TextInputAction.done,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey),
                maxLines: 1,
                onChanged: (val) {
                  pattern = val;
                  if (val.isNotEmpty) {
                    BlocProvider.of<SearchCubit>(context).searchNotes(val);
                  } else {
                    BlocProvider.of<SearchCubit>(context).clearSearchResults();
                  }
                },
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (_, state) {
                    if (state is SearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                    if (state is SearchLoadSuccess) {
                      return _buildNoteList(context, state.notes, pattern);
                    }
                    if (state is SearchFailure) {
                      return Center(
                        child: Text(
                          state.message,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildNoteList(BuildContext context, List<Note> notes, String pattern) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: NoteCard(
          note: notes[index],
          color: colorPalette[Random().nextInt(colorPalette.length)],
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (_) => CompositionRoot.composeNotePage(notes[index].id)))
              .then((_) => BlocProvider.of<SearchCubit>(context).searchNotes(pattern)),
          onLongPress: () {},
        ),
      ),
    );
  }
}

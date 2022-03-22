import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../composition_root.dart';
import '../../../domain/entities/note.dart';
import '../../helpers/constants.dart';
import '../../state_management/note_cubit/note_cubit.dart';
import '../widgets/widgets.dart';

class NotePage extends StatelessWidget {
  final String id;

  const NotePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Note note;
    BlocProvider.of<NoteCubit>(context).getNoteById(id);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: kLeadingWidth,
        leading: CustomElevatedButton(
          icon: Icons.arrow_back_ios,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          CustomElevatedButton(
            icon: Icons.edit,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => CompositionRoot.composeUpsertPage(note)))
                  .then((_) => BlocProvider.of<NoteCubit>(context).getNoteById(id));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            if (state is NoteLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (state is NoteLoadSuccess) {
              note = state.note;
              return _buildNoteView(context, state.note);
            }
            if (state is NoteFailure) {
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

  SingleChildScrollView _buildNoteView(BuildContext context, Note note) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: kSidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Text(
            note.title,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                  height: 1.2,
                ),
          ),
          const SizedBox(height: 16.0),
          Text(
            note.date,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 16.0),
          Text(
            note.content,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}

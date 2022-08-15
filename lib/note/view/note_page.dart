import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/common/common.dart';
import 'package:notes_app/manage_note/manage_note.dart';
import 'package:notes_app/note/note.dart';
import 'package:notes_repository/notes_repository.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

  static Route route({required String id}) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) =>
              NoteCubit(context.read<NotesRepository>())..getNote(id),
          child: const NotePage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: kLeadingWidth,
        leading: CustomElevatedButton(
          icon: Icons.arrow_back_ios,
          onPressed: () => Navigator.of(context).pop<void>(),
        ),
        actions: [
          CustomElevatedButton(
            icon: Icons.edit,
            onPressed: () {
              if (context.read<NoteCubit>().state.note != null) {
                Navigator.of(context)
                    .push(ManageNotePage.route(
                        note: context.read<NoteCubit>().state.note))
                    .whenComplete(() => context
                        .read<NoteCubit>()
                        .getNote(context.read<NoteCubit>().state.note!.id));
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state.status == NoteStatus.failure) {
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
          if (state.status == NoteStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          if (state.status == NoteStatus.notFound) {
            return const Center(
              child: Icon(Icons.warning),
            );
          }
          if (state.status == NoteStatus.success) {
            return _NotePreview(note: state.note!);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _NotePreview extends StatelessWidget {
  const _NotePreview({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.grey),
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

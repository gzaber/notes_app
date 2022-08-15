import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/common/common.dart';
import 'package:notes_app/manage_note/manage_note.dart';
import 'package:notes_repository/notes_repository.dart';

class ManageNotePage extends StatelessWidget {
  const ManageNotePage({Key? key}) : super(key: key);

  static Route route({Note? note}) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => ManageNoteCubit(
          notesRepository: context.read<NotesRepository>(),
          note: note,
        ),
        child: const ManageNotePage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: kLeadingWidth,
          leading: CustomElevatedButton(
            widget: const Icon(Icons.arrow_back_ios, size: 30),
            onPressed: () => Navigator.of(context).pop<void>(),
          ),
          actions: [
            CustomElevatedButton(
              widget: Text('Save',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white)),
              onPressed: () {
                if (context.read<ManageNoteCubit>().state.mode ==
                    ManageNoteMode.create) {
                  context.read<ManageNoteCubit>().createNote();
                } else {
                  context.read<ManageNoteCubit>().updateNote();
                }
              },
            ),
          ],
        ),
        body: BlocConsumer<ManageNoteCubit, ManageNoteState>(
          listener: (context, state) {
            if (state.status == ManageNoteStatus.empty) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: SnackBarMessage(message: 'Title cannot be empty'),
                  ),
                );
            }
            if (state.status == ManageNoteStatus.failure) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: SnackBarMessage(message: state.errorMessage),
                  ),
                );
            }
            if (state.status == ManageNoteStatus.success) {
              Navigator.of(context).pop<void>();
            }
          },
          builder: (context, state) {
            if (state.status == ManageNoteStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return const _NoteForm();
          },
        ));
  }
}

class _NoteForm extends StatelessWidget {
  const _NoteForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: kSidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            textFieldKey: const Key('manageNotePage_title_TextField'),
            controller: TextEditingController(
                text: context.read<ManageNoteCubit>().state.note.title),
            hintText: 'Title',
            textInputAction: TextInputAction.next,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.grey),
            maxLines: 3,
            onChanged: (val) {
              context.read<ManageNoteCubit>().onTitleChanged(val);
            },
          ),
          CustomTextField(
            textFieldKey: const Key('manageNotePage_content_TextField'),
            controller: TextEditingController(
                text: context.read<ManageNoteCubit>().state.note.content),
            hintText: 'Type something...',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.grey),
            maxLines: 15,
            onChanged: (val) {
              context.read<ManageNoteCubit>().onContentChanged(val);
            },
          ),
        ],
      ),
    );
  }
}

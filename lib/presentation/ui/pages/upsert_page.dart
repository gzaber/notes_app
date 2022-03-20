import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/note.dart';
import '../../helpers/constants.dart';
import '../../state_management/upsert_cubit/upsert_cubit.dart';
import '../widgets/widgets.dart';

class UpsertPage extends StatelessWidget {
  final Note? note;
  const UpsertPage({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UpsertCubit upsertCubit = BlocProvider.of<UpsertCubit>(context);
    String title = note != null ? note!.title : '';
    String content = note != null ? note!.content : '';

    return Scaffold(
      appBar: AppBar(
        leadingWidth: kLeadingWidth,
        leading: CustomElevatedButton(
          icon: Icons.arrow_back_ios,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          CustomElevatedButton(
            icon: Icons.save,
            onPressed: () {
              if (note == null) {
                upsertCubit.addNote(title, content);
              } else {
                upsertCubit.updateNote(
                  Note(
                    id: note!.id,
                    date: note!.date,
                    title: title,
                    content: content,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocListener<UpsertCubit, UpsertState>(
          listener: (context, state) {
            if (state is UpsertLoading) {
              _showLoader(context);
            }
            if (state is UpsertAddSuccess) {
              _hideLoader(context);
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.of(context).pop();
            }
            if (state is UpsertUpdateSuccess) {
              _hideLoader(context);
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.of(context).pop();
            }
            if (state is UpsertFailure) {
              _hideLoader(context);
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: kSidePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  text: title,
                  hintText: kTitle,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey),
                  maxLines: 3,
                  onChanged: (val) {
                    title = val;
                  },
                ),
                CustomTextField(
                  text: content,
                  hintText: kTypeSomething,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey),
                  maxLines: 15,
                  onChanged: (val) {
                    content = val;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showLoader(BuildContext context) {
    var alert = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white70,
        ),
      ),
    );

    showDialog(context: context, barrierDismissible: true, builder: (_) => alert);
  }

  _hideLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

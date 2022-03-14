import 'package:flutter/material.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/presentation/helpers/constants.dart';

import '../widgets/custom_elevated_button.dart';

class UpsertPage extends StatelessWidget {
  final Note? note;
  const UpsertPage({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kSidePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: TextEditingController(text: title),
                cursorColor: Colors.white,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: kTitle,
                  hintStyle:
                      Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey),
                ),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey),
                minLines: 1,
                maxLines: 5,
              ),
              TextField(
                controller: TextEditingController(text: content),
                cursorColor: Colors.white,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: kTypeSomething,
                  hintStyle:
                      Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey),
                ),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey),
                minLines: 1,
                maxLines: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

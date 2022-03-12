import 'package:flutter/material.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/presentation/ui/widgets/custom_elevated_button.dart';

import '../../../composition_root.dart';

class NotePage extends StatelessWidget {
  final Note note;

  const NotePage({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 105.0,
        leading: CustomElevatedButton(
          icon: Icons.arrow_back_ios,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          CustomElevatedButton(
            icon: Icons.edit,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CompositionRoot.composeUpsertPage(note),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10.0),
              Text(note.date,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey)),
              const SizedBox(height: 10.0),
              Text(
                note.content,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

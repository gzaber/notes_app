import 'package:flutter/material.dart';
import 'package:notes_app/presentation/helpers/constants.dart';

import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kSidePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                text: '',
                hintText: kTypeSomething,
                textInputAction: TextInputAction.done,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomSnackBar {
  static show(BuildContext context, String message) {
    return SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
      ),
    );
  }
}

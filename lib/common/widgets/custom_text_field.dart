import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.textFieldKey,
    required this.controller,
    required this.hintText,
    required this.style,
    required this.maxLines,
    this.textInputAction = TextInputAction.newline,
    required this.onChanged,
  }) : super(key: key);

  final Key? textFieldKey;
  final TextEditingController controller;
  final String hintText;
  final TextStyle style;
  final int maxLines;
  final TextInputAction textInputAction;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: textFieldKey,
      controller: controller,
      cursorColor: Colors.white,
      keyboardType: TextInputType.multiline,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        hintStyle: style,
      ),
      style: style,
      minLines: 1,
      maxLines: maxLines,
      onChanged: onChanged,
    );
  }
}

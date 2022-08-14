import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextStyle style;
  final int maxLines;
  final TextInputAction textInputAction;
  final Function(String) onChanged;
  final Key? textFieldKey;

  const CustomTextField({
    Key? key,
    this.textFieldKey,
    required this.text,
    required this.hintText,
    required this.style,
    required this.maxLines,
    required this.onChanged,
    this.textInputAction = TextInputAction.newline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: textFieldKey,
      controller: TextEditingController(text: text),
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

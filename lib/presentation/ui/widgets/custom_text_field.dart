import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextStyle style;
  final int maxLines;
  final TextInputAction textInputAction;

  const CustomTextField({
    Key? key,
    required this.text,
    required this.hintText,
    required this.style,
    required this.maxLines,
    this.textInputAction = TextInputAction.newline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: text),
      cursorColor: Colors.white,
      keyboardType: TextInputType.multiline,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintStyle: style,
      ),
      style: style,
      minLines: 1,
      maxLines: maxLines,
    );
  }
}

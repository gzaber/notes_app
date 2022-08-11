import 'package:flutter/material.dart';
import 'package:notes_app/common/common.dart';

class CustomElevatedButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;

  const CustomElevatedButton({
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(kSidePadding, 16.0, kSidePadding, 16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Icon(icon, size: 30.0),
        style: ElevatedButton.styleFrom(primary: kButtonColor),
      ),
    );
  }
}

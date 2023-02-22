import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../dimensions/app_dimensions.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget widget;
  final Function() onPressed;

  const CustomElevatedButton({
    required this.widget,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.sidePadding,
        16.0,
        AppDimensions.sidePadding,
        16.0,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: widget,
      ),
    );
  }
}

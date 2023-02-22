import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../dimensions/app_dimensions.dart';

abstract class AppTheme {
  static final theme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.black,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        toolbarHeight: AppDimensions.appBarHeight,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(fontSize: 40, color: Colors.white)),
    scaffoldBackgroundColor: Colors.black,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.buttonColor),
  );
}

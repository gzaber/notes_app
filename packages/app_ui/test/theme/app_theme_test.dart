import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    final theme = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Colors.black,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          toolbarHeight: AppDimensions.appBarHeight,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: const TextStyle(fontSize: 32, color: Colors.white)),
      scaffoldBackgroundColor: Colors.black,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.buttonColor),
    );

    test('has correct theme', () {
      expect(AppTheme.theme, equals(theme));
    });
  });
}

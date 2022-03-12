import 'package:flutter/material.dart';
import 'package:notes_app/composition_root.dart';

void main() {
  runApp(
    MyApp(
      startPage: CompositionRoot.composeHomePage(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startPage;
  const MyApp({Key? key, required this.startPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          toolbarHeight: 80.0,
          elevation: 0.0,
          titleTextStyle: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.black,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.black),
      ),
      home: startPage,
    );
  }
}

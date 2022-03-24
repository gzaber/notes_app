import 'package:flutter/material.dart';

import 'composition_root.dart';
import 'presentation/helpers/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CompositionRoot.configure();

  runApp(
    MyApp(startPage: CompositionRoot.composeHomePage()),
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
          centerTitle: false,
          titleTextStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.black,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: kButtonColor),
      ),
      home: startPage,
    );
  }
}

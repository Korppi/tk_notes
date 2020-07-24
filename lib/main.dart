import 'package:flutter/material.dart';
import 'package:tk_notes/services/serviceLocator.dart';
import 'package:tk_notes/views/notesListView.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('myapp build');
    return MaterialApp(
      title: 'TK Notes',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NotesListView(),
    );
  }
}

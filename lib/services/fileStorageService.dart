import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tk_notes/core/models/note.dart';

class FileStorageService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/notes.json');
  }

  Future<List<Note>> readNotes() async {
    try {
      final file = await _localFile;
      bool exists = await file.exists();
      debugPrint('exists: $exists');
      if (exists) {
        String contents = await file.readAsString();
        var parsed = jsonDecode(contents);
        List<Note> notes = List<Note>.from(parsed.map((i) => Note.fromJson(i)));
        return List<Note>.from(notes);
      }
    } catch (e) {
      debugPrint('error reading: $e');
    }
    return List<Note>();
  }

  saveNotes(List<Note> notes) async {
    try {
      final file = await _localFile;
      debugPrint('jsonEncode(notes): ' + jsonEncode(notes));
      file.writeAsString(jsonEncode(notes));
    } catch (e) {
      debugPrint('error saving: $e');
    }
  }
}

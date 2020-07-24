import 'package:flutter/material.dart';
import 'package:tk_notes/core/models/note.dart';
import 'package:tk_notes/core/providers/NotesProvider.dart';
import 'package:tk_notes/services/fileStorageService.dart';
import 'package:tk_notes/services/serviceLocator.dart';

class NotesEditViewModel extends ChangeNotifier {
  NotesProvider notesProvider;
  FileStorageService fss;
  Note note;
  bool newNote;
  
  NotesEditViewModel(int index) {
    this.notesProvider = serviceLocator<NotesProvider>();
    this.fss = serviceLocator<FileStorageService>();
    if (index >= 0) {
      this.note = this.notesProvider.getNote(index);
      newNote = false;
    } else {
      this.note = Note();
      newNote = true;
      this.notesProvider.addNote(this.note);
    }
  }

  void copyText(String text){
    this.note.text = text;
  }

  void save() {
    fss.saveNotes(this.notesProvider.notes);
  } 
}
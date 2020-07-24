import 'package:flutter/cupertino.dart';
import 'package:tk_notes/core/models/note.dart';

class NotesProvider {
  final List<Note> _notes = List<Note>();
  
  NotesProvider() {
    debugPrint('notes provider constructor');
  }

  void copyList(List<Note> data) {
    data.forEach((note) {
      this._notes.add(note);
    });
  }

  Note getNote(int index) {
    return _notes[index];
  }

  int getNotesCount() {
    return _notes.length;
  }

  void deleteNote(Note note) {
    if (this._notes.contains(note)) {
      this._notes.remove(note);
    }
  }

  List<Note> get notes => this._notes;

  void addNote(Note note) {
    this._notes.add(note);
  }
}

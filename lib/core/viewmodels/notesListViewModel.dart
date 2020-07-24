import 'package:flutter/material.dart';
import 'package:tk_notes/core/models/note.dart';
import 'package:tk_notes/core/providers/NotesProvider.dart';
import 'package:tk_notes/services/fileStorageService.dart';
import 'package:tk_notes/services/serviceLocator.dart';

class NotesListViewModel extends ChangeNotifier {
  FileStorageService fss = serviceLocator<FileStorageService>();
  NotesProvider _notesProvider;
  List<Note> selected = List<Note>();

  NotesListViewModel() {
    this._notesProvider = serviceLocator<NotesProvider>();
  }

  Future<List<Note>> initializeNotes() async {
    return fss.readNotes();
  }

  void addNotes(List<Note> data) {
    debugPrint('lets copy data');
    _notesProvider.copyList(data);
  }

  String getNoteText(int index) {
    return _notesProvider.getNote(index).text;
  }

  int getNotesCount() {
    return _notesProvider.getNotesCount();
  }

  void select(int index) {
    debugPrint('added to selected');
    this.selected.add(this._notesProvider.getNote(index));
    notifyListeners();
  }

  void unSelect(int index) {
    debugPrint('removed from selected');
    this.selected.remove(this._notesProvider.getNote(index));
    notifyListeners();
  }

  List<Note> getSelection() {
    return this.selected;
  }

  Note getNote(int index) {
    return this._notesProvider.getNote(index);
  }

  void selectAll() {
    this.selected.clear();
    this._notesProvider.notes.forEach((element) {
      this.selected.add(element);
    });
    notifyListeners();
  }

  void deleteSelected() {
    this.selected.forEach((element) {
      this._notesProvider.deleteNote(element);
    });
    this.selected.clear();
    notifyListeners();
    fss.saveNotes(this._notesProvider.notes);
  }
}

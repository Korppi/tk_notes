import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tk_notes/core/viewmodels/notesEditViewModel.dart';

class NotesEditView extends StatelessWidget {
  final int index;

  NotesEditView({this.index = -1});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesEditViewModel(index),
      builder: (context, model) {
        debugPrint('changenotifierprovider builder');
        return _getScaffold(context);
      },
    );
  }

  _getScaffold(BuildContext context) {
    TextEditingController tec = TextEditingController();
    tec.text = Provider.of<NotesEditViewModel>(context, listen: false).note.text;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              debugPrint('back button pressed');
              Provider.of<NotesEditViewModel>(context, listen: false).copyText(tec.text);
              Provider.of<NotesEditViewModel>(context, listen: false).save();
              Navigator.of(context).pop(context);
            }),
        title: Text('Note'),
      ),
      body: Container(
        color: Colors.amber[100],
        child: TextField(
          controller: tec,
          keyboardType: TextInputType.multiline,
          expands: true,
          minLines: null,
          maxLines: null,
        ),
      ),
    );
  }
}

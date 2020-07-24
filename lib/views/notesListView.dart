import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tk_notes/core/viewmodels/notesListViewModel.dart';
import 'package:tk_notes/views/notesEditView.dart';

class NotesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('notes list view build');
    return ChangeNotifierProvider(
      create: (context) => NotesListViewModel(),
      builder: (context, model) {
        debugPrint('changenotifierprovider builder');
        return _getScaffold(context);
      },
    );
  }

  _getScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TK Notes'),
      ),
      floatingActionButton:
          Consumer<NotesListViewModel>(builder: (context, model, child) {
        if (model.selected.length >= 1) {
          return _getDeleteFBA(context, model);
        } else {
          return _getAddFBA(context, model);
        }
      }),
      body: _getFutureBuilder(context),
    );
  }

  _getDeleteFBA(BuildContext context, NotesListViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
            child: Icon(Icons.delete),
            onPressed: () {
              model.deleteSelected();
            }),
        SizedBox(
          height: 16,
        ),
        FloatingActionButton(
            child: Icon(Icons.select_all),
            onPressed: () {
              model.selectAll();
            }),
      ],
    );
  }

  _getAddFBA(BuildContext context, NotesListViewModel model) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          debugPrint('FAB pressed');
          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotesEditView()),
                      ).then((value) => model.notifyListeners()); 
        });
  }

  _getFutureBuilder(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<NotesListViewModel>(context, listen: false)
            .initializeNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            debugPrint('connectionstate.done');
            if (snapshot.hasData) {
              debugPrint('snapshot has data');
              Provider.of<NotesListViewModel>(context, listen: false)
                  .addNotes(snapshot.data);
            } else {
              debugPrint('snapshot dont have data');
            }
            return _getListView(context);
          } else {
            if (snapshot.connectionState == ConnectionState.none) {
              debugPrint('connectionstate.none');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              debugPrint('connectionstate.waiting');
            }
            if (snapshot.connectionState == ConnectionState.active) {
              debugPrint('connectionstate.active');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  _getListView(BuildContext context) {
    return Consumer<NotesListViewModel>(
      builder: (context, model, child) {
        debugPrint('consumer builder');
        return ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  leading: model.selected.length > 0
                      ? Checkbox(
                          value: model.selected.contains(model.getNote(index)),
                          onChanged: (selected) {
                            if (!selected) {
                              model.unSelect(index);
                            } else {
                              model.select(index);
                            }
                          })
                      : null,
                  title: Text(model.getNoteText(index)),
                  onTap: () {
                    debugPrint('pressed $index');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotesEditView(index: index)),
                      );
                  },
                  onLongPress: () {
                    debugPrint('long pressed $index');
                    model.select(index);
                  },
                ),
            separatorBuilder: (context, index) => Divider(),
            itemCount: model.getNotesCount());
      },
    );
  }
}

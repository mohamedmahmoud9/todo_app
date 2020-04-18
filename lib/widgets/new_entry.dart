import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/entry.dart';
import 'package:todoapp/providers/entries.dart';

class NewEntry extends StatelessWidget {
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final EntryCategory category;
  NewEntry(this.category);

  @override
  Widget build(BuildContext context) {
    final entries = Provider.of<Entries>(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      color: Color(0xff0bb3d4),
                    )),
                controller: _titleController,
                // onSubmitted: (_) => submitData(),
                textInputAction: TextInputAction.next,
              ),
              TextField(
                // focusNode: focus,
                
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color: Color(0xff0bb3d4),
                    )),
                controller: _amountController,
                // keyboardType: TextInputType.numberWithOptions(decimal: true),
                // textInputAction: TextInputAction.done,
              ),
              FlatButton(
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Color(0xff0bb3d4),
                  ),
                ),
                onPressed: () {
                  entries.addEntry(
                      _titleController.text, _amountController.text, category);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

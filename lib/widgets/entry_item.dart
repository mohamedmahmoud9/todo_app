

import 'package:todoapp/providers/entries.dart';

import '../models/entry.dart';
// import './new_entry.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class EntryItem extends StatelessWidget {
  // final Entry entry;
  // EntryItem(this.entry);

  @override
  Widget build(BuildContext context) {
    final entry = Provider.of<Entry>(context);
    final entries = Provider.of<Entries>(context);
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) => Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(8),
                                            alignment: AlignmentDirectional.center,

                          width: double.infinity,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                     color: Color(0xff0bb3d4),
                          // ),
                          child: Text(
                            entry.title,
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          entry.description,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          child: entry.isCompleted
                              ? Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                        'This task is already completed!',
                                        style: TextStyle(color: Color(0xff0bb3d4)),
                                      
                                      ),
                                  ),
                                    Divider(),
                                    FlatButton(
                                          child: Text('Ok',style: TextStyle(color:Color(0xff0bb3d4)),),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                ],
                              )
                              :
                               Column(
                                    children: <Widget>[
                                       Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child:
                                      Text(
                                        'This task is not completed yet!\nDid you complete this?',
                                        style:
                                            TextStyle(color: Color(0xffff7272)),
                                      ),),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          FlatButton(
                                            child: Text('No',style: TextStyle(color:Color(0xffff7272))),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Yes',style: TextStyle(color:Color(0xff0bb3d4))),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              // entry.completeToggle();
                                              entries.updateEntry(entry.id);
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                              )
                    ],
                  ),
                ));
      },
      child: Column(
        children: <Widget>[
          Dismissible(
            key: ValueKey(entry.id),
            direction: DismissDirection.endToStart,
            onDismissed: (dirction) {
              entries.removeEntry(entry.id);
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20, top: 8, bottom: 8),
              decoration: BoxDecoration(
                //  color: Colors.red,
                borderRadius: BorderRadius.circular(30),
                // color: Color(0xffececec),
              ),
              child: Icon(
                Icons.delete,
                color: Color(0xffff7272),
              ),
            ),
            confirmDismiss: (dirction) {
              return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text(
                          'Do you want to remove this item?',
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: const Text(
                              'No',
                              style: TextStyle(color: Color(0xff0bb3d4)),
                            ),
                            onPressed: () {
                              Navigator.of(ctx).pop(false);
                            },
                          ),
                          FlatButton(
                            child: const Text(
                              'Yes',
                              style: TextStyle(color: Color(0xffff7272)),
                            ),
                            onPressed: () {
                              Navigator.of(ctx).pop(true);
                            },
                          )
                        ],
                      ));
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xffececec),
              ),

              // height: 10,
              width: double.infinity,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Consumer<Entry>(
                    builder: (ctx, entry, ch) => GestureDetector(
                      onTap: () {
                        // entries.completeToggle();
                        //  entries.ongoingItemsByCategory(entry.category).length;
                        //  entries.completedItemsByCategory(entry.category).length;
                        // entries.refresh(entry.category);
                        entries.updateEntry(entry.id);
                      },
                      child: entry.isCompleted
                          ? CircleAvatar(
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                              backgroundColor: Color(0xff0bb3d4),
                            )
                          : CircleAvatar(
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.grey,
                            ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    entry.title,
                    style: TextStyle(fontSize: 25, color: Colors.black54),
                  ),
                  //  Consumer<Entry>(
                  //    builder: (ctx,entry,_)=> IconButton(icon: Icon(Icons.delete),onPressed: (){
                  //         // entries.removeEntry(entry.id);
                  //         entries.refresh(entry.category,id:entry.id);
                  //       },),
                  //  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

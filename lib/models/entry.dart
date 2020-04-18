import 'package:flutter/foundation.dart';

import 'package:todoapp/providers/entries.dart';

enum EntryCategory {
  work,
  personal,
  home,
  office,
}

class Entry with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final EntryCategory category;
  bool isCompleted;
  Entry(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.category,
      this.isCompleted = false});
 
   Map<String, dynamic> toMap() {
    return {
      'id': id,
          'title': title,
          'description': description,
          'isCompleted': isCompleted?1:0 ,
          'category': Entries.categorytoSql(category)
    };
  }
}


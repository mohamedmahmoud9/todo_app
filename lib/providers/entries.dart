import 'package:flutter/cupertino.dart';
import 'package:todoapp/helpers/db_helper.dart';

import '../models/entry.dart';

class Entries with ChangeNotifier {
  List<Entry> _items = [];
  List<Entry> get items {
    return [..._items];
  }

  int get totalCompletedItems {
    return _items.where((item) => item.isCompleted).toList().length;
  }

  int get totalOngoingItems {
    return items.length - totalCompletedItems;
  }

  void removeEntry(String id) {
    final existingEntryIndex = _items.indexWhere((prod) => prod.id == id);
    _items.removeAt(existingEntryIndex);
    notifyListeners();
    DBHelper.deleteEntry(id);
  }

  void addEntry(
    String title,
    String description,
    EntryCategory category,
  ) {
    final newEntry = Entry(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        category: category);
    _items.add(newEntry);
    notifyListeners();
    DBHelper.insert('user_entries', {
      'id': newEntry.id,
      'title': newEntry.title,
      'description': newEntry.description,
      'isCompleted': isCompletedtoSql(newEntry.isCompleted),
      'category': categorytoSql(newEntry.category)
    });
  }

  Future<void> updateEntry(String id) async {
    Entry entry = findById(id);
    entry.isCompleted = !entry.isCompleted;
    notifyListeners();
    await DBHelper.updateEntry(entry);
    
  }

  static int categorytoSql(EntryCategory entryCategory) {
    if (entryCategory == EntryCategory.home) {
      return 1;
    } else if (entryCategory == EntryCategory.office) {
      return 2;
    } else if (entryCategory == EntryCategory.personal) {
      return 3;
    }
    //work
    else {
      return 4;
    }
  }

  EntryCategory categoryfromSql(int categoryNum) {
    if (categoryNum == 1) {
      return EntryCategory.home;
    } else if (categoryNum == 2) {
      return EntryCategory.office;
    } else if (categoryNum == 3) {
      return EntryCategory.personal;
    }
    //work
    else {
      return EntryCategory.work;
    }
  }

  int isCompletedtoSql(bool isCompleted) {
    return isCompleted ? 1 : 0;
  }

  bool isCompletedformSql(int isCompleted) {
    return isCompleted == 1 ? true : false;
  }

  Future<void> fetchAndSetEntries() async {
    final dataList = await DBHelper.getData('user_entries');
    _items = dataList
        .map(
          (item) => Entry(
              id: item['id'],
              title: item['title'],
              description: item['description'],
              isCompleted: isCompletedformSql(item['isCompleted']),
              category: categoryfromSql(item['category'])),
        )
        .toList();
    notifyListeners();
  }

  List<Entry> completedItemsByCategory(EntryCategory entryCategory) {
    return _items
        .where((item) => item.category == entryCategory && item.isCompleted)
        .toList();
  }

  List<Entry> allItems(EntryCategory entryCategory) {
    return ongoingItemsByCategory(entryCategory) +
        completedItemsByCategory(entryCategory);
  }

  List<Entry> ongoingItemsByCategory(EntryCategory entryCategory) {
    return _items
        .where((item) => item.category == entryCategory && !item.isCompleted)
        .toList();
  }

  Entry findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }
}

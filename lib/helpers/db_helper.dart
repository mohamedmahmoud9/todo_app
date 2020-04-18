import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:todoapp/models/entry.dart';


class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'entries.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_entries(id TEXT PRIMARY KEY, title TEXT, description TEXT, isCompleted INTEGER, category INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  // static Future<void> update(String table,Map<String, Object> newValues,String id)async{
  //   final db = await DBHelper.database();
  //   db.update(table, newValues,where: 'id=$id');
  // }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  // static Future<void> update(
  //     String table, Map<String, Object> newValues, String id) async {
  //   final db = await DBHelper.database();

  //   db.update('user_entries', newValues, where: 'id = $id',whereArgs: [id]);
  // }
  static Future<void> updateEntry(Entry entry) async {
    // Get a reference to the database.
    final db = await DBHelper.database();

    // Update the given Dog.
    await db.update(
      'user_entries',
      entry.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [entry.id],
    );
  }

  static Future<void> deleteEntry(String id) async {
    // Get a reference to the database.
    final db = await DBHelper.database();

    // Remove the Dog from the database.
    await db.delete(
      'user_entries',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}

import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "task";
  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = '${await getDatabasesPath()}tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("Creating a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, note TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "remind INTEGER, repeat STRING, "
            "color INTEGER, "
            "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("Insert Function called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  // get all tasks from database
  static Future<List<Map<String, dynamic>>> query() async {
    print("Query Function called");
    List<Map<String, dynamic>> tasks = await _db!.query(_tableName);
    return tasks;
  }

  // delete task from database
  static Future<void> delete(int id) async {
    print("Remove Function called");
    await _db!.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  //update task from database
  static Future<void> updateCompletedStatus(int id) async {
    print("Update status Function called");
    await _db!.rawUpdate('''
      UPDATE $_tableName SET isCompleted = ? WHERE id = ?
    ''', [1, id]);
  }

  //update task from database
  static Future<void> update(Task? task) async {
    print("Update Function called");
    await _db!.update(
      _tableName,
      task!.toJson(),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  // delete all tasks from database
  static Future<void> deleteAll() async {
    print("Delete All Function called");
    await _db!.delete(_tableName);
  }
}

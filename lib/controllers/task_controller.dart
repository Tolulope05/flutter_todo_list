import 'package:flutter/material.dart';
import 'package:flutter_todo_list/const/theme.dart';
import 'package:flutter_todo_list/db/db_helper.dart';
import 'package:flutter_todo_list/models/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  List<Task> taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  // get all the data from table
  Future<void> getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  // delete task from table
  Future<void> deleteTask({id}) async {
    await DBHelper.delete(id);
    getTasks();
  }

  //update Status from table
  Future<void> updateCompletedStatus({id}) async {
    await DBHelper.updateCompletedStatus(id);
    getTasks();
  }

  // update task from table
  Future<void> updateTask({Task? task}) async {
    await DBHelper.update(task);
    getTasks();
  }

  // delete all tasks from table
  Future<void> deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTasks();
  }
}

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
    print(tasks);
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }
}
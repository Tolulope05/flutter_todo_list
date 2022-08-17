import 'package:flutter/material.dart';
import 'package:flutter_todo_list/const/styles.dart';
import 'package:flutter_todo_list/const/theme.dart';
import 'package:flutter_todo_list/controllers/task_controller.dart';
import 'package:flutter_todo_list/models/task.dart';
import 'package:flutter_todo_list/widgets/button.dart';
import 'package:flutter_todo_list/widgets/input_field.dart';
import 'package:get/get.dart';

class UpdateTaskPage extends StatefulWidget {
  final Task task;
  const UpdateTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  State<UpdateTaskPage> createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  List<Color> colors = [
    primarycolor,
    pinkColor,
    yellowColor,
    greenColor,
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.only(
          right: 20.0,
          left: 20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Update Task",
                style: headingStyle,
              ),
              MyInputField(
                title: "Title",
                hint: "Enter your task title",
                controller: _titleController,
                updateValue: widget.task.title,
              ),
              MyInputField(
                title: "Note",
                hint: "Enter your task note",
                controller: _noteController,
                isNote: true,
                updateValue: widget.task.note,
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // _colorPallete(),
                    MyButton(
                      label: "Update Task",
                      onTap: () {
                        _validateData();
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30, width: double.maxFinite),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            // backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/images/profile.png"),
          ),
        )
      ],
    );
  }

  void _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDB();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all the fields",
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 8,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(8),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void _addTaskToDB() async {
    _taskController.updateTask(
      task: Task(
        id: widget.task.id,
        title: _titleController.text,
        note: _noteController.text,
        date: widget.task.date,
        startTime: widget.task.startTime,
        endTime: widget.task.endTime,
        remind: widget.task.remind,
        color: widget.task.color,
        repeat: widget.task.repeat,
      ),
    );
  }
}

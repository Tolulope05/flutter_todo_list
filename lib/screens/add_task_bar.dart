import 'package:flutter/material.dart';
import 'package:flutter_todo_list/const/styles.dart';
import 'package:flutter_todo_list/const/theme.dart';
import 'package:flutter_todo_list/controllers/task_controller.dart';
import 'package:flutter_todo_list/models/task.dart';
import 'package:flutter_todo_list/widgets/button.dart';
import 'package:flutter_todo_list/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now());
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Month"];
  List<Color> colors = [
    primarycolor,
    pinkColor,
    yellowColor,
    greenColor,
  ];

  int _selectedColor = 0;
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
                "Add Task",
                style: headingStyle,
              ),
              MyInputField(
                title: "Title",
                hint: "Enter your task title",
                controller: _titleController,
              ),
              MyInputField(
                title: "Note",
                hint: "Enter your task note",
                controller: _noteController,
              ),
              MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                  onPressed: () async {
                    DateTime? _pickedDate = await _getDateFromUser();
                    if (_pickedDate != null) {
                      selectedDate = _pickedDate;
                    }
                    print(selectedDate);
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: greyColor,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_outlined,
                          color: greyColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MyInputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_outlined,
                          color: greyColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: greyColor,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRemind = int.parse(value!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              MyInputField(
                title: "Repeat",
                hint: _selectedRepeat,
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: greyColor,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRepeat = value!;
                    });
                  },
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _colorPallete(),
                    MyButton(
                      label: "Create Task",
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

  Column _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        SizedBox(height: 8),
        Wrap(
          children: List<Widget>.generate(colors.length, (index) {
            return GestureDetector(
              onTap: () {
                _selectedColor = index;
                setState(() {});
                print(_selectedColor);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: colors[index],
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          color: white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
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

  Future<DateTime?> _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(2100),
    );
    if (_pickedDate != null) {
      setState(() {
        selectedDate = _pickedDate;
      });
      return selectedDate;
    }
  }

  Future<TimeOfDay?> _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await _showTimePicker(isStartTime: isStartTime);

    if (_pickedTime != null) {
      String _formattedTime = _pickedTime.format(context);
      setState(() {
        if (isStartTime) {
          _startTime = _formattedTime;
        } else {
          _endTime = _formattedTime;
        }
      });
      return _pickedTime;
    }
  }

  Future<TimeOfDay?> _showTimePicker({required bool isStartTime}) {
    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      // initialTime: TimeOfDay.now(),

      initialTime: isStartTime
          ? TimeOfDay(
              hour: int.parse(_startTime.split(":")[0]),
              minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
            )
          : TimeOfDay(
              hour: int.parse(_endTime.split(":")[0]) + int.parse("12"),
              minute: int.parse(_endTime.split(":")[1].split(" ")[0]),
            ),
    );
  }

  void _validateData() {
    bool abovePresentDay =
        selectedDate.isBefore(DateTime.now().subtract(const Duration(days: 1)));

    if (_titleController.text.isNotEmpty &&
        _noteController.text.isNotEmpty &&
        !abovePresentDay) {
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
    } else if (abovePresentDay) {
      Get.snackbar(
        "Error",
        "Date must be present day or greater",
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
    int value = await _taskController.addTask(
        task: Task(
      title: _titleController.text,
      note: _noteController.text,
      date: DateFormat.yMd().format(selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      color: _selectedColor,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
    ));
    print("My Id is $value");
  }
}

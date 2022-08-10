import 'package:flutter/material.dart';
import 'package:flutter_todo_list/const/styles.dart';
import 'package:flutter_todo_list/const/theme.dart';
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
  DateTime selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now());

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
              const MyInputField(title: "Title", hint: "Enter your task title"),
              const MyInputField(title: "Note", hint: "Enter your task note"),
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
}

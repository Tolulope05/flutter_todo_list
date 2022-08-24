import 'package:flutter/material.dart';
import 'package:flutter_todo_list/const/styles.dart';
import 'package:flutter_todo_list/const/theme.dart';
import 'package:flutter_todo_list/controllers/task_controller.dart';
import 'package:flutter_todo_list/models/task.dart';
import 'package:flutter_todo_list/screens/update_task_bar.dart';
import 'package:flutter_todo_list/services/fingerprint_services.dart';
import 'package:flutter_todo_list/services/notification_services.dart';
import 'package:flutter_todo_list/services/theme_services.dart';
import 'package:flutter_todo_list/widgets/button.dart';
import 'package:flutter_todo_list/widgets/task_tile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import '../services/screenLock_services.dart';
import 'add_task_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late NotifyHelper notifyHelper;
  late FingerPrintServices fingerPrintServices;
  DateTime selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  bool _secured = false;
  @override
  void initState() {
    notifyHelper = NotifyHelper();
    notifyHelper.initalizeNotification();
    notifyHelper.requestIOSPermission();
    fingerPrintServices = FingerPrintServices();
    bool authValue = fingerPrintServices.loadPrintFromBox();
    setState(() {
      _secured = authValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // convert time to month date, year
    // String _convertTimeToMonthDate(DateTime time) {
    //   return '${time.month}/${time.day}/${time.year}';
    // } // I used intl package instead.

    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          _showTask(),
        ],
      ),
      drawer: _drawer(),
    );
  }

  Container _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, top: 20, bottom: 15),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 70,
        initialSelectedDate: DateTime.now(),
        selectionColor: primarycolor,
        selectedTextColor: const Color.fromRGBO(255, 255, 255, 1),
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        onDateChange: (date) {
          selectedDate = date;
          setState(() {});
          // print("${DateFormat.yMMMd().format(selectedDate)} Selected");
          print(selectedDate);
        },
      ),
    );
  }

  Container _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(
                  DateTime.now(),
                ),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              ),
            ],
          ),
          MyButton(
            label: "+ Add Task",
            onTap: () async {
              await Get.to(() => const AddTaskPage());
              _taskController.getTasks(); // refresh task list
            },
          )
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      title: Text(
        "TODO",
        style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              ThemeServies().switchtheme();
              notifyHelper.displayNotification(
                title: "Theme Changed",
                body: Get.isDarkMode
                    ? "Light Mode activated!"
                    : "Dark Mode activated!",
              );
              setState(() {});
            },
            icon: Icon(
              Get.isDarkMode
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        )
      ],
    );
  }

  _showTask() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            Task task = _taskController.taskList[index];
            print(task.toJson());
            // convert string to DateTime.
            DateTime date = DateFormat.jm().parse(task.startTime);
            String mmDdYyyy = task.date;
            DateTime day = DateFormat.yMd().parse(mmDdYyyy);
            var mytime = DateFormat("HH:mm").format(date); //get Time from date
            print(day.weekday);
            // THIS INTURN TURNS 04:17 PM to 16:17
            notifyHelper.displayScheduledNotification(
                day: int.parse(mmDdYyyy.split("/")[1]),
                task: task,
                hour: int.parse(mytime.split(":").first),
                minute: int.parse(mytime.split(":").last));
            // Daily repeated tasks
            if (task.repeat == "Daily") {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showBottomSheet(
                        context,
                        task: task,
                      );
                    },
                    child: TaskTile(task: task),
                  )
                ],
              );
            } // selected Date tasks
            // Task display once in 7 days
            else if (task.repeat == "Weekly") {
              if (day.weekday == selectedDate.weekday) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showBottomSheet(
                          context,
                          task: task,
                        );
                      },
                      child: TaskTile(task: task),
                    )
                  ],
                );
              }
            } // selected Date tasks
            else if (task.repeat == "Monthly") {
              if (day.day == selectedDate.day) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showBottomSheet(
                          context,
                          task: task,
                        );
                      },
                      child: TaskTile(task: task),
                    )
                  ],
                );
              }
            } // selected Date tasks
            else if (task.repeat == "Yearly") {
              if (day.day == selectedDate.day &&
                  day.month == selectedDate.month) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showBottomSheet(
                          context,
                          task: task,
                        );
                      },
                      child: TaskTile(task: task),
                    )
                  ],
                );
              }
            }
            // Matching days task!
            if (task.date == DateFormat.yMd().format(selectedDate)) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showBottomSheet(
                        context,
                        task: task,
                      );
                    },
                    child: TaskTile(task: task),
                  )
                ],
              );
            } else {
              return Container();
            } // Matching days task!
          },
        );
      }),
    );
  }

  void _showBottomSheet(BuildContext context, {required Task task}) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * .24
            : MediaQuery.of(context).size.height * .32,
        color: Get.isDarkMode ? darkGreyColor : white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    context: context,
                    label: "Task Completed",
                    onTap: () {
                      _taskController.updateCompletedStatus(id: task.id);
                      Get.back();
                    },
                    color: primarycolor,
                  ),
            _bottomSheetButton(
              context: context,
              label: "Delete Task",
              onTap: () {
                _taskController.deleteTask(
                  id: task.id,
                );
                Get.back();
              },
              color: Colors.red[300]!,
            ),
            const SizedBox(height: 10),
            _bottomSheetButton(
              context: context,
              label: "Edit Task",
              isClose: true,
              onTap: () {
                Get.back();
                Get.to(() => UpdateTaskPage(task: task));
              },
              color: white,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton(
      {required String label,
      required Function() onTap,
      required Color color,
      required BuildContext context,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: isClose ? white : color,
          border: Border.all(
            width: 1.0,
            color: isClose ? greyColor : color,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle.copyWith(
                    fontSize: 16,
                    color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[500],
                  )
                : titleStyle.copyWith(color: white, fontSize: 14),
          ),
        ),
      ),
    );
  }

  Drawer _drawer() {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("TODO"),
            accountEmail: Text("Plan your task and make note!"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
          ),
          ListTile(
            title: const Text(
              "Clear All Task",
            ),
            leading: const Icon(Icons.delete),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Are you sure you?"),
                  content:
                      const Text("All Task once deleted cannot be recovered!"),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            _taskController.deleteAllTasks();
                            Get.back();
                            Get.snackbar("", "Task deleted successfully");
                          },
                          child: const Text("Yes"),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              "Secure App",
            ),
            leading: const Icon(Icons.fingerprint),
            onTap: () {},
            subtitle: const Text("Enable Finger Print"),
            trailing: Switch(
              activeColor: bluishColor,
              value: _secured,
              onChanged: (value) async {
                bool? returnValue = await ScreenLock(ctx: context)
                    .authenticateUser(authState: value);
                setState(() {
                  _secured = returnValue!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

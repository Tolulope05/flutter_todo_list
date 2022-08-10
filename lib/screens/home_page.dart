import 'package:flutter/material.dart';
import 'package:flutter_todo_list/const/styles.dart';
import 'package:flutter_todo_list/services/notification_services.dart';
import 'package:flutter_todo_list/services/theme_services.dart';
import 'package:flutter_todo_list/widgets/button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    notifyHelper = NotifyHelper();
    notifyHelper.initalizeNotification();
    notifyHelper.requestIOSPermission();

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
        ],
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
              Text("Today", style: headingStyle)
            ],
          ),
          MyButton(
            label: "+ Add Task",
            onTap: () {},
          )
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            // Get.isDarkMode
            //     ? Get.changeTheme(Themes.light(context))
            //     : Get.changeTheme(Themes.dark(context));
            ThemeServies().switchtheme();
            notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Light Mode activated!"
                  : "Dark Mode activated!",
            );
            notifyHelper.displayScheduledNotification(
              title: "Wake up",
              body: "Time to read!",
            );
            setState(() {});
          },
          icon: Icon(
            Get.isDarkMode
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          )),
      title: const Text("TODO LIST"),
      centerTitle: true,
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
}
